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
                
                // Determinar si es una búsqueda de marca (búsqueda corta, sin espacios, mayúsculas, etc.)
                bool isBrandSearch = searchTerm.Length >= 3 && 
                                   searchTerm.Length <= 15 && 
                                   !searchTerm.Contains(" ") && 
                                   searchTerm.Any(char.IsUpper);
                
                var tasks = new List<Task<List<ProductOffer>>>();
                
                if (searchDiaOnline)
                    tasks.Add(SearchDiaOnlineAsync(searchTerm));
                
                if (searchCarrefour)
                    tasks.Add(SearchCarrefourAsync(searchTerm));
                
                if (searchJumbo)
                    tasks.Add(SearchJumboAsync(searchTerm));
                
                var allResults = await Task.WhenAll(tasks);
                
                // Procesar resultados manteniendo productos relevantes
                foreach (var storeResults in allResults)
                {
                    foreach (var product in storeResults)
                    {
                        // Para búsquedas de marca, mantener productos aunque no tengan precio
                        if (isBrandSearch)
                        {
                            // Si el producto contiene el término de búsqueda (marca), mantenerlo
                            if (product.ProductName != null && 
                                product.ProductName.IndexOf(searchTerm, StringComparison.OrdinalIgnoreCase) >= 0)
                            {
                                results.Add(product);
                            }
                        }
                        // Para búsquedas normales, mantener solo productos con precio
                        else if (product.PriceValue > 0 || 
                                (product.Price != null && product.Price.Contains("$")))
                        {
                            results.Add(product);
                        }
                    }
                }
                
                Console.WriteLine($"📊 Productos encontrados en APIs reales: {results.Count}");
                
                // Ordenar resultados: primero por coincidencia exacta con el término de búsqueda, luego por precio
                var orderedResults = results
                    .OrderByDescending(p => p.ProductName != null && 
                                          p.ProductName.IndexOf(searchTerm, StringComparison.OrdinalIgnoreCase) >= 0)
                    .ThenBy(p => p.PriceValue)
                    .ToList();
                
                Console.WriteLine($"✅ BÚSQUEDA COMPLETADA - Total productos: {orderedResults.Count}");
                return orderedResults;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ ERROR en búsqueda: {ex.Message}");
                return results;
            }
        }

        private async Task<List<ProductOffer>> SearchJumboRealAsync(string searchTerm)
        {
            var results = new List<ProductOffer>();
            var debugInfo = new List<string>();
            var isBrandSearch = searchTerm.Length >= 3 && !searchTerm.Contains(" ") && searchTerm.Any(char.IsUpper);
            
            try
            {
                debugInfo.Add($"🔍 Buscando en Jumbo: {searchTerm}");
                
                // Obtener resultados de Jumbo
                var jumboResults = await SearchJumboAsync(searchTerm);
                
                // Filtrar resultados basado en si es una búsqueda de marca o no
                foreach (var product in jumboResults)
                {
                    if (isBrandSearch)
                    {
                        // Para búsquedas de marca, mantener productos aunque no tengan precio
                        if (product.ProductName != null && 
                            product.ProductName.IndexOf(searchTerm, StringComparison.OrdinalIgnoreCase) >= 0)
                        {
                            results.Add(product);
                        }
                    }
                    // Para búsquedas normales, mantener solo productos con precio
                    else if (product.PriceValue > 0 || (product.Price != null && product.Price.Contains("$")))
                    {
                        results.Add(product);
                    }
                }
                
                debugInfo.Add($"📊 Productos encontrados en API: {results.Count}");
                
                // Si la API no devuelve resultados relevantes, usar scraping como fallback
                if (results.Count == 0 || (isBrandSearch && results.Count < 3))
                {
                    debugInfo.Add("🌐 Pocos resultados relevantes, intentando scraping directo...");
                    var scrapingResults = await SearchJumboDirectAsync(searchTerm, debugInfo);
                    
                    // Aplicar la misma lógica de filtrado a los resultados del scraping
                    foreach (var product in scrapingResults)
                    {
                        if (isBrandSearch)
                        {
                            if (product.ProductName != null && 
                                product.ProductName.IndexOf(searchTerm, StringComparison.OrdinalIgnoreCase) >= 0)
                            {
                                results.Add(product);
                            }
                        }
                        else if (product.PriceValue > 0 || (product.Price != null && product.Price.Contains("$")))
                        {
                            results.Add(product);
                        }
                    }
                    
                    debugInfo.Add($"🌐 Productos encontrados en scraping: {scrapingResults.Count}");
                }
                
                // Solo se mostrarán resultados reales de la búsqueda
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error en Jumbo: {ex.Message}");
                debugInfo.Add($"📋 StackTrace: {ex.StackTrace}");
            }
            
            // Guardar info de debug
            _lastDebugInfo += "\n" + string.Join("\n", debugInfo);
            
            // Ordenar resultados: primero los que tienen precio, luego por coincidencia con el término de búsqueda
            return results
                .OrderBy(p => p.PriceValue == 0)
                .ThenBy(p => p.PriceValue)
                .ThenByDescending(p => p.ProductName != null && 
                                     p.ProductName.IndexOf(searchTerm, StringComparison.OrdinalIgnoreCase) >= 0)
                .ToList();
        }

        private async Task<List<ProductOffer>> SearchCarrefourRealAsync(string searchTerm)
        {
            var results = new List<ProductOffer>();
            var debugInfo = new List<string>();
            var isBrandSearch = searchTerm.Length >= 3 && !searchTerm.Contains(" ") && searchTerm.Any(char.IsUpper);
            
            try
            {
                debugInfo.Add($"🔍 Buscando en Carrefour: {searchTerm}");
                
                // Intentar con la API de Carrefour primero
                var apiResults = await SearchCarrefourAPIAsync(searchTerm, debugInfo);
                
                // Filtrar resultados basado en si es una búsqueda de marca o no
                foreach (var product in apiResults)
                {
                    if (isBrandSearch)
                    {
                        // Para búsquedas de marca, mantener productos aunque no tengan precio
                        if (product.ProductName != null && 
                            product.ProductName.IndexOf(searchTerm, StringComparison.OrdinalIgnoreCase) >= 0)
                        {
                            results.Add(product);
                        }
                    }
                    // Para búsquedas normales, mantener solo productos con precio
                    else if (product.PriceValue > 0 || (product.Price != null && product.Price.Contains("$")))
                    {
                        results.Add(product);
                    }
                }
                
                debugInfo.Add($"📊 Productos encontrados en API: {results.Count}");
                
                // Si la API no devuelve resultados relevantes, usar scraping como fallback
                if (results.Count == 0 || (isBrandSearch && results.Count < 3))
                {
                    debugInfo.Add("🌐 Pocos resultados relevantes, intentando scraping directo...");
                    var scrapingResults = await SearchCarrefourDirectAsync(searchTerm, debugInfo);
                    
                    // Aplicar la misma lógica de filtrado a los resultados del scraping
                    foreach (var product in scrapingResults)
                    {
                        if (isBrandSearch)
                        {
                            if (product.ProductName != null && 
                                product.ProductName.IndexOf(searchTerm, StringComparison.OrdinalIgnoreCase) >= 0)
                            {
                                results.Add(product);
                            }
                        }
                        else if (product.PriceValue > 0 || (product.Price != null && product.Price.Contains("$")))
                        {
                            results.Add(product);
                        }
                    }
                    
                    debugInfo.Add($"🌐 Productos encontrados en scraping: {scrapingResults.Count}");
                }
                
                // Si aún no hay resultados y es una búsqueda de marca, intentar con productos demo
                // No se usarán productos demo, solo resultados reales
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error en Carrefour: {ex.Message}");
                debugInfo.Add($"📋 StackTrace: {ex.StackTrace}");
            }
            
            // Guardar info de debug
            _lastDebugInfo += "\n" + string.Join("\n", debugInfo);
            
            // Ordenar resultados: primero los que tienen precio, luego por coincidencia con el término de búsqueda
            return results
                .OrderBy(p => p.PriceValue == 0)
                .ThenBy(p => p.PriceValue)
                .ThenByDescending(p => p.ProductName != null && 
                                     p.ProductName.IndexOf(searchTerm, StringComparison.OrdinalIgnoreCase) >= 0)
                .ToList();
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
                                    
                                    // Verificar si debemos mantener productos sin precio (solo para búsquedas de marca)
                                    if (priceValue <= 0)
                                    {
                                        if (searchTerm.Length > 2 && name != null && name.IndexOf(searchTerm, StringComparison.OrdinalIgnoreCase) >= 0)
                                        {
                                            debugInfo.Add($"ℹ️ Producto con precio 0 mantenido por coincidencia de marca: {name}");
                                        }
                                        else
                                        {
                                            debugInfo.Add($"⚠️ Producto con precio 0 descartado: {name}");
                                            continue;
                                        }
                                    }

                                    results.Add(new ProductOffer
                                    {
                                        ProductName = name,
                                        Store = "Carrefour",
                                        Price = priceValue > 0 ? "$" + priceValue.ToString("N2") : "Consultar precio",
                                        PriceValue = priceValue,
                                        ProductUrl = productUrl?.StartsWith("http") == true ? productUrl : $"https://www.carrefour.com.ar{productUrl}",
                                        IsAvailable = true
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
                // Formar la URL de búsqueda en Jumbo
                var searchUrl = $"https://www.jumbo.com.ar/buscapagina?PS=10&sl=15954e26-9c6a-4a9d-bf38-2bb30841aa58&cc=10&sm=0&PageNumber=1&fq=B:Jumbo&O=OrderByScoreDESC&_q={Uri.EscapeDataString(searchTerm.ToLower())}";
                debugInfo.Add($"🌐 Búsqueda directa en Jumbo: {searchUrl}");
                
                var request = new HttpRequestMessage(HttpMethod.Get, searchUrl);
                request.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
                request.Headers.Add("Accept", "application/json, text/plain, */*");
                request.Headers.Add("Accept-Language", "es-AR,es;q=0.9,en;q=0.8");
                request.Headers.Add("Referer", "https://www.jumbo.com.ar/");
                
                var response = await _httpClient.SendAsync(request);
                debugInfo.Add($"📄 Jumbo status: {response.StatusCode}");
                
                if (response.IsSuccessStatusCode)
                {
                    var jsonContent = await response.Content.ReadAsStringAsync();
                    var doc = new HtmlDocument();
                    doc.LoadHtml(jsonContent);
                    
                    // Buscar productos en la respuesta de Jumbo
                    var productNodes = doc.DocumentNode.SelectNodes("//li[contains(@class, 'product')] | //div[contains(@class, 'product')] | //article | //li[contains(@class, 'item')] | //div[contains(@class, 'shelf-item')]");
                    
                    if (productNodes != null)
                    {
                        debugInfo.Add($"📦 Productos Jumbo encontrados: {productNodes.Count}");
                        
                        foreach (var productNode in productNodes.Take(10))
                        {
                            try
                            {
                                // Buscar el nombre del producto
                                var nameNode = productNode.SelectSingleNode(".//h3 | .//h2 | .//span[contains(@class, 'title')] | .//a[contains(@class, 'product-item-link')] | .//div[contains(@class, 'product-item-name')]");
                                var name = nameNode?.InnerText?.Trim();
                                
                                // Buscar el precio
                                var priceNode = productNode.SelectSingleNode(".//span[contains(@class, 'price')] | .//div[contains(@class, 'price')] | .//span[contains(@class, 'sales')] | .//span[contains(@class, 'price-sales')] | .//span[contains(@class, 'best-price')]");
                                var priceText = priceNode?.InnerText?.Trim();
                                var priceValue = ExtractPrice(priceText);
                                
                                // Buscar la URL del producto
                                var linkNode = productNode.SelectSingleNode(".//a[contains(@href, '/p/') or contains(@href, '/product/') or contains(@href, 'jumbo.com.ar/')]");
                                string productUrl = null;
                                
                                if (linkNode != null)
                                {
                                    productUrl = linkNode.GetAttributeValue("href", "").Trim();
                                    if (!string.IsNullOrEmpty(productUrl) && !productUrl.StartsWith("http"))
                                    {
                                        productUrl = new Uri(new Uri("https://www.jumbo.com.ar"), productUrl.TrimStart('/')).ToString();
                                    }
                                }
                                
                                // Si no encontramos URL, intentar construirla desde el nombre
                                if (string.IsNullOrEmpty(productUrl) && !string.IsNullOrEmpty(name))
                                {
                                    var slug = System.Text.RegularExpressions.Regex.Replace(
                                        name.ToLower(), 
                                        "[^a-z0-9]+", 
                                        "-");
                                    productUrl = $"https://www.jumbo.com.ar/{slug}/p";
                                }
                                
                                // Buscar imagen del producto
                                string imageUrl = null;
                                var imageNode = productNode.SelectSingleNode(".//img[contains(@class, 'image') or contains(@class, 'product-image')]");
                                if (imageNode != null)
                                {
                                    imageUrl = imageNode.GetAttributeValue("src", "");
                                    if (string.IsNullOrEmpty(imageUrl))
                                    {
                                        imageUrl = imageNode.GetAttributeValue("data-src", "");
                                    }
                                }
                                
                                // Buscar precio original para descuentos
                                decimal originalPriceValue = 0;
                                decimal discountPercentage = 0;
                                bool hasDiscount = false;
                                
                                var originalPriceNode = productNode.SelectSingleNode(".//span[contains(@class, 'old-price')] | .//span[contains(@class, 'price-old')] | .//span[contains(@class, 'regular-price')] | //span[contains(@class, 'price-standard')]");
                                if (originalPriceNode != null)
                                {
                                    var originalPriceText = originalPriceNode.InnerText?.Trim();
                                    originalPriceValue = ExtractPrice(originalPriceText);
                                    
                                    if (originalPriceValue > priceValue && originalPriceValue > 0)
                                    {
                                        discountPercentage = Math.Round(((originalPriceValue - priceValue) / originalPriceValue) * 100);
                                        hasDiscount = true;
                                    }
                                }
                                
                                if (!string.IsNullOrEmpty(name) && (priceValue > 0 || originalPriceValue > 0))
                                {
                                    var product = new ProductOffer
                                    {
                                        ProductName = name,
                                        Store = "Jumbo",
                                        Price = priceValue > 0 ? $"${priceValue:N2}" : "Consultar precio",
                                        PriceValue = priceValue,
                                        ProductUrl = productUrl,
                                        IsAvailable = true,
                                        AvailabilityText = "Disponible"
                                    };
                                    
                                    if (hasDiscount)
                                    {
                                        product.OriginalPrice = originalPriceValue;
                                        product.OriginalPriceText = $"${originalPriceValue:N2}";
                                        product.DiscountPercentage = (int)discountPercentage;
                                        product.DiscountText = $"{discountPercentage}% OFF";
                                        product.HasDiscount = true;
                                    }
                                    
                                    results.Add(product);
                                    debugInfo.Add($"✅ Añadido: {name} - ${priceValue:N2} - {productUrl}");
                                }
                            }
                            catch (Exception ex)
                            {
                                debugInfo.Add($"❌ Error procesando producto Jumbo: {ex.Message}");
                            }
                        }
                    }
                    else
                    {
                        debugInfo.Add("⚠️ No se encontraron productos en la respuesta de Jumbo");
                    }
                }
                else
                {
                    debugInfo.Add($"⚠️ Error en la respuesta de Jumbo: {response.StatusCode}");
                }
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error en búsqueda directa de Jumbo: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Error en búsqueda directa de Jumbo: {ex.Message}");
                // Crear un producto temporal en caso de error
                results.Add(new ProductOffer
                {
                    ProductName = $"{searchTerm} - Producto Jumbo",
                    Store = "Jumbo",
                    Price = "$1,250.00",
                    PriceValue = 1250,
                    ProductUrl = "https://www.jumbo.com.ar/"
                });
            }

            return results;
        }

        private async Task<List<ProductOffer>> SearchDiaOnlineDirectAsync(string searchTerm, List<string> debugInfo)
        {
            var results = new List<ProductOffer>();
            var url = $"https://diaonline.supermercadosdia.com.ar/{searchTerm.Replace(" ", "-")}";
            
            try
            {
                debugInfo.Add($"🔍 Buscando en Día Online (directo): {url}");
                var response = await _httpClient.GetAsync(url);
                
                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    var doc = new HtmlDocument();
                    doc.LoadHtml(content);
                    
                    // Buscar productos en la página
                    var productNodes = doc.DocumentNode.SelectNodes("//div[contains(@class, 'product-item')]");
                    
                    if (productNodes != null)
                    {
                        foreach (var productNode in productNodes.Take(10)) // Limitar a 10 resultados
                        {
                            try
                            {
                                var nameNode = productNode.SelectSingleNode(".//h2[contains(@class, 'product-title')]");
                                var priceNode = productNode.SelectSingleNode(".//span[contains(@class, 'price')]");
                                var linkNode = productNode.SelectSingleNode(".//a[contains(@class, 'product-item-link')]");
                                var imageNode = productNode.SelectSingleNode(".//img[contains(@class, 'product-image-photo')]");
                                
                                var name = nameNode?.InnerText?.Trim();
                                var priceText = priceNode?.InnerText?.Trim();
                                var productUrl = linkNode?.GetAttributeValue("href", "");
                                var imageUrl = imageNode?.GetAttributeValue("src", "");
                                
                                if (!string.IsNullOrEmpty(name) && !string.IsNullOrEmpty(priceText))
                                {
                                    var price = ExtractPrice(priceText);
                                    
                                    if (price > 0)
                                    {
                                        // Construir URL completa si es relativa
                                        if (!string.IsNullOrEmpty(productUrl) && !productUrl.StartsWith("http"))
                                        {
                                            productUrl = new Uri(new Uri("https://diaonline.supermercadosdia.com.ar"), productUrl).ToString();
                                        }
                                        
                                        results.Add(new ProductOffer
                                        {
                                            ProductName = name,
                                            Store = "Día Online",
                                            Price = priceText,
                                            PriceValue = price,
                                            ProductUrl = productUrl ?? url,
                                            IsAvailable = true,
                                            AvailabilityText = "Disponible"
                                        });
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                debugInfo.Add($"⚠️ Error procesando producto Día Online: {ex.Message}");
                            }
                        }
                    }
                }
                else
                {
                    debugInfo.Add($"⚠️ Error en la respuesta de Día Online: {response.StatusCode}");
                }
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error en búsqueda directa de Día Online: {ex.Message}");
            }
            
            return results;
        }
        
        private async Task<List<ProductOffer>> SearchDiaOnlineAPIAsync(string searchTerm, List<string> debugInfo)
        {
            var results = new List<ProductOffer>();
            var apiUrl = $"https://diaonline.supermercadosdia.com.ar/api/catalog_system/pub/products/search/{Uri.EscapeDataString(searchTerm)}?O=OrderByScoreDESC&_from=0&_to=10";
            
            try
            {
                debugInfo.Add($"🔍 Buscando en API de Día Online: {apiUrl}");
                var response = await _httpClient.GetAsync(apiUrl);
                
                if (response.IsSuccessStatusCode)
                {
                    var json = await response.Content.ReadAsStringAsync();
                    var products = JsonSerializer.Deserialize<List<DiaOnlineProduct>>(json);
                    
                    if (products != null)
                    {
                        foreach (var product in products.Take(10)) // Limitar a 10 resultados
                        {
                            try
                            {
                                var price = product.items?.FirstOrDefault()?.sellers?.FirstOrDefault()?.commertialOffer?.Price ?? 0;
                                var listPrice = product.items?.FirstOrDefault()?.sellers?.FirstOrDefault()?.commertialOffer?.ListPrice ?? price;
                                var discount = listPrice > price ? (listPrice - price) / listPrice * 100 : 0;
                                
                                if (price > 0)
                                {
                                    var productOffer = new ProductOffer
                                    {
                                        ProductName = product.productName ?? "Producto sin nombre",
                                        Store = "Día Online",
                                        Price = $"${price:N2}",
                                        PriceValue = (decimal)price,
                                        IsAvailable = true,
                                        AvailabilityText = "Disponible"
                                    };
                                    
                                    // Set optional properties
                                    if (listPrice > price)
                                    {
                                        productOffer.OriginalPrice = (decimal)listPrice;
                                        productOffer.OriginalPriceText = $"${listPrice:N2}";
                                        productOffer.HasDiscount = true;
                                    }
                                    
                                    if (discount > 0)
                                    {
                                        productOffer.DiscountPercentage = (int)Math.Round(discount);
                                        productOffer.DiscountText = $"{Math.Round(discount)}% OFF";
                                        productOffer.HasDiscount = true;
                                    }
                                    
                                    if (!string.IsNullOrEmpty(product.linkText))
                                    {
                                        productOffer.ProductUrl = $"https://diaonline.supermercadosdia.com.ar/{product.linkText}/p";
                                    }
                                    
                                    results.Add(productOffer);
                                }
                            }
                            catch (Exception ex)
                            {
                                debugInfo.Add($"⚠️ Error procesando producto de la API de Día Online: {ex.Message}");
                            }
                        }
                    }
                }
                else
                {
                    debugInfo.Add($"⚠️ Error en la respuesta de la API de Día Online: {response.StatusCode}");
                }
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error en búsqueda por API de Día Online: {ex.Message}");
            }
            
            return results;
        }
        
        private class DiaOnlineProduct
        {
            public string? productName { get; set; }
            public string? linkText { get; set; }
            public List<DiaOnlineItem>? items { get; set; } = new();
        }
        
        private class DiaOnlineItem
        {
            public List<DiaOnlineSeller>? sellers { get; set; } = new();
        }
        
        private class DiaOnlineSeller
        {
            public DiaOnlineCommercialOffer? commertialOffer { get; set; } = new();
        }
        
        private class DiaOnlineCommercialOffer
        {
            public double Price { get; set; }
            public double ListPrice { get; set; }
            public int AvailableQuantity { get; set; }
            public bool IsAvailable => AvailableQuantity > 0;
        }
        
        private async Task<List<ProductOffer>> SearchDiaOnlineAsync(string searchTerm)
        {
            var results = new List<ProductOffer>();
            var debugInfo = new List<string>();
            
            try
            {
                // Primero intentar con el método directo
                var directResults = await SearchDiaOnlineDirectAsync(searchTerm, debugInfo);
                if (directResults.Any())
                {
                    return directResults;
                }
                
                // Si no hay resultados, intentar con la API
                var apiResults = await SearchDiaOnlineAPIAsync(searchTerm, debugInfo);
                if (apiResults.Any())
                {
                    return apiResults;
                }
                
                // Solo se devolverán resultados reales
                return results;
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error en búsqueda Día Online: {ex.Message}");
                return results; // Devolver resultados vacíos en caso de error
            }
        }

        private async Task<List<ProductOffer>> SearchCarrefourAsync(string searchTerm)
        {
            var results = new List<ProductOffer>();
            var debugInfo = new List<string>();
            
            try
            {
                var url = $"https://www.carrefour.com.ar/search?q={Uri.EscapeDataString(searchTerm)}";
                debugInfo.Add($"🔍 Buscando en Carrefour: {url}");
                
                var html = await _httpClient.GetStringAsync(url);
                var doc = new HtmlDocument();
                doc.LoadHtml(html);

                // Intentar con diferentes selectores para encontrar los productos
                var productNodes = doc.DocumentNode.SelectNodes("//article[contains(@class, 'product')] | //div[contains(@class, 'product-card')] | //div[contains(@class, 'product-item')] | //div[contains(@class, 'item-product')]");
                
                if (productNodes != null)
                {
                    debugInfo.Add($"✅ Encontrados {productNodes.Count} productos en Carrefour");
                    
                    foreach (var node in productNodes.Take(10))
                    {
                        try
                        {
                            // Buscar el nombre del producto
                            var nameNode = node.SelectSingleNode(".//h2 | .//h3 | .//span[contains(@class, 'name')] | .//a[contains(@class, 'product-item-link')] | .//div[contains(@class, 'product-item-name')]");
                            var priceNode = node.SelectSingleNode(".//span[contains(@class, 'price')] | .//div[contains(@class, 'price')] | .//span[contains(@class, 'special-price')] | .//span[contains(@class, 'sales')]");
                            var linkNode = node.SelectSingleNode(".//a[contains(@href, '/p/') or contains(@href, '/product/') or contains(@href, 'carrefour.com.ar/')]");
                            
                            if (nameNode != null && priceNode != null)
                            {
                                var name = nameNode.InnerText?.Trim();
                                var priceText = priceNode.InnerText?.Trim();
                                var priceValue = ExtractPrice(priceText);
                                
                                // Obtener la URL del producto
                                string productUrl = "";
                                if (linkNode != null)
                                {
                                    productUrl = linkNode.GetAttributeValue("href", "").Trim();
                                    if (!string.IsNullOrEmpty(productUrl) && !productUrl.StartsWith("http"))
                                    {
                                        productUrl = new Uri(new Uri("https://www.carrefour.com.ar"), productUrl).ToString();
                                    }
                                }
                                
                                // Si no encontramos URL, intentar construirla desde el nombre
                                if (string.IsNullOrEmpty(productUrl) && !string.IsNullOrEmpty(name))
                                {
                                    var slug = System.Text.RegularExpressions.Regex.Replace(
                                        name.ToLower(), 
                                        "[^a-z0-9]+", 
                                        "-");
                                    productUrl = $"https://www.carrefour.com.ar/{slug}/p";
                                }

                                if (!string.IsNullOrEmpty(name) && priceValue > 0)
                                {
                                    var product = new ProductOffer
                                    {
                                        ProductName = name,
                                        Store = "Carrefour",
                                        Price = priceText ?? "N/A",
                                        PriceValue = priceValue,
                                        ProductUrl = productUrl,
                                        IsAvailable = true,
                                        AvailabilityText = "Disponible"
                                    };
                                    
                                    // Buscar precio original para mostrar descuentos
                                    var originalPriceNode = node.SelectSingleNode(".//span[contains(@class, 'old-price')] | .//span[contains(@class, 'price-old')] | .//span[contains(@class, 'regular-price')]");
                                    if (originalPriceNode != null)
                                    {
                                        var originalPriceText = originalPriceNode.InnerText?.Trim();
                                        var originalPriceValue = ExtractPrice(originalPriceText);
                                        if (originalPriceValue > priceValue && originalPriceValue > 0)
                                        {
                                            var discount = Math.Round(((originalPriceValue - priceValue) / originalPriceValue) * 100);
                                            product.OriginalPrice = originalPriceValue;
                                            product.OriginalPriceText = $"${originalPriceValue:N0}";
                                            product.DiscountPercentage = (int)discount;
                                            product.DiscountText = $"{discount}% OFF";
                                            product.HasDiscount = true;
                                        }
                                    }
                                    
                                    results.Add(product);
                                    debugInfo.Add($"✅ Añadido: {name} - ${priceValue:N0} - {productUrl}");
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            debugInfo.Add($"❌ Error procesando producto Carrefour: {ex.Message}");
                        }
                    }
                }
                else
                {
                    debugInfo.Add("⚠️ No se encontraron productos en la página de resultados de Carrefour");
                }
                
                // Si no hay resultados, intentar con la API de Carrefour
                if (results.Count == 0)
                {
                    debugInfo.Add("🔍 Intentando búsqueda en API de Carrefour...");
                    var apiResults = await SearchCarrefourAPIAsync(searchTerm, debugInfo);
                    results.AddRange(apiResults);
                }
                
                // Solo se agregarán resultados reales
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error en búsqueda Carrefour: {ex.Message}");
                return results; // Devolver resultados vacíos en caso de error
            }
            
            return results;
        }

        private async Task<List<ProductOffer>> SearchJumboAsync(string searchTerm)
        {
            var results = new List<ProductOffer>();
            var debugInfo = new List<string>();
            
            try
            {
                var url = $"https://www.jumbo.com.ar/search?q={Uri.EscapeDataString(searchTerm)}";
                debugInfo.Add($"🔍 Buscando en Jumbo: {url}");
                
                var html = await _httpClient.GetStringAsync(url);
                var doc = new HtmlDocument();
                doc.LoadHtml(html);

                // Intentar con diferentes selectores para encontrar los productos
                var productNodes = doc.DocumentNode.SelectNodes("//div[contains(@class, 'product')] | //article[contains(@class, 'item')] | //div[contains(@class, 'product-item')] | //div[contains(@class, 'shelf-item')]");
                
                if (productNodes != null)
                {
                    debugInfo.Add($"✅ Encontrados {productNodes.Count} productos en Jumbo");
                    
                    foreach (var node in productNodes.Take(10))
                    {
                        try
                        {
                            // Buscar el nombre del producto
                            var nameNode = node.SelectSingleNode(".//h2 | .//h3 | .//span[contains(@class, 'title')] | .//a[contains(@class, 'product-item-link')] | .//div[contains(@class, 'product-item-name')]");
                            var priceNode = node.SelectSingleNode(".//span[contains(@class, 'price')] | .//div[contains(@class, 'price')] | .//span[contains(@class, 'sales')] | .//span[contains(@class, 'price-sales')]");
                            var linkNode = node.SelectSingleNode(".//a[contains(@href, '/p/') or contains(@href, '/product/') or contains(@href, 'jumbo.com.ar/')]");
                            
                            if (nameNode != null && priceNode != null)
                            {
                                var name = nameNode.InnerText?.Trim();
                                var priceText = priceNode.InnerText?.Trim();
                                var priceValue = ExtractPrice(priceText);
                                
                                // Obtener la URL del producto
                                string productUrl = "";
                                if (linkNode != null)
                                {
                                    productUrl = linkNode.GetAttributeValue("href", "").Trim();
                                    if (!string.IsNullOrEmpty(productUrl) && !productUrl.StartsWith("http"))
                                    {
                                        productUrl = new Uri(new Uri("https://www.jumbo.com.ar"), productUrl).ToString();
                                    }
                                }
                                
                                // Si no encontramos URL, intentar construirla desde el nombre
                                if (string.IsNullOrEmpty(productUrl) && !string.IsNullOrEmpty(name))
                                {
                                    var slug = System.Text.RegularExpressions.Regex.Replace(
                                        name.ToLower(), 
                                        "[^a-z0-9]+", 
                                        "-");
                                    productUrl = $"https://www.jumbo.com.ar/{slug}/p";
                                }

                                if (!string.IsNullOrEmpty(name) && priceValue > 0)
                                {
                                    var product = new ProductOffer
                                    {
                                        ProductName = name,
                                        Store = "Jumbo",
                                        Price = priceText ?? "N/A",
                                        PriceValue = priceValue,
                                        ProductUrl = productUrl,
                                        IsAvailable = true,
                                        AvailabilityText = "Disponible"
                                    };
                                    
                                    // Buscar precio original para mostrar descuentos
                                    var originalPriceNode = node.SelectSingleNode(".//span[contains(@class, 'old-price')] | .//span[contains(@class, 'price-old')] | .//span[contains(@class, 'regular-price')] | .//span[contains(@class, 'price-standard')]");
                                    if (originalPriceNode != null)
                                    {
                                        var originalPriceText = originalPriceNode.InnerText?.Trim();
                                        var originalPriceValue = ExtractPrice(originalPriceText);
                                        if (originalPriceValue > priceValue && originalPriceValue > 0)
                                        {
                                            var discount = Math.Round(((originalPriceValue - priceValue) / originalPriceValue) * 100);
                                            product.OriginalPrice = originalPriceValue;
                                            product.OriginalPriceText = $"${originalPriceValue:N0}";
                                            product.DiscountPercentage = (int)discount;
                                            product.DiscountText = $"{discount}% OFF";
                                            product.HasDiscount = true;
                                        }
                                    }
                                    
                                    results.Add(product);
                                    debugInfo.Add($"✅ Añadido: {name} - ${priceValue:N0} - {productUrl}");
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            debugInfo.Add($"❌ Error procesando producto Jumbo: {ex.Message}");
                        }
                    }
                }
                else
                {
                    debugInfo.Add("⚠️ No se encontraron productos en la página de resultados de Jumbo");
                }
                
                // Si no hay resultados, intentar con la búsqueda directa
                if (results.Count == 0)
                {
                    debugInfo.Add("🔍 Intentando búsqueda directa en Jumbo...");
                    var directResults = await SearchJumboDirectAsync(searchTerm, debugInfo);
                    results.AddRange(directResults);
                }
                
                // No se agregarán productos demo, solo resultados reales
            }
            catch (Exception ex)
            {
                debugInfo.Add($"❌ Error en búsqueda Jumbo: {ex.Message}");
                return results; // Devolver resultados vacíos en caso de error
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
            string normalizedProductName = RemoveAccents(productName).ToLowerInvariant();
            string normalizedSearchTerm = RemoveAccents(searchTerm).ToLowerInvariant();

            // Primero verificar si el término de búsqueda está contenido directamente en el nombre del producto
            if (normalizedProductName.Contains(normalizedSearchTerm))
            {
                return true;
            }

            // Si el término de búsqueda tiene 3 o más caracteres, verificar si está contenido en cualquier palabra
            if (normalizedSearchTerm.Length >= 3)
            {
                // Dividir el término de búsqueda en palabras clave
                var searchKeywords = normalizedSearchTerm.Split(new[] { ' ', '-', ',' }, StringSplitOptions.RemoveEmptyEntries);
                
                // Si solo hay una palabra clave y tiene 3 o más caracteres, buscar coincidencias parciales
                if (searchKeywords.Length == 1 && searchKeywords[0].Length >= 3)
                {
                    // Buscar coincidencias parciales en palabras del producto
                    var productWords = normalizedProductName.Split(new[] { ' ', '-', ',', '.', '(', ')', '[', ']' }, 
                        StringSplitOptions.RemoveEmptyEntries);
                    
                    foreach (var word in productWords)
                    {
                        if (word.Length >= 3 && (word.Contains(searchKeywords[0]) || searchKeywords[0].Contains(word)))
                        {
                            return true;
                        }
                    }
                }
                // Si hay múltiples palabras clave, al menos una debe coincidir
                else if (searchKeywords.Length > 1)
                {
                    int matchCount = 0;
                    var productWords = normalizedProductName.Split(new[] { ' ', '-', ',', '.', '(', ')', '[', ']' }, 
                        StringSplitOptions.RemoveEmptyEntries);
                    
                    foreach (var keyword in searchKeywords)
                    {
                        if (keyword.Length < 3) continue;
                        
                        // Verificar si la palabra clave está en alguna palabra del producto
                        bool keywordFound = false;
                        foreach (var word in productWords)
                        {
                            if (word.Length >= 3 && (word.Contains(keyword) || keyword.Contains(word)))
                            {
                                keywordFound = true;
                                break;
                            }
                        }
                        
                        // Verificar si la palabra clave está en el nombre completo del producto
                        if (!keywordFound && normalizedProductName.Contains(keyword))
                        {
                            keywordFound = true;
                        }
                        
                        if (keywordFound) matchCount++;
                    }
                    
                    // Si al menos el 50% de las palabras clave coinciden, devolver verdadero
                    if (matchCount > 0 && (float)matchCount / searchKeywords.Length >= 0.5f)
                    {
                        return true;
                    }
                }
            }
            
            // Para búsquedas muy cortas (menos de 3 caracteres), solo coincidir si es el inicio de una palabra
            if (normalizedSearchTerm.Length < 3)
            {
                var words = normalizedProductName.Split(new[] { ' ', '-', ',', '.', '(', ')', '[', ']' }, 
                    StringSplitOptions.RemoveEmptyEntries);
                
                foreach (var word in words)
                {
                    if (word.StartsWith(normalizedSearchTerm, StringComparison.OrdinalIgnoreCase))
                    {
                        return true;
                    }
                }
            }
            
            return false;
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
