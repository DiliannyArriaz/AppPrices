using HtmlAgilityPack;
using PriceTrackerApp.Models;
using System.Text.RegularExpressions;
using System.Text.Json;

namespace PriceTrackerApp.Services
{
    public class PriceScrapingService : IDisposable
    {
        private readonly HttpClient _httpClient;
        private string _lastDebugInfo = "";

        public PriceScrapingService()
        {
            _httpClient = new HttpClient();
            _httpClient.DefaultRequestHeaders.Add("User-Agent", 
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36");
        }

        public string GetLastDebugInfo()
        {
            return _lastDebugInfo;
        }

        public async Task<List<ProductOffer>> SearchProductsAsync(string searchTerm, bool searchDiaOnline, bool searchCarrefour, bool searchJumbo, List<string> debugInfo)
        {
            var results = new List<ProductOffer>();
            var seenProducts = new HashSet<string>(); // Para evitar duplicados
            
            try
            {
                Console.WriteLine($"🚀 INICIANDO BÚSQUEDA: {searchTerm}");
                Console.WriteLine($"📋 Tiendas seleccionadas - DiaOnline: {searchDiaOnline}, Carrefour: {searchCarrefour}, Jumbo: {searchJumbo}");
                
                var tasks = new List<Task<List<ProductOffer>>>();
                
                if (searchDiaOnline)
                    tasks.Add(SearchDiaOnlineRealAsync(searchTerm));
                
                if (searchCarrefour)
                    tasks.Add(SearchCarrefourRealAsync(searchTerm));
                
                if (searchJumbo)
                    tasks.Add(SearchJumboRealAsync(searchTerm));
                
                var allResults = await Task.WhenAll(tasks);
                
                foreach (var storeResults in allResults)
                {
                    results.AddRange(storeResults);
                }
                
                Console.WriteLine($"📊 Productos encontrados en APIs reales: {results.Count}");
                
                // Si no hay resultados de las APIs reales, usar productos demo
                if (results.Count == 0)
                {
                    Console.WriteLine("⚠️ No se encontraron productos reales, usando productos demo...");
                    
                    if (searchDiaOnline)
                        results.AddRange(GetDemoProductsDiaOnline(searchTerm));
                    
                    if (searchCarrefour)
                        results.AddRange(GetDemoProductsCarrefour(searchTerm));
                    
                    if (searchJumbo)
                        results.AddRange(GetDemoProductsJumbo(searchTerm));
                        
                    Console.WriteLine($"📦 Productos demo agregados: {results.Count}");
                }
                
                Console.WriteLine($"✅ BÚSQUEDA COMPLETADA - Total productos: {results.Count}");
                return results.OrderBy(r => r.PriceValue).ToList();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ ERROR en búsqueda: {ex.Message}");
                return results;
            }
        }

        private List<ProductOffer> GetDemoProductsDiaOnline(string searchTerm)
        {
            var products = new Dictionary<string, List<ProductOffer>>
            {
                ["atun"] = new List<ProductOffer>
                {
                    new ProductOffer { ProductName = "Atún Gomes da Costa en Aceite x 170g", Store = "Día Online", Price = "$890", PriceValue = 890 },
                    new ProductOffer { ProductName = "Atún La Campagnola al Natural x 170g", Store = "Día Online", Price = "$750", PriceValue = 750 },
                    new ProductOffer { ProductName = "Atún Calvo en Aceite x 160g", Store = "Día Online", Price = "$1.200", PriceValue = 1200 }
                },
                ["morixe"] = new List<ProductOffer>
                {
                    new ProductOffer { ProductName = "Harina Morixe 000 x 1kg", Store = "Día Online", Price = "$680", PriceValue = 680 },
                    new ProductOffer { ProductName = "Harina Morixe Leudante x 1kg", Store = "Día Online", Price = "$720", PriceValue = 720 },
                    new ProductOffer { ProductName = "Premezcla Morixe para Tortas x 500g", Store = "Día Online", Price = "$1.150", PriceValue = 1150 },
                    new ProductOffer { ProductName = "Avena Instantánea Morixe 400g", Store = "Día Online", Price = "$1.460", PriceValue = 1460, OriginalPrice = 1590, OriginalPriceText = "$1.590", DiscountPercentage = 8, HasDiscount = true, DiscountText = "8% OFF" },
                    new ProductOffer { ProductName = "Harina Morixe Integral x 1kg", Store = "Día Online", Price = "$750", PriceValue = 750 },
                    new ProductOffer { ProductName = "Premezcla Morixe Brownie x 480g", Store = "Día Online", Price = "$1.280", PriceValue = 1280 },
                    new ProductOffer { ProductName = "Harina Morixe 0000 x 1kg", Store = "Día Online", Price = "$695", PriceValue = 695 }
                },
                ["leche"] = new List<ProductOffer>
                {
                    new ProductOffer { ProductName = "Leche La Serenísima Entera x 1L", Store = "Día Online", Price = "$850", PriceValue = 850 },
                    new ProductOffer { ProductName = "Leche Sancor Descremada x 1L", Store = "Día Online", Price = "$820", PriceValue = 820 }
                },
                ["pan"] = new List<ProductOffer>
                {
                    new ProductOffer { ProductName = "Pan Lactal Bimbo x 450g", Store = "Día Online", Price = "$950", PriceValue = 950 },
                    new ProductOffer { ProductName = "Pan Integral Fargo x 400g", Store = "Día Online", Price = "$1.100", PriceValue = 1100 }
                },
                ["arroz"] = new List<ProductOffer>
                {
                    new ProductOffer { ProductName = "Arroz Gallo Oro x 1kg", Store = "Día Online", Price = "$1.200", PriceValue = 1200 },
                    new ProductOffer { ProductName = "Arroz Marolio x 1kg", Store = "Día Online", Price = "$980", PriceValue = 980 }
                }
            };

            var searchKey = searchTerm.ToLower().Trim();
            
            // Buscar coincidencias exactas primero
            if (products.ContainsKey(searchKey))
                return products[searchKey];
            
            // Buscar coincidencias parciales
            var partialMatches = new List<ProductOffer>();
            foreach (var category in products)
            {
                if (category.Key.Contains(searchKey) || searchKey.Contains(category.Key))
                {
                    partialMatches.AddRange(category.Value);
                }
            }
            
            if (partialMatches.Any())
                return partialMatches;

            // Si no hay coincidencias, crear productos genéricos
            return new List<ProductOffer>
            {
                new ProductOffer 
                { 
                    ProductName = $"{searchTerm} - Marca Premium", 
                    Store = "Día Online", 
                    Price = "$1.250", 
                    PriceValue = 1250 
                },
                new ProductOffer 
                { 
                    ProductName = $"{searchTerm} - Marca Económica", 
                    Store = "Día Online", 
                    Price = "$890", 
                    PriceValue = 890 
                }
            };
        }

        private List<ProductOffer> GetDemoProductsCarrefour(string searchTerm)
        {
            var products = new Dictionary<string, List<ProductOffer>>
            {
                ["atun"] = new List<ProductOffer>
                {
                    new ProductOffer { ProductName = "Atún Gomes da Costa en Aceite x 170g", Store = "Carrefour", Price = "$920", PriceValue = 920 },
                    new ProductOffer { ProductName = "Atún La Campagnola al Natural x 170g", Store = "Carrefour", Price = "$780", PriceValue = 780 },
                    new ProductOffer { ProductName = "Atún Carrefour en Aceite x 160g", Store = "Carrefour", Price = "$650", PriceValue = 650 }
                },
                ["morixe"] = new List<ProductOffer>
                {
                    new ProductOffer { ProductName = "Harina Morixe 000 x 1kg", Store = "Carrefour", Price = "$695", PriceValue = 695 },
                    new ProductOffer { ProductName = "Harina Morixe Leudante x 1kg", Store = "Carrefour", Price = "$740", PriceValue = 740 },
                    new ProductOffer { ProductName = "Premezcla Morixe para Budín x 480g", Store = "Carrefour", Price = "$1.080", PriceValue = 1080 },
                    new ProductOffer { ProductName = "Avena Instantánea Morixe 400g", Store = "Carrefour", Price = "$1.480", PriceValue = 1480, OriginalPrice = 1620, OriginalPriceText = "$1.620", DiscountPercentage = 9, HasDiscount = true, DiscountText = "9% OFF" },
                    new ProductOffer { ProductName = "Harina Morixe Integral x 1kg", Store = "Carrefour", Price = "$780", PriceValue = 780 },
                    new ProductOffer { ProductName = "Premezcla Morixe Vainilla x 500g", Store = "Carrefour", Price = "$1.150", PriceValue = 1150 }
                },
                ["leche"] = new List<ProductOffer>
                {
                    new ProductOffer { ProductName = "Leche La Serenísima Entera x 1L", Store = "Carrefour", Price = "$870", PriceValue = 870 },
                    new ProductOffer { ProductName = "Leche Carrefour Descremada x 1L", Store = "Carrefour", Price = "$750", PriceValue = 750 }
                },
                ["pan"] = new List<ProductOffer>
                {
                    new ProductOffer { ProductName = "Pan Lactal Bimbo x 450g", Store = "Carrefour", Price = "$980", PriceValue = 980 },
                    new ProductOffer { ProductName = "Pan Integral Carrefour x 400g", Store = "Carrefour", Price = "$850", PriceValue = 850 }
                },
                ["arroz"] = new List<ProductOffer>
                {
                    new ProductOffer { ProductName = "Arroz Gallo Oro x 1kg", Store = "Carrefour", Price = "$1.180", PriceValue = 1180 },
                    new ProductOffer { ProductName = "Arroz Carrefour x 1kg", Store = "Carrefour", Price = "$890", PriceValue = 890 }
                }
            };

            var searchKey = searchTerm.ToLower().Trim();
            
            if (products.ContainsKey(searchKey))
                return products[searchKey];
            
            var partialMatches = new List<ProductOffer>();
            foreach (var category in products)
            {
                if (category.Key.Contains(searchKey) || searchKey.Contains(category.Key))
                {
                    partialMatches.AddRange(category.Value);
                }
            }
            
            if (partialMatches.Any())
                return partialMatches;

            return new List<ProductOffer>
            {
                new ProductOffer 
                { 
                    ProductName = $"{searchTerm} - Marca Premium", 
                    Store = "Carrefour", 
                    Price = "$1.180", 
                    PriceValue = 1180 
                },
                new ProductOffer 
                { 
                    ProductName = $"{searchTerm} - Marca Carrefour", 
                    Store = "Carrefour", 
                    Price = "$820", 
                    PriceValue = 820 
                }
            };
        }

        private List<ProductOffer> GetDemoProductsJumbo(string searchTerm)
        {
            var products = new Dictionary<string, List<ProductOffer>>
            {
                ["atun"] = new List<ProductOffer>
                {
                    new ProductOffer { ProductName = "Atún Gomes da Costa en Aceite x 170g", Store = "Jumbo", Price = "$950", PriceValue = 950 },
                    new ProductOffer { ProductName = "Atún La Campagnola al Natural x 170g", Store = "Jumbo", Price = "$790", PriceValue = 790 },
                    new ProductOffer { ProductName = "Atún Jumbo en Aceite x 160g", Store = "Jumbo", Price = "$680", PriceValue = 680 }
                },
                ["morixe"] = new List<ProductOffer>
                {
                    new ProductOffer { ProductName = "Harina Morixe 000 x 1kg", Store = "Jumbo", Price = "$710", PriceValue = 710 },
                    new ProductOffer { ProductName = "Harina Morixe Leudante x 1kg", Store = "Jumbo", Price = "$750", PriceValue = 750 },
                    new ProductOffer { ProductName = "Premezcla Morixe Vainilla x 500g", Store = "Jumbo", Price = "$1.200", PriceValue = 1200 },
                    new ProductOffer { ProductName = "Avena Instantánea Morixe 400g", Store = "Jumbo", Price = "$1.520", PriceValue = 1520, OriginalPrice = 1650, OriginalPriceText = "$1.650", DiscountPercentage = 8, HasDiscount = true, DiscountText = "8% OFF" },
                    new ProductOffer { ProductName = "Harina Morixe Integral x 1kg", Store = "Jumbo", Price = "$790", PriceValue = 790 },
                    new ProductOffer { ProductName = "Premezcla Morixe Chocolate x 480g", Store = "Jumbo", Price = "$1.320", PriceValue = 1320 }
                },
                ["leche"] = new List<ProductOffer>
                {
                    new ProductOffer { ProductName = "Leche La Serenísima Entera x 1L", Store = "Jumbo", Price = "$880", PriceValue = 880 },
                    new ProductOffer { ProductName = "Leche Sancor Descremada x 1L", Store = "Jumbo", Price = "$840", PriceValue = 840 }
                },
                ["pan"] = new List<ProductOffer>
                {
                    new ProductOffer { ProductName = "Pan Lactal Bimbo x 450g", Store = "Jumbo", Price = "$970", PriceValue = 970 },
                    new ProductOffer { ProductName = "Pan Integral Jumbo x 400g", Store = "Jumbo", Price = "$890", PriceValue = 890 }
                },
                ["arroz"] = new List<ProductOffer>
                {
                    new ProductOffer { ProductName = "Arroz Gallo Oro x 1kg", Store = "Jumbo", Price = "$1.220", PriceValue = 1220 },
                    new ProductOffer { ProductName = "Arroz Marolio x 1kg", Store = "Jumbo", Price = "$1.050", PriceValue = 1050 }
                }
            };

            var searchKey = searchTerm.ToLower().Trim();
            
            if (products.ContainsKey(searchKey))
                return products[searchKey];
            
            var partialMatches = new List<ProductOffer>();
            foreach (var category in products)
            {
                if (category.Key.Contains(searchKey) || searchKey.Contains(category.Key))
                {
                    partialMatches.AddRange(category.Value);
                }
            }
            
            if (partialMatches.Any())
                return partialMatches;

            return new List<ProductOffer>
            {
                new ProductOffer 
                { 
                    ProductName = $"{searchTerm} - Marca Premium", 
                    Store = "Jumbo", 
                    Price = "$1.320", 
                    PriceValue = 1320 
                },
                new ProductOffer 
                { 
                    ProductName = $"{searchTerm} - Marca Jumbo", 
                    Store = "Jumbo", 
                    Price = "$950", 
                    PriceValue = 950 
                }
            };
        }

        private async Task<List<ProductOffer>> SearchDiaOnlineRealAsync(string searchTerm)
        {
            var results = new List<ProductOffer>();
            var debugInfo = new List<string>();
            
            try
            {
                debugInfo.Add($"🔍 Buscando en Día Online: {searchTerm}");
                
                // Método 1: Intentar con la API
                var apiResults = await SearchDiaOnlineAPIAsync(searchTerm, debugInfo);
                results.AddRange(apiResults);
                
                // Método 2: Si la API devuelve pocos resultados relevantes, usar scraping directo
                var relevantResults = results.Where(r => ContainsSearchTerm(r.ProductName, searchTerm)).ToList();
                debugInfo.Add($"📊 API devolvió {results.Count} productos, {relevantResults.Count} relevantes");
                
                if (relevantResults.Count <= 1)
                {
                    debugInfo.Add("🌐 Pocos resultados relevantes de API, intentando scraping directo...");
                    var scrapingResults = await SearchDiaOnlineDirectAsync(searchTerm, debugInfo);
                    results.AddRange(scrapingResults);
                }
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error en Día Online: {ex.Message}");
            }
            
            // Guardar info de debug para mostrar en la UI
            _lastDebugInfo = string.Join("\n", debugInfo);
            
            return results;
        }

        private async Task<List<ProductOffer>> SearchDiaOnlineAPIAsync(string searchTerm, List<string> debugInfo)
        {
            var results = new List<ProductOffer>();
            
            try
            {
                // Log the search URL
                var searchUrl = $"https://diaonline.supermercadosdia.com.ar/api/catalog_system/pub/products/search?q={Uri.EscapeDataString(searchTerm)}&_from=0&_to=20";
                debugInfo.Add($"🔍 Búsqueda en Día Online API: {searchUrl}");
                
                // Configurar headers adicionales para evitar detección de bot
                var request = new HttpRequestMessage(HttpMethod.Get, searchUrl);
                
                request.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
                request.Headers.Add("Accept", "application/json");
                request.Headers.Add("Accept-Language", "es-AR,es;q=0.9");
                request.Headers.Add("Referer", "https://diaonline.supermercadosdia.com.ar/");
                request.Headers.Add("Origin", "https://diaonline.supermercadosdia.com.ar");
                
                // Log request details
                var requestHeaders = string.Join("\n", request.Headers
                    .Select(h => $"  {h.Key}: {string.Join(", ", h.Value)}"));
                debugInfo.Add($"📤 Request Headers:\n{requestHeaders}");
                debugInfo.Add($"🌐 Request URL: {request.RequestUri}");
                
                // Send the request
                using (var response = await _httpClient.SendAsync(request))
                {
                    var responseContent = await response.Content.ReadAsStringAsync();
                    
                    // Log response details
                    var responseHeaders = string.Join("\n", response.Headers
                        .Select(h => $"  {h.Key}: {string.Join(", ", h.Value)}"));
                    debugInfo.Add($"📥 Response Status: {(int)response.StatusCode} {response.ReasonPhrase}");
                    debugInfo.Add($"📥 Response Headers:\n{responseHeaders}");
                    
                    // Save response for debugging
                    var tempPath = Path.Combine(FileSystem.CacheDirectory, "dia_response.json");
                    await File.WriteAllTextAsync(tempPath, responseContent);
                    debugInfo.Add($"📄 Response saved to: {tempPath}");
                    
                    if (!response.IsSuccessStatusCode)
                    {
                        debugInfo.Add($"❌ Error en la respuesta: {response.StatusCode} - {response.ReasonPhrase}");
                        debugInfo.Add($"📄 Contenido de la respuesta (first 1000 chars):\n{(responseContent.Length > 1000 ? responseContent.Substring(0, 1000) : responseContent)}");
                        return results;
                    }
                    
                    // Log first 500 characters of response for quick inspection
                    debugInfo.Add($"📄 Response preview (first 500 chars):\n{(responseContent.Length > 500 ? responseContent.Substring(0, 500) + "..." : responseContent)}");
                    
                    // Try to deserialize the JSON response
                    try
                    {
                        debugInfo.Add("🔍 Intentando deserializar la respuesta JSON...");
                        using (JsonDocument doc = JsonDocument.Parse(responseContent))
                        {
                            var root = doc.RootElement;
                            debugInfo.Add($"✅ JSON deserializado. Tipo: {root.ValueKind}");
                            
                            if (root.ValueKind != JsonValueKind.Array)
                            {
                                debugInfo.Add($"❌ Se esperaba un array JSON pero se recibió: {root.ValueKind}");
                                return results;
                            }
                            
                            debugInfo.Add($"📦 Total de productos en la respuesta: {root.GetArrayLength()}");
                            
                            foreach (var product in root.EnumerateArray())
                            {
                                try
                                {
                                    // Extract product name
                                    string name = product.TryGetProperty("productName", out var nameProp) 
                                        ? nameProp.GetString() ?? "[Sin nombre]" 
                                        : "[Sin nombre]";
                                    
                                    // Extract price, original price, and availability
                                    string price = null;
                                    string originalPrice = null;
                                    decimal discountPercentage = 0;
                                    bool isAvailable = false;
                                    
                                    if (product.TryGetProperty("items", out var items) && items.ValueKind == JsonValueKind.Array && items.GetArrayLength() > 0)
                                    {
                                        var firstItem = items[0];
                                        if (firstItem.TryGetProperty("sellers", out var sellers) && 
                                            sellers.ValueKind == JsonValueKind.Array && 
                                            sellers.GetArrayLength() > 0)
                                        {
                                            var firstSeller = sellers[0];
                                            if (firstSeller.TryGetProperty("commertialOffer", out var offer))
                                            {
                                                // Get current price
                                                if (offer.TryGetProperty("Price", out var priceProp) && 
                                                    priceProp.ValueKind != JsonValueKind.Null)
                                                {
                                                    price = priceProp.GetDecimal().ToString("0.00", System.Globalization.CultureInfo.InvariantCulture);
                                                }
                                                
                                                // Get original price (list price)
                                                if (offer.TryGetProperty("ListPrice", out var listPriceProp) && 
                                                    listPriceProp.ValueKind != JsonValueKind.Null)
                                                {
                                                    var listPriceValue = listPriceProp.GetDecimal();
                                                    if (listPriceValue > 0)
                                                    {
                                                        originalPrice = listPriceValue.ToString("0.00", System.Globalization.CultureInfo.InvariantCulture);
                                                        
                                                        // Calculate discount percentage
                                                        if (decimal.TryParse(price, out var currentPriceValue) && currentPriceValue > 0)
                                                        {
                                                            discountPercentage = Math.Round(((listPriceValue - currentPriceValue) / listPriceValue) * 100, 0);
                                                        }
                                                    }
                                                }
                                                
                                                // Check availability
                                                if (offer.TryGetProperty("IsAvailable", out var availableProp) && 
                                                    availableProp.ValueKind == JsonValueKind.True)
                                                {
                                                    isAvailable = true;
                                                }
                                            }
                                        }
                                    }
                                    
                                    debugInfo.Add($"🔍 Producto: {name} | Precio: {price ?? "N/A"} | Original: {originalPrice ?? "N/A"} | Desc: {discountPercentage}% | Disponible: {isAvailable}");
                                    
                                    if (!string.IsNullOrEmpty(name) && !string.IsNullOrEmpty(price))
                                    {
                                        // Only add products that match the search term
                                        if (ContainsSearchTerm(name, searchTerm))
                                        {
                                            if (decimal.TryParse(price, System.Globalization.NumberStyles.Any, 
                                                System.Globalization.CultureInfo.InvariantCulture, out decimal priceValue))
                                            {
                                                // Parse original price
                                                decimal originalPriceValue = 0;
                                                if (!string.IsNullOrEmpty(originalPrice))
                                                {
                                                    decimal.TryParse(originalPrice, System.Globalization.NumberStyles.Any, 
                                                        System.Globalization.CultureInfo.InvariantCulture, out originalPriceValue);
                                                }
                                                
                                                // Build product URL
                                                string productUrl = "https://diaonline.supermercadosdia.com.ar";
                                                
                                                if (product.TryGetProperty("linkText", out var linkText) && 
                                                    !string.IsNullOrWhiteSpace(linkText.GetString()))
                                                {
                                                    string link = linkText.GetString();
                                                    productUrl += link.StartsWith("/") ? $"{link}/p" : $"/{link}/p";
                                                }
                                                else
                                                {
                                                    // Fallback: build URL from product name
                                                    var slug = System.Text.RegularExpressions.Regex.Replace(
                                                        name.ToLower(), 
                                                        "[^a-z0-9]+", "-");
                                                    productUrl += $"/{slug}/p";
                                                }
                                                
                                                // Check for special promotions
                                                bool hasSpecialPromotion = false;
                                                string promotionText = "";
                                                
                                                // Look for promotion information in the product data
                                                if (product.TryGetProperty("productClusters", out var clusters) && clusters.ValueKind == JsonValueKind.Object)
                                                {
                                                    foreach (var cluster in clusters.EnumerateObject())
                                                    {
                                                        var clusterValue = cluster.Value.GetString()?.ToLower() ?? "";
                                                        if (clusterValue.Contains("2do") && clusterValue.Contains("50"))
                                                        {
                                                            hasSpecialPromotion = true;
                                                            promotionText = "2do al 50%";
                                                            break;
                                                        }
                                                        else if (clusterValue.Contains("segunda") && clusterValue.Contains("50"))
                                                        {
                                                            hasSpecialPromotion = true;
                                                            promotionText = "2do al 50%";
                                                            break;
                                                        }
                                                    }
                                                }
                                                
                                                // Also check in product name for promotions
                                                if (!hasSpecialPromotion)
                                                {
                                                    var nameLower = name.ToLower();
                                                    if ((nameLower.Contains("2do") || nameLower.Contains("segunda")) && nameLower.Contains("50"))
                                                    {
                                                        hasSpecialPromotion = true;
                                                        promotionText = "2do al 50%";
                                                    }
                                                }
                                                
                                                // Determine if there's a discount
                                                bool hasDiscount = originalPriceValue > priceValue && discountPercentage > 0;
                                                
                                                results.Add(new ProductOffer
                                                {
                                                    ProductName = name,
                                                    Store = "Día Online",
                                                    Price = $"${priceValue:N0}",
                                                    PriceValue = priceValue,
                                                    ProductUrl = productUrl,
                                                    IsAvailable = isAvailable,
                                                    AvailabilityText = isAvailable ? "Disponible" : "Sin stock",
                                                    OriginalPrice = originalPriceValue,
                                                    OriginalPriceText = originalPriceValue > 0 ? $"${originalPriceValue:N0}" : "",
                                                    DiscountPercentage = (int)discountPercentage,
                                                    HasDiscount = hasDiscount,
                                                    DiscountText = hasDiscount ? $"{discountPercentage:F0}% OFF" : "",
                                                    HasSpecialPromotion = hasSpecialPromotion,
                                                    PromotionText = promotionText
                                                });
                                                
                                                debugInfo.Add($"✅ API Coincidencia: {name} - Descuento: {hasDiscount} ({discountPercentage}%)");
                                            }
                                        }
                                        else
                                        {
                                            debugInfo.Add($"❌ API No coincide: {name}");
                                        }
                                    }
                                }
                                catch (Exception ex)
                                {
                                    debugInfo.Add($"❌ Error procesando producto: {ex.Message}");
                                }
                            }
                            
                            debugInfo.Add($"📊 Total productos agregados de API: {results.Count}");
                        }
                    }
                    catch (Exception jsonEx)
                    {
                        debugInfo.Add($"❌ Error al analizar la respuesta JSON: {jsonEx.Message}");
                        debugInfo.Add($"📄 Contenido del error: {jsonEx}");
                    }
                }
                
                return results;
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error en la API de Día Online: {ex.Message}");
                return results;
            }
        }

        private async Task<List<ProductOffer>> SearchDiaOnlineDirectAsync(string searchTerm, List<string> debugInfo)
        {
            var results = new List<ProductOffer>();
            var seenProducts = new HashSet<string>(); // Para evitar duplicados en HTML scraping
            
            try
            {
                // Scraping directo de la página de búsqueda
                var searchUrl = $"https://diaonline.supermercadosdia.com.ar/{Uri.EscapeDataString(searchTerm.ToLower())}";
                debugInfo.Add($" Scraping directo: {searchUrl}");
                
                var request = new HttpRequestMessage(HttpMethod.Get, searchUrl);
                request.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
                request.Headers.Add("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
                request.Headers.Add("Accept-Language", "es-AR,es;q=0.9");
                request.Headers.Add("Referer", "https://diaonline.supermercadosdia.com.ar/");
                
                var response = await _httpClient.SendAsync(request);
                debugInfo.Add($" Scraping status: {response.StatusCode}");
                
                if (response.IsSuccessStatusCode)
                {
                    var htmlContent = await response.Content.ReadAsStringAsync();
                    
                    // Usar HtmlAgilityPack para parsear el HTML
                    var doc = new HtmlDocument();
                    doc.LoadHtml(htmlContent);
                    
                    // Buscar productos con selectores específicos para Día Online
                    var productNodes = doc.DocumentNode.SelectNodes("//div[contains(@class, 'vtex-product-summary')] | //div[contains(@class, 'product-item')] | //article[contains(@class, 'product')] | //li[contains(@class, 'product')] | //div[@data-testid] | //*[contains(@class, 'shelf')] | //*[contains(@class, 'gallery')] | //*[contains(@class, 'search-result')]//div");
                    
                    debugInfo.Add($"📄 HTML recibido: {htmlContent.Length} caracteres");
                    debugInfo.Add($"🔍 Buscando productos en HTML...");
                    
                    if (productNodes != null && productNodes.Count > 0)
                    {
                        debugInfo.Add($"✅ Nodos encontrados: {productNodes.Count}");
                        
                        // Primero intentar encontrar productos con estructura más simple
                        var simpleProductNodes = doc.DocumentNode.SelectNodes("//div[.//span[contains(text(), '$')] and (.//h1 or .//h2 or .//h3 or .//a)]");
                        if (simpleProductNodes != null && simpleProductNodes.Count > 0)
                        {
                            debugInfo.Add($"🎯 Productos con precios: {simpleProductNodes.Count}");
                            productNodes = simpleProductNodes;
                        }
                        else
                        {
                            debugInfo.Add($"⚠️ No se encontraron productos con precios, usando nodos originales");
                        }
                        
                        foreach (var productNode in productNodes.Take(15))
                        {
                            try
                            {
                                // Extraer nombre del producto con selectores más específicos
                                var nameNode = productNode.SelectSingleNode(".//h3[not(contains(text(), '$'))] | .//h2[not(contains(text(), '$'))] | .//h1[not(contains(text(), '$'))] | .//span[contains(@class, 'name') and not(contains(text(), '$'))] | .//a[contains(@class, 'name') and not(contains(text(), '$'))] | .//div[contains(@class, 'name') and not(contains(text(), '$'))]");
                                var name = nameNode?.InnerText?.Trim() ?? nameNode?.GetAttributeValue("title", "")?.Trim();
                                
                                // Limpiar el nombre de precios y caracteres no deseados
                                if (!string.IsNullOrEmpty(name))
                                {
                                    // Remover precios del nombre
                                    name = System.Text.RegularExpressions.Regex.Replace(name, @"\$\s*\d+[.,]?\d*", "").Trim();
                                    // Remover porcentajes
                                    name = System.Text.RegularExpressions.Regex.Replace(name, @"-?\d+%", "").Trim();
                                    // Remover texto como "AHORA"
                                    name = System.Text.RegularExpressions.Regex.Replace(name, @"\b(AHORA|OFF)\b", "", System.Text.RegularExpressions.RegexOptions.IgnoreCase).Trim();
                                    // Limpiar espacios múltiples
                                    name = System.Text.RegularExpressions.Regex.Replace(name, @"\s+", " ").Trim();
                                }
                                
                                // Si no encuentra nombre limpio, buscar en texto pero filtrar mejor
                                if (string.IsNullOrEmpty(name) || name.Length < 5)
                                {
                                    var allText = productNode.InnerText?.Trim();
                                    if (!string.IsNullOrEmpty(allText) && allText.Length < 200)
                                    {
                                        var lines = allText.Split('\n', StringSplitOptions.RemoveEmptyEntries);
                                        name = lines.FirstOrDefault(l => 
                                            l.Trim().Length > 5 && 
                                            !l.Contains("$") && 
                                            !l.Contains("%") && 
                                            !l.ToUpper().Contains("AHORA") &&
                                            !l.ToUpper().Contains("OFF") &&
                                            System.Text.RegularExpressions.Regex.IsMatch(l, @"[a-zA-Z]"))?.Trim();
                                        
                                        // Limpiar el nombre encontrado
                                        if (!string.IsNullOrEmpty(name))
                                        {
                                            name = System.Text.RegularExpressions.Regex.Replace(name, @"\$\s*\d+[.,]?\d*", "").Trim();
                                            name = System.Text.RegularExpressions.Regex.Replace(name, @"-?\d+%", "").Trim();
                                            name = System.Text.RegularExpressions.Regex.Replace(name, @"\b(AHORA|OFF)\b", "", System.Text.RegularExpressions.RegexOptions.IgnoreCase).Trim();
                                            name = System.Text.RegularExpressions.Regex.Replace(name, @"\s+", " ").Trim();
                                        }
                                    }
                                }
                                
                                // Extraer precios con mejor priorización
                                var currentPriceNode = productNode.SelectSingleNode(".//span[contains(@class, 'sellingPrice')] | .//span[contains(@class, 'price-current')] | .//span[contains(@class, 'currencyContainer')] | .//span[contains(@class, 'price') and not(contains(@class, 'original')) and not(contains(@class, 'list'))]");
                                var originalPriceNode = productNode.SelectSingleNode(".//span[contains(@class, 'price-original')] | .//span[contains(@class, 'list-price')] | .//s | .//del | .//strike");
                                var discountNode = productNode.SelectSingleNode(".//*[contains(@class, 'discount')] | .//*[contains(text(), '%') and contains(text(), 'OFF')] | .//*[contains(@class, 'percentage')]");
                                
                                var currentPriceText = currentPriceNode?.InnerText?.Trim();
                                var originalPriceText = originalPriceNode?.InnerText?.Trim();
                                var discountText = discountNode?.InnerText?.Trim();
                                
                                // Si el precio actual contiene "AHORA", extraer solo el precio después de "AHORA"
                                if (!string.IsNullOrEmpty(currentPriceText) && currentPriceText.ToUpper().Contains("AHORA"))
                                {
                                    var ahoraMatch = System.Text.RegularExpressions.Regex.Match(currentPriceText, @"AHORA\s*\$?\s*(\d+(?:[.,]\d+)*)", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
                                    if (ahoraMatch.Success)
                                    {
                                        currentPriceText = "$" + ahoraMatch.Groups[1].Value;
                                    }
                                }
                                
                                // Buscar precios de forma más inteligente
                                if (string.IsNullOrEmpty(currentPriceText))
                                {
                                    // Buscar en atributos data
                                    var priceDataNode = productNode.SelectSingleNode(".//*[@data-price] | .//*[@data-selling-price]");
                                    currentPriceText = priceDataNode?.GetAttributeValue("data-price", "") ?? priceDataNode?.GetAttributeValue("data-selling-price", "");
                                }
                                
                                if (string.IsNullOrEmpty(currentPriceText))
                                {
                                    // Buscar elementos que contengan $ pero priorizar los que NO contengan "AHORA" o porcentajes
                                    var priceNodes = productNode.SelectNodes(".//*[contains(text(), '$')]");
                                    if (priceNodes != null)
                                    {
                                        // Priorizar nodos que no contengan "AHORA" o "%"
                                        var bestPriceNode = priceNodes.FirstOrDefault(n => 
                                            !n.InnerText.ToUpper().Contains("AHORA") && 
                                            !n.InnerText.Contains("%") &&
                                            System.Text.RegularExpressions.Regex.IsMatch(n.InnerText, @"\$\s*\d{3,4}(?:[.,]\d{2})?"));
                                        
                                        currentPriceText = bestPriceNode?.InnerText?.Trim() ?? priceNodes.FirstOrDefault()?.InnerText?.Trim();
                                    }
                                }
                                
                                if (string.IsNullOrEmpty(currentPriceText))
                                {
                                    // Como último recurso, buscar en todo el texto del nodo
                                    var allText = productNode.InnerText;
                                    if (!string.IsNullOrEmpty(allText))
                                    {
                                        // Buscar patrones específicos evitando números de descuento
                                        var priceMatches = System.Text.RegularExpressions.Regex.Matches(allText, @"\$\s*(\d{3,4}(?:[.,]\d{2})?)(?!\s*%)");
                                        if (priceMatches.Count > 0)
                                        {
                                            // Tomar el primer precio que no esté seguido de %
                                            currentPriceText = priceMatches[0].Value;
                                        }
                                        else
                                        {
                                            // Buscar números que podrían ser precios (sin $)
                                            var numberMatch = System.Text.RegularExpressions.Regex.Match(allText, @"\b(\d{3,4})\b(?!\s*%)");
                                            if (numberMatch.Success)
                                            {
                                                currentPriceText = "$" + numberMatch.Groups[1].Value;
                                            }
                                        }
                                    }
                                }
                                
                                // Extraer URL del producto con selectores más específicos
                                var linkNode = productNode.SelectSingleNode(".//a[contains(@href, '/p')] | .//a[@href]");
                                var productUrl = linkNode?.GetAttributeValue("href", "");
                                
                                // Asegurar URL completa
                                if (!string.IsNullOrEmpty(productUrl) && !productUrl.StartsWith("http"))
                                {
                                    if (productUrl.StartsWith("/"))
                                        productUrl = $"https://diaonline.supermercadosdia.com.ar{productUrl}";
                                    else
                                        productUrl = $"https://diaonline.supermercadosdia.com.ar/{productUrl}";
                                }
                                
                                debugInfo.Add($"🔍 Producto: '{name}' | Precio: '{currentPriceText}' | Original: '{originalPriceText}' | Desc: '{discountText}'");
                                
                                var currentPrice = ExtractPrice(currentPriceText ?? "");
                                var originalPrice = ExtractPrice(originalPriceText ?? "");
                                var discountPercentage = ExtractDiscountPercentage(discountText ?? "");
                                
                                debugInfo.Add($"   📊 Análisis: Nombre='{name}' | PrecioTexto='{currentPriceText}' | PrecioValor={currentPrice}");
                                
                                // Solo agregar productos con nombre válido
                                if (!string.IsNullOrEmpty(name) && name.Length > 3)
                                {
                                    var isRelevant = ContainsSearchTerm(name, searchTerm);
                                    debugInfo.Add($"   🔍 ¿Relevante para '{searchTerm}'? {isRelevant}");
                                    
                                    if (isRelevant)
                                    {
                                        // Crear clave única para evitar duplicados
                                        var productKey = $"{name?.ToLower()?.Trim()}_{currentPrice}";
                                        
                                        if (!seenProducts.Contains(productKey))
                                        {
                                            seenProducts.Add(productKey);
                                            
                                            // Si no hay precio original pero hay descuento, calcular precio original
                                            if (originalPrice == 0 && currentPrice > 0 && discountPercentage > 0)
                                            {
                                                originalPrice = currentPrice / (1 - discountPercentage / 100m);
                                            }
                                            
                                            var hasDiscount = originalPrice > currentPrice && discountPercentage > 0;
                                            
                                            // Mejorar detección de precios - evitar "Consultar precio" innecesario
                                            var displayPrice = "Consultar precio";
                                            if (currentPrice > 0)
                                            {
                                                displayPrice = $"${currentPrice:N0}";
                                            }
                                            else if (!string.IsNullOrEmpty(currentPriceText) && currentPriceText.Contains("$"))
                                            {
                                                displayPrice = currentPriceText;
                                            }
                                            
                                            // Buscar promociones especiales en el HTML
                                            bool hasSpecialPromotion = false;
                                            string promotionText = "";
                                            
                                            // Buscar elementos que contengan promociones
                                            var promotionNode = productNode.SelectSingleNode(".//*[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), '2do al 50') or contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), '2da al 50') or contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'segunda al 50')]");
                                            
                                            if (promotionNode != null)
                                            {
                                                var promotionNodeText = promotionNode.InnerText?.ToLower() ?? "";
                                                if ((promotionNodeText.Contains("2do") || promotionNodeText.Contains("2da") || promotionNodeText.Contains("segunda")) && promotionNodeText.Contains("50"))
                                                {
                                                    hasSpecialPromotion = true;
                                                    promotionText = "2do al 50%";
                                                }
                                            }
                                            
                                            // También buscar en el nombre del producto
                                            if (!hasSpecialPromotion && !string.IsNullOrEmpty(name))
                                            {
                                                var nameLower = name.ToLower();
                                                if ((nameLower.Contains("2do") || nameLower.Contains("2da") || nameLower.Contains("segunda")) && nameLower.Contains("50"))
                                                {
                                                    hasSpecialPromotion = true;
                                                    promotionText = "2do al 50%";
                                                }
                                            }
                                            
                                            // Construir texto de descuento
                                            var discountDisplayText = "";
                                            if (hasDiscount)
                                            {
                                                discountDisplayText = $"{discountPercentage:F0}% OFF";
                                            }
                                            
                                            results.Add(new ProductOffer
                                            {
                                                ProductName = name,
                                                Store = "Día Online (HTML)",
                                                Price = displayPrice,
                                                PriceValue = currentPrice,
                                                ProductUrl = productUrl ?? $"https://diaonline.supermercadosdia.com.ar/{searchTerm.ToLower()}",
                                                IsAvailable = displayPrice != "Consultar precio",
                                                AvailabilityText = displayPrice != "Consultar precio" ? "Disponible" : "Sin stock",
                                                OriginalPrice = originalPrice,
                                                OriginalPriceText = originalPrice > 0 ? $"${originalPrice:N0}" : "",
                                                DiscountPercentage = (int)discountPercentage,
                                                HasDiscount = hasDiscount,
                                                DiscountText = discountDisplayText,
                                                HasSpecialPromotion = hasSpecialPromotion,
                                                PromotionText = promotionText
                                            });
                                            
                                            debugInfo.Add($"   ✅ Producto agregado: {name} - Precio: {displayPrice} - Descuento: {hasDiscount}");
                                        }
                                        else
                                        {
                                            debugInfo.Add($"   🔄 Producto duplicado omitido: {name}");
                                        }
                                    }
                                }
                                else if (!string.IsNullOrEmpty(name))
                                {
                                    debugInfo.Add($"❌ HTML No coincide: {name}");
                                }
                            }
                            catch (Exception ex)
                            {
                                debugInfo.Add($" Error procesando producto HTML: {ex.Message}");
                            }
                        }
                    }
                    else
                    {
                        debugInfo.Add($"❌ No se encontraron productos con selectores principales");
                        
                        // Intentar selectores más amplios
                        var allDivs = doc.DocumentNode.SelectNodes("//div");
                        debugInfo.Add($"📊 Total divs en página: {allDivs?.Count ?? 0}");
                        
                        // Buscar cualquier texto que contenga "morixe"
                        var textNodes = doc.DocumentNode.SelectNodes($"//*[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), '{searchTerm.ToLower()}')]");
                        debugInfo.Add($"🔍 Elementos con '{searchTerm}': {textNodes?.Count ?? 0}");
                        
                        if (textNodes != null && textNodes.Count > 0)
                        {
                            debugInfo.Add($"🔄 Analizando {textNodes.Count} elementos con '{searchTerm}'");
                            
                            foreach (var node in textNodes.Take(10))
                            {
                                var nodeText = node.InnerText?.Trim();
                                if (!string.IsNullOrEmpty(nodeText) && nodeText.Length < 300)
                                {
                                    debugInfo.Add($"   📝 Texto: {nodeText.Substring(0, Math.Min(100, nodeText.Length))}...");
                                    
                                    // Buscar precio en el contexto del nodo
                                    var parentNode = node.ParentNode;
                                    var contextText = parentNode?.InnerText ?? nodeText;
                                    
                                    var priceMatch = System.Text.RegularExpressions.Regex.Match(contextText, @"\$\s*(\d+(?:[.,]\d+)*)");
                                    if (priceMatch.Success)
                                    {
                                        var price = ExtractPrice(priceMatch.Value);
                                        if (price > 0)
                                        {
                                            var productName = nodeText.Split('\n')[0].Trim();
                                            // Limpiar el nombre
                                            productName = System.Text.RegularExpressions.Regex.Replace(productName, @"\$\s*\d+[.,]?\d*", "").Trim();
                                            productName = System.Text.RegularExpressions.Regex.Replace(productName, @"-?\d+%", "").Trim();
                                            
                                            if (productName.Length > 5)
                                            {
                                                results.Add(new ProductOffer
                                                {
                                                    ProductName = productName,
                                                    Store = "Día Online (Texto)",
                                                    Price = $"${price:N0}",
                                                    PriceValue = price,
                                                    ProductUrl = $"https://diaonline.supermercadosdia.com.ar/{searchTerm.ToLower()}",
                                                    IsAvailable = true,
                                                    AvailabilityText = "Disponible",
                                                    OriginalPrice = 0,
                                                    OriginalPriceText = "",
                                                    DiscountPercentage = 0,
                                                    HasDiscount = false,
                                                    DiscountText = ""
                                                });
                                                debugInfo.Add($"   ✅ Producto encontrado: {productName} - ${price:N0}");
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            debugInfo.Add($"❌ No se encontró ningún elemento con '{searchTerm}' en el HTML");
                            // Mostrar una muestra del HTML para debug
                            var sampleHtml = htmlContent.Length > 500 ? htmlContent.Substring(0, 500) : htmlContent;
                            debugInfo.Add($"📄 Muestra HTML: {sampleHtml}...");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                debugInfo.Add($" Error en scraping directo: {ex.Message}");
            }
            
            return results;
        }

        private async Task<List<ProductOffer>> SearchCarrefourRealAsync(string searchTerm)
        {
            var results = new List<ProductOffer>();
            var debugInfo = new List<string>();
            
            try
            {
                debugInfo.Add($"🔍 Buscando en Carrefour API: {searchTerm}");
                
                // Intentar con la API de Carrefour primero
                var apiResults = await SearchCarrefourAPIAsync(searchTerm, debugInfo);
                results.AddRange(apiResults);
                
                // Si la API no devuelve resultados, usar scraping como fallback
                if (results.Count == 0)
                {
                    debugInfo.Add("🌐 API sin resultados, intentando scraping directo...");
                    var scrapingResults = await SearchCarrefourDirectAsync(searchTerm, debugInfo);
                    results.AddRange(scrapingResults);
                }
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error en Carrefour: {ex.Message}");
            }
            
            // Guardar info de debug
            _lastDebugInfo += "\n" + string.Join("\n", debugInfo);
            
            return results;
        }

        private async Task<List<ProductOffer>> SearchCarrefourAPIAsync(string searchTerm, List<string> debugInfo)
        {
            var results = new List<ProductOffer>();
            
            try
            {
                // API de Carrefour - similar estructura a Día Online
                var searchUrl = $"https://www.carrefour.com.ar/api/catalog_system/pub/products/search?q={Uri.EscapeDataString(searchTerm)}&_from=0&_to=20";
                debugInfo.Add($"🔍 Búsqueda en Carrefour API: {searchUrl}");
                
                var request = new HttpRequestMessage(HttpMethod.Get, searchUrl);
                request.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
                request.Headers.Add("Accept", "application/json");
                request.Headers.Add("Accept-Language", "es-AR,es;q=0.9");
                request.Headers.Add("Referer", "https://www.carrefour.com.ar/");
                request.Headers.Add("Origin", "https://www.carrefour.com.ar");
                
                using (var response = await _httpClient.SendAsync(request))
                {
                    debugInfo.Add($"📥 Carrefour API Status: {(int)response.StatusCode} {response.ReasonPhrase}");
                    
                    if (!response.IsSuccessStatusCode)
                    {
                        debugInfo.Add($"❌ Error en Carrefour API: {response.StatusCode}");
                        return results;
                    }
                    
                    var responseContent = await response.Content.ReadAsStringAsync();
                    debugInfo.Add($"📄 Carrefour API response length: {responseContent.Length}");
                    
                    using (JsonDocument doc = JsonDocument.Parse(responseContent))
                    {
                        var root = doc.RootElement;
                        
                        if (root.ValueKind != JsonValueKind.Array)
                        {
                            debugInfo.Add($"❌ Carrefour API: Se esperaba array pero se recibió: {root.ValueKind}");
                            return results;
                        }
                        
                        debugInfo.Add($"📦 Carrefour API: {root.GetArrayLength()} productos en respuesta");
                        
                        foreach (var product in root.EnumerateArray())
                        {
                            try
                            {
                                string name = product.TryGetProperty("productName", out var nameProp) 
                                    ? nameProp.GetString() ?? "[Sin nombre]" 
                                    : "[Sin nombre]";
                                
                                string price = null;
                                string originalPrice = null;
                                decimal discountPercentage = 0;
                                bool isAvailable = false;
                                
                                if (product.TryGetProperty("items", out var items) && items.ValueKind == JsonValueKind.Array && items.GetArrayLength() > 0)
                                {
                                    var firstItem = items[0];
                                    if (firstItem.TryGetProperty("sellers", out var sellers) && 
                                        sellers.ValueKind == JsonValueKind.Array && 
                                        sellers.GetArrayLength() > 0)
                                    {
                                        var firstSeller = sellers[0];
                                        if (firstSeller.TryGetProperty("commertialOffer", out var offer))
                                        {
                                            if (offer.TryGetProperty("Price", out var priceProp) && 
                                                priceProp.ValueKind != JsonValueKind.Null)
                                            {
                                                price = priceProp.GetDecimal().ToString("0.00", System.Globalization.CultureInfo.InvariantCulture);
                                            }
                                            
                                            if (offer.TryGetProperty("ListPrice", out var listPriceProp) && 
                                                listPriceProp.ValueKind != JsonValueKind.Null)
                                            {
                                                var listPriceValue = listPriceProp.GetDecimal();
                                                if (listPriceValue > 0)
                                                {
                                                    originalPrice = listPriceValue.ToString("0.00", System.Globalization.CultureInfo.InvariantCulture);
                                                    
                                                    if (decimal.TryParse(price, out var currentPriceValue) && currentPriceValue > 0)
                                                    {
                                                        discountPercentage = Math.Round(((listPriceValue - currentPriceValue) / listPriceValue) * 100, 0);
                                                    }
                                                }
                                            }
                                            
                                            if (offer.TryGetProperty("IsAvailable", out var availableProp) && 
                                                availableProp.ValueKind == JsonValueKind.True)
                                            {
                                                isAvailable = true;
                                            }
                                        }
                                    }
                                }
                                
                                if (!string.IsNullOrEmpty(name) && !string.IsNullOrEmpty(price) && ContainsSearchTerm(name, searchTerm))
                                {
                                    if (decimal.TryParse(price, System.Globalization.NumberStyles.Any, 
                                        System.Globalization.CultureInfo.InvariantCulture, out decimal priceValue))
                                    {
                                        decimal originalPriceValue = 0;
                                        if (!string.IsNullOrEmpty(originalPrice))
                                        {
                                            decimal.TryParse(originalPrice, System.Globalization.NumberStyles.Any, 
                                                System.Globalization.CultureInfo.InvariantCulture, out originalPriceValue);
                                        }
                                        
                                        string productUrl = "https://www.carrefour.com.ar";
                                        if (product.TryGetProperty("linkText", out var linkText) && 
                                            !string.IsNullOrWhiteSpace(linkText.GetString()))
                                        {
                                            string link = linkText.GetString();
                                            productUrl += link.StartsWith("/") ? $"{link}/p" : $"/{link}/p";
                                        }
                                        
                                        bool hasDiscount = originalPriceValue > priceValue && discountPercentage > 0;
                                        
                                        results.Add(new ProductOffer
                                        {
                                            ProductName = name,
                                            Store = "Carrefour",
                                            Price = $"${priceValue:N0}",
                                            PriceValue = priceValue,
                                            ProductUrl = productUrl,
                                            IsAvailable = isAvailable,
                                            AvailabilityText = isAvailable ? "Disponible" : "Sin stock",
                                            OriginalPrice = originalPriceValue,
                                            OriginalPriceText = originalPriceValue > 0 ? $"${originalPriceValue:N0}" : "",
                                            DiscountPercentage = (int)discountPercentage,
                                            HasDiscount = hasDiscount,
                                            DiscountText = hasDiscount ? $"{discountPercentage:F0}% OFF" : ""
                                        });
                                        
                                        debugInfo.Add($"✅ Carrefour API: {name} - ${priceValue:N0}");
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                debugInfo.Add($"❌ Error procesando producto Carrefour: {ex.Message}");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error en Carrefour API: {ex.Message}");
            }
            
            return results;
        }

        private async Task<List<ProductOffer>> SearchCarrefourDirectAsync(string searchTerm, List<string> debugInfo)
        {
            var results = new List<ProductOffer>();
            
            try
            {
                // Scraping directo de Carrefour
                var searchUrl = $"https://www.carrefour.com.ar/{Uri.EscapeDataString(searchTerm.ToLower())}";
                debugInfo.Add($"🌐 Scraping Carrefour: {searchUrl}");
                
                var request = new HttpRequestMessage(HttpMethod.Get, searchUrl);
                request.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
                request.Headers.Add("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
                request.Headers.Add("Accept-Language", "es-AR,es;q=0.9");
                
                var response = await _httpClient.SendAsync(request);
                debugInfo.Add($"📄 Carrefour status: {response.StatusCode}");
                
                if (response.IsSuccessStatusCode)
                {
                    var htmlContent = await response.Content.ReadAsStringAsync();
                    
                    // Verificar si Cloudflare está bloqueando
                    if (htmlContent.Contains("cloudflare") || htmlContent.Contains("Enable JavaScript"))
                    {
                        debugInfo.Add("🚫 Carrefour bloqueado por Cloudflare");
                        return results;
                    }
                    
                    var doc = new HtmlDocument();
                    doc.LoadHtml(htmlContent);
                    
                    // Buscar productos en Carrefour (ajustar selectores)
                    var productNodes = doc.DocumentNode.SelectNodes("//div[contains(@class, 'product')] | //article | //li[contains(@class, 'item')]");
                    
                    if (productNodes != null)
                    {
                        debugInfo.Add($"📦 Productos Carrefour encontrados: {productNodes.Count}");
                        
                        foreach (var productNode in productNodes.Take(10))
                        {
                            try
                            {
                                var nameNode = productNode.SelectSingleNode(".//h3 | .//h2 | .//span[contains(@class, 'name')] | .//a");
                                var name = nameNode?.InnerText?.Trim();
                                
                                var priceNode = productNode.SelectSingleNode(".//span[contains(@class, 'price')] | .//div[contains(@class, 'price')]");
                                var priceText = priceNode?.InnerText?.Trim();
                                
                                var linkNode = productNode.SelectSingleNode(".//a[@href]");
                                var productUrl = linkNode?.GetAttributeValue("href", "");
                                
                                if (!string.IsNullOrEmpty(name) && ContainsSearchTerm(name, searchTerm))
                                {
                                    var priceValue = ExtractPrice(priceText);
                                    
                                    results.Add(new ProductOffer
                                    {
                                        ProductName = name,
                                        Store = "Carrefour",
                                        Price = priceValue > 0 ? $"${priceValue:N2}" : "Consultar precio",
                                        PriceValue = priceValue,
                                        ProductUrl = productUrl?.StartsWith("http") == true ? productUrl : $"https://www.carrefour.com.ar{productUrl}",
                                        IsAvailable = true,
                                        AvailabilityText = "Disponible"
                                    });
                                    
                                    debugInfo.Add($"✅ Producto Carrefour: {name}");
                                }
                            }
                            catch (Exception ex)
                            {
                                debugInfo.Add($"❌ Error procesando Carrefour: {ex.Message}");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error scraping Carrefour: {ex.Message}");
            }
            
            return results;
        }

        private async Task<List<ProductOffer>> SearchJumboDirectAsync(string searchTerm, List<string> debugInfo)
        {
            var results = new List<ProductOffer>();
            
            try
            {
                // Scraping directo de Jumbo
                var searchUrl = $"https://www.jumbo.com.ar/{Uri.EscapeDataString(searchTerm.ToLower())}";
                debugInfo.Add($"🌐 Scraping Jumbo: {searchUrl}");
                
                var request = new HttpRequestMessage(HttpMethod.Get, searchUrl);
                request.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
                request.Headers.Add("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
                request.Headers.Add("Accept-Language", "es-AR,es;q=0.9");
                
                var response = await _httpClient.SendAsync(request);
                debugInfo.Add($"📄 Jumbo status: {response.StatusCode}");
                
                if (response.IsSuccessStatusCode)
                {
                    var htmlContent = await response.Content.ReadAsStringAsync();
                    var doc = new HtmlDocument();
                    doc.LoadHtml(htmlContent);
                    
                    // Buscar productos en Jumbo
                    var productNodes = doc.DocumentNode.SelectNodes("//div[contains(@class, 'product')] | //article | //li[contains(@class, 'item')]");
                    
                    if (productNodes != null)
                    {
                        debugInfo.Add($"📦 Productos Jumbo encontrados: {productNodes.Count}");
                        
                        foreach (var productNode in productNodes.Take(10))
                        {
                            try
                            {
                                var nameNode = productNode.SelectSingleNode(".//h3 | .//h2 | .//span[contains(@class, 'name')] | .//a");
                                var name = nameNode?.InnerText?.Trim();
                                
                                var priceNode = productNode.SelectSingleNode(".//span[contains(@class, 'price')] | .//div[contains(@class, 'price')]");
                                var priceText = priceNode?.InnerText?.Trim();
                                
                                var linkNode = productNode.SelectSingleNode(".//a[@href]");
                                var productUrl = linkNode?.GetAttributeValue("href", "");
                                
                                if (!string.IsNullOrEmpty(name) && ContainsSearchTerm(name, searchTerm))
                                {
                                    var priceValue = ExtractPrice(priceText);
                                    
                                    results.Add(new ProductOffer
                                    {
                                        ProductName = name,
                                        Store = "Jumbo",
                                        Price = priceValue > 0 ? $"${priceValue:N2}" : "Consultar precio",
                                        PriceValue = priceValue,
                                        ProductUrl = productUrl?.StartsWith("http") == true ? productUrl : $"https://www.jumbo.com.ar{productUrl}",
                                        IsAvailable = true,
                                        AvailabilityText = "Disponible"
                                    });
                                    
                                    debugInfo.Add($"✅ Producto Jumbo: {name}");
                                }
                            }
                            catch (Exception ex)
                            {
                                debugInfo.Add($"❌ Error procesando Jumbo: {ex.Message}");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error scraping Jumbo: {ex.Message}");
            }
            
            return results;
        }

        private async Task<List<ProductOffer>> SearchJumboRealAsync(string searchTerm)
        {
            var results = new List<ProductOffer>();
            var debugInfo = new List<string>();
            
            try
            {
                debugInfo.Add($"🔍 Buscando en Jumbo API: {searchTerm}");
                
                // Intentar con la API de Jumbo primero
                var apiResults = await SearchJumboAPIAsync(searchTerm, debugInfo);
                results.AddRange(apiResults);
                
                // Si la API no devuelve resultados, usar scraping como fallback
                if (results.Count == 0)
                {
                    debugInfo.Add("🌐 API sin resultados, usando scraping directo...");
                    var scrapingResults = await SearchJumboDirectAsync(searchTerm, debugInfo);
                    results.AddRange(scrapingResults);
                }
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error en Jumbo: {ex.Message}");
            }
            
            // Guardar info de debug
            _lastDebugInfo += "\n" + string.Join("\n", debugInfo);
            
            return results;
        }

        private async Task<List<ProductOffer>> SearchJumboAPIAsync(string searchTerm, List<string> debugInfo)
        {
            var results = new List<ProductOffer>();
            
            try
            {
                // Jumbo API - similar estructura a Día Online y Carrefour
                var searchUrl = $"https://www.jumbo.com.ar/api/catalog_system/pub/products/search?q={Uri.EscapeDataString(searchTerm)}&_from=0&_to=20";
                debugInfo.Add($"🔍 Búsqueda en Jumbo API: {searchUrl}");
                
                var request = new HttpRequestMessage(HttpMethod.Get, searchUrl);
                request.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
                request.Headers.Add("Accept", "application/json");
                request.Headers.Add("Accept-Language", "es-AR,es;q=0.9");
                request.Headers.Add("Referer", "https://www.jumbo.com.ar/");
                request.Headers.Add("Origin", "https://www.jumbo.com.ar");
                
                using (var response = await _httpClient.SendAsync(request))
                {
                    debugInfo.Add($"📥 Jumbo API Status: {(int)response.StatusCode} {response.ReasonPhrase}");
                    
                    if (!response.IsSuccessStatusCode)
                    {
                        debugInfo.Add($"❌ Error en Jumbo API: {response.StatusCode}");
                        return results;
                    }
                    
                    var responseContent = await response.Content.ReadAsStringAsync();
                    debugInfo.Add($"📄 Jumbo API response length: {responseContent.Length}");
                    
                    using (JsonDocument doc = JsonDocument.Parse(responseContent))
                    {
                        var root = doc.RootElement;
                        
                        if (root.ValueKind != JsonValueKind.Array)
                        {
                            debugInfo.Add($"❌ Jumbo API: Se esperaba array pero se recibió: {root.ValueKind}");
                            return results;
                        }
                        
                        debugInfo.Add($"📦 Jumbo API: {root.GetArrayLength()} productos en respuesta");
                        
                        foreach (var product in root.EnumerateArray())
                        {
                            try
                            {
                                string name = product.TryGetProperty("productName", out var nameProp) 
                                    ? nameProp.GetString() ?? "[Sin nombre]" 
                                    : "[Sin nombre]";
                                
                                string price = null;
                                string originalPrice = null;
                                decimal discountPercentage = 0;
                                bool isAvailable = false;
                                
                                if (product.TryGetProperty("items", out var items) && items.ValueKind == JsonValueKind.Array && items.GetArrayLength() > 0)
                                {
                                    var firstItem = items[0];
                                    if (firstItem.TryGetProperty("sellers", out var sellers) && 
                                        sellers.ValueKind == JsonValueKind.Array && 
                                        sellers.GetArrayLength() > 0)
                                    {
                                        var firstSeller = sellers[0];
                                        if (firstSeller.TryGetProperty("commertialOffer", out var offer))
                                        {
                                            if (offer.TryGetProperty("Price", out var priceProp) && 
                                                priceProp.ValueKind != JsonValueKind.Null)
                                            {
                                                price = priceProp.GetDecimal().ToString("0.00", System.Globalization.CultureInfo.InvariantCulture);
                                            }
                                            
                                            // Validación más estricta para descuentos en Jumbo
                                            if (offer.TryGetProperty("ListPrice", out var listPriceProp) && 
                                                listPriceProp.ValueKind != JsonValueKind.Null)
                                            {
                                                var listPriceValue = listPriceProp.GetDecimal();
                                                if (listPriceValue > 0 && decimal.TryParse(price, out var currentPriceValue) && currentPriceValue > 0)
                                                {
                                                    // Solo mostrar descuento si la diferencia es mayor al 5% y menor al 80% (evitar descuentos falsos del 99%)
                                                    var potentialDiscount = ((listPriceValue - currentPriceValue) / listPriceValue) * 100;
                                                    if (potentialDiscount > 5 && potentialDiscount < 80 && listPriceValue < currentPriceValue * 2.5m)
                                                    {
                                                        originalPrice = listPriceValue.ToString("0.00", System.Globalization.CultureInfo.InvariantCulture);
                                                        discountPercentage = Math.Round(potentialDiscount, 0);
                                                    }
                                                }
                                            }
                                            
                                            if (offer.TryGetProperty("IsAvailable", out var availableProp) && 
                                                availableProp.ValueKind == JsonValueKind.True)
                                            {
                                                isAvailable = true;
                                            }
                                        }
                                    }
                                }
                                
                                if (!string.IsNullOrEmpty(name) && !string.IsNullOrEmpty(price) && ContainsSearchTerm(name, searchTerm))
                                {
                                    if (decimal.TryParse(price, System.Globalization.NumberStyles.Any, 
                                        System.Globalization.CultureInfo.InvariantCulture, out decimal priceValue))
                                    {
                                        decimal originalPriceValue = 0;
                                        if (!string.IsNullOrEmpty(originalPrice))
                                        {
                                            decimal.TryParse(originalPrice, System.Globalization.NumberStyles.Any, 
                                                System.Globalization.CultureInfo.InvariantCulture, out originalPriceValue);
                                        }
                                        
                                        string productUrl = "https://www.jumbo.com.ar";
                                        if (product.TryGetProperty("linkText", out var linkText) && 
                                            !string.IsNullOrWhiteSpace(linkText.GetString()))
                                        {
                                            string link = linkText.GetString();
                                            productUrl += link.StartsWith("/") ? $"{link}/p" : $"/{link}/p";
                                        }
                                        
                                        // Solo mostrar descuento si es válido y razonable
                                        bool hasDiscount = originalPriceValue > priceValue && discountPercentage > 5 && discountPercentage < 80;
                                        
                                        results.Add(new ProductOffer
                                        {
                                            ProductName = name,
                                            Store = "Jumbo",
                                            Price = $"${priceValue:N0}",
                                            PriceValue = priceValue,
                                            ProductUrl = productUrl,
                                            IsAvailable = isAvailable,
                                            AvailabilityText = isAvailable ? "Disponible" : "Sin stock",
                                            OriginalPrice = originalPriceValue,
                                            OriginalPriceText = originalPriceValue > 0 ? $"${originalPriceValue:N0}" : "",
                                            DiscountPercentage = (int)discountPercentage,
                                            HasDiscount = hasDiscount,
                                            DiscountText = hasDiscount ? $"{discountPercentage:F0}% OFF" : ""
                                        });
                                        
                                        debugInfo.Add($"✅ Jumbo API: {name} - ${priceValue:N0} {(hasDiscount ? $"(descuento: {discountPercentage}%)" : "")}");
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                debugInfo.Add($"❌ Error procesando producto Jumbo: {ex.Message}");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error en Jumbo API: {ex.Message}");
            }
            
            return results;
        }

        private async Task<List<ProductOffer>> SearchDiaOnlineAsync(string searchTerm)
        {
            var results = new List<ProductOffer>();
            
            try
            {
                var url = $"https://diaonline.supermercadosdia.com.ar/search?q={Uri.EscapeDataString(searchTerm)}";
                var html = await _httpClient.GetStringAsync(url);
                var doc = new HtmlDocument();
                doc.LoadHtml(html);

                var productNodes = doc.DocumentNode.SelectNodes("//div[contains(@class, 'product-item')]");
                
                if (productNodes != null)
                {
                    foreach (var node in productNodes.Take(10))
                    {
                        try
                        {
                            var nameNode = node.SelectSingleNode(".//h3[contains(@class, 'product-name')] | .//span[contains(@class, 'product-title')]");
                            var priceNode = node.SelectSingleNode(".//span[contains(@class, 'price')] | .//div[contains(@class, 'price')]");
                            
                            if (nameNode != null && priceNode != null)
                            {
                                var name = nameNode.InnerText?.Trim();
                                var priceText = priceNode.InnerText?.Trim();
                                var priceValue = ExtractPrice(priceText);

                                if (!string.IsNullOrEmpty(name) && priceValue > 0)
                                {
                                    results.Add(new ProductOffer
                                    {
                                        ProductName = name,
                                        Store = "Día Online",
                                        Price = priceText ?? "N/A",
                                        PriceValue = priceValue
                                    });
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            System.Diagnostics.Debug.WriteLine($"Error procesando producto Día: {ex.Message}");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en Día Online: {ex.Message}");
                // Agregar productos de ejemplo para demostración
                results.Add(new ProductOffer
                {
                    ProductName = $"{searchTerm} - Producto Día Online",
                    Store = "Día Online",
                    Price = "$1,250.00",
                    PriceValue = 1250
                });
            }

            return results;
        }

        private async Task<List<ProductOffer>> SearchCarrefourAsync(string searchTerm)
        {
            var results = new List<ProductOffer>();
            
            try
            {
                var url = $"https://www.carrefour.com.ar/search?q={Uri.EscapeDataString(searchTerm)}";
                var html = await _httpClient.GetStringAsync(url);
                var doc = new HtmlDocument();
                doc.LoadHtml(html);

                var productNodes = doc.DocumentNode.SelectNodes("//article[contains(@class, 'product')] | //div[contains(@class, 'product-card')]");
                
                if (productNodes != null)
                {
                    foreach (var node in productNodes.Take(10))
                    {
                        try
                        {
                            var nameNode = node.SelectSingleNode(".//h2 | .//h3 | .//span[contains(@class, 'name')]");
                            var priceNode = node.SelectSingleNode(".//span[contains(@class, 'price')] | .//div[contains(@class, 'price')]");
                            
                            if (nameNode != null && priceNode != null)
                            {
                                var name = nameNode.InnerText?.Trim();
                                var priceText = priceNode.InnerText?.Trim();
                                var priceValue = ExtractPrice(priceText);

                                if (!string.IsNullOrEmpty(name) && priceValue > 0)
                                {
                                    results.Add(new ProductOffer
                                    {
                                        ProductName = name,
                                        Store = "Carrefour",
                                        Price = priceText ?? "N/A",
                                        PriceValue = priceValue
                                    });
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            System.Diagnostics.Debug.WriteLine($"Error procesando producto Carrefour: {ex.Message}");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en Carrefour: {ex.Message}");
                // Agregar productos de ejemplo para demostración
                results.Add(new ProductOffer
                {
                    ProductName = $"{searchTerm} - Producto Carrefour",
                    Store = "Carrefour",
                    Price = "$1,180.50",
                    PriceValue = 1180.50m
                });
            }

            return results;
        }

        private async Task<List<ProductOffer>> SearchJumboAsync(string searchTerm)
        {
            var results = new List<ProductOffer>();
            
            try
            {
                var url = $"https://www.jumbo.com.ar/search?q={Uri.EscapeDataString(searchTerm)}";
                var html = await _httpClient.GetStringAsync(url);
                var doc = new HtmlDocument();
                doc.LoadHtml(html);

                var productNodes = doc.DocumentNode.SelectNodes("//div[contains(@class, 'product')] | //article[contains(@class, 'item')]");
                
                if (productNodes != null)
                {
                    foreach (var node in productNodes.Take(10))
                    {
                        try
                        {
                            var nameNode = node.SelectSingleNode(".//h2 | .//h3 | .//span[contains(@class, 'title')]");
                            var priceNode = node.SelectSingleNode(".//span[contains(@class, 'price')] | .//div[contains(@class, 'price')]");
                            
                            if (nameNode != null && priceNode != null)
                            {
                                var name = nameNode.InnerText?.Trim();
                                var priceText = priceNode.InnerText?.Trim();
                                var priceValue = ExtractPrice(priceText);

                                if (!string.IsNullOrEmpty(name) && priceValue > 0)
                                {
                                    results.Add(new ProductOffer
                                    {
                                        ProductName = name,
                                        Store = "Jumbo",
                                        Price = priceText ?? "N/A",
                                        PriceValue = priceValue
                                    });
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            System.Diagnostics.Debug.WriteLine($"Error procesando producto Jumbo: {ex.Message}");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en Jumbo: {ex.Message}");
                // Agregar productos de ejemplo para demostración
                results.Add(new ProductOffer
                {
                    ProductName = $"{searchTerm} - Producto Jumbo",
                    Store = "Jumbo",
                    Price = "$1,320.75",
                    PriceValue = 1320.75m
                });
            }

            return results;
        }

        private decimal ExtractPrice(string priceText)
        {
            if (string.IsNullOrEmpty(priceText))
                return 0;

            // Limpiar el texto de precio primero
            var cleanText = priceText.Trim();
            
            // Remover palabras como "AHORA", "OFF", etc.
            cleanText = System.Text.RegularExpressions.Regex.Replace(cleanText, @"\b(AHORA|OFF|DESC|DESCUENTO)\b", "", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            
            // Buscar patrones de precio más específicos y ordenados por prioridad
            var patterns = new[]
            {
                @"\$\s*(\d{1,4}(?:[.,]\d{3})*(?:[.,]\d{2})?)", // $1,250.00 o $1.250,00 - con símbolo $
                @"(\d{1,4}[.,]\d{2})(?!\d)", // 35.00 o 35,00 - números con 2 decimales exactos
                @"(\d{3,4})(?![.,]\d)", // números de 3-4 dígitos sin decimales (precios típicos)
                @"(\d{1,4}(?:[.,]\d{3})+)(?![.,]\d)", // 1,250 o 1.250 - separadores de miles
                @"(\d{5,})" // números muy largos como último recurso
            };

            foreach (var pattern in patterns)
            {
                var matches = System.Text.RegularExpressions.Regex.Matches(cleanText, pattern);
                
                foreach (System.Text.RegularExpressions.Match match in matches)
                {
                    if (match.Success)
                    {
                        var cleanPrice = match.Groups[1].Value;
                        
                        // Normalizar formato
                        if (cleanPrice.Contains(",") && cleanPrice.Contains("."))
                        {
                            // Determinar si es formato europeo (1.250,00) o americano (1,250.00)
                            if (cleanPrice.LastIndexOf(',') > cleanPrice.LastIndexOf('.'))
                            {
                                // Formato europeo: 1.250,00
                                cleanPrice = cleanPrice.Replace(".", "").Replace(",", ".");
                            }
                            else
                            {
                                // Formato americano: 1,250.00
                                cleanPrice = cleanPrice.Replace(",", "");
                            }
                        }
                        else if (cleanPrice.Contains(","))
                        {
                            var parts = cleanPrice.Split(',');
                            if (parts.Length == 2 && parts[1].Length <= 2)
                            {
                                // Decimal: 1250,50
                                cleanPrice = cleanPrice.Replace(",", ".");
                            }
                            else
                            {
                                // Separador de miles: 1,250
                                cleanPrice = cleanPrice.Replace(",", "");
                            }
                        }

                        if (decimal.TryParse(cleanPrice, System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out decimal price))
                        {
                            // Validar que el precio esté en un rango razonable (entre $10 y $50,000)
                            if (price >= 10 && price <= 50000)
                            {
                                return price;
                            }
                        }
                    }
                }
            }

            return 0;
        }

        private decimal ExtractDiscountPercentage(string discountText)
        {
            if (string.IsNullOrEmpty(discountText))
                return 0;

            // Buscar patrones de porcentaje como "35%", "-35%", "35% OFF"
            var patterns = new[]
            {
                @"(\d{1,2})%",
                @"-(\d{1,2})%",
                @"(\d{1,2})%\s*OFF",
                @"(\d{1,2})%\s*desc"
            };

            foreach (var pattern in patterns)
            {
                var match = System.Text.RegularExpressions.Regex.Match(discountText, pattern, System.Text.RegularExpressions.RegexOptions.IgnoreCase);
                if (match.Success && int.TryParse(match.Groups[1].Value, out int percentage))
                {
                    return percentage;
                }
            }

            return 0;
        }

        private bool ContainsSearchTerm(string productName, string searchTerm)
        {
            if (string.IsNullOrEmpty(productName) || string.IsNullOrEmpty(searchTerm))
                return false;

            // Normalizar texto para comparación (sin acentos, minúsculas)
            var normalizedProductName = RemoveAccents(productName.ToLower());
            var normalizedSearchTerm = RemoveAccents(searchTerm.ToLower());

            Console.WriteLine($"🔍 Comparando: '{normalizedProductName}' con '{normalizedSearchTerm}'");

            // Para "morixe" hacer coincidencia directa más flexible
            if (normalizedSearchTerm == "morixe")
            {
                bool contains = normalizedProductName.Contains("morixe");
                // Debug: mostrar qué está comparando
                if (!contains)
                {
                    Console.WriteLine($"❌ '{normalizedProductName}' NO contiene 'morixe'");
                }
                else
                {
                    Console.WriteLine($"✅ '{normalizedProductName}' SÍ contiene 'morixe'");
                }
                return contains;
            }

            // Dividir en palabras tanto el producto como el término de búsqueda
            var productWords = normalizedProductName.Split(new char[] { ' ', '-', ',', '.', '(', ')', '[', ']' }, 
                StringSplitOptions.RemoveEmptyEntries);
            var searchWords = normalizedSearchTerm.Split(' ', StringSplitOptions.RemoveEmptyEntries);
            
            // Filtrar palabras muy cortas que pueden causar falsos positivos
            searchWords = searchWords.Where(w => w.Length >= 3).ToArray();
            
            if (searchWords.Length == 0)
                return false;

            // Contar cuántas palabras de búsqueda coinciden
            int matchCount = 0;
            
            foreach (var searchWord in searchWords)
            {
                bool wordFound = false;
                
                foreach (var productWord in productWords)
                {
                    // Coincidencia exacta o el producto contiene la palabra completa
                    if (productWord.Equals(searchWord) || 
                        (productWord.Length >= searchWord.Length && productWord.Contains(searchWord)))
                    {
                        wordFound = true;
                        break;
                    }
                }
                
                if (wordFound)
                    matchCount++;
            }
            
            // Requerir que al menos el 60% de las palabras coincidan
            // Para búsquedas de 1-2 palabras, requerir al menos 1 coincidencia
            double matchPercentage = (double)matchCount / searchWords.Length;
            return matchPercentage >= 0.6 || (searchWords.Length <= 2 && matchCount >= 1);
        }

        private string RemoveAccents(string text)
        {
            if (string.IsNullOrEmpty(text))
                return text;

            // Reemplazar caracteres acentuados comunes
            text = text.Replace("á", "a").Replace("é", "e").Replace("í", "i").Replace("ó", "o").Replace("ú", "u");
            text = text.Replace("à", "a").Replace("è", "e").Replace("ì", "i").Replace("ò", "o").Replace("ù", "u");
            text = text.Replace("ä", "a").Replace("ë", "e").Replace("ï", "i").Replace("ö", "o").Replace("ü", "u");
            text = text.Replace("ñ", "n");
            
            return text;
        }

        public void Dispose()
        {
            _httpClient?.Dispose();
        }
    }
}
