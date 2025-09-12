using Microsoft.Maui.Controls;
using PriceTrackerApp.Services;
using PriceTrackerApp.Models;

namespace PriceTrackerApp
{
    public partial class MainPage : ContentPage
    {
        private readonly PriceScrapingService _scrapingService;

        public MainPage()
        {
            InitializeComponent();
            _scrapingService = new PriceScrapingService();
        }

        private async void OnSearchClicked(object sender, EventArgs e)
        {
            var searchTerm = SearchEntry.Text?.Trim();
            
            if (string.IsNullOrEmpty(searchTerm))
            {
                await DisplayAlert("Error", "Por favor ingresa un término de búsqueda", "OK");
                return;
            }

            // Mostrar indicador de carga
            LoadingIndicator.IsVisible = true;
            LoadingIndicator.IsRunning = true;
            LoadingLabel.IsVisible = true;
            ResultsCollectionView.IsVisible = false;

            try
            {
                // Obtener configuración de tiendas seleccionadas
                bool searchDiaOnline = DiaOnlineCheck.IsChecked;
                bool searchCarrefour = CarrefourCheck.IsChecked;
                bool searchJumbo = JumboCheck.IsChecked;

                if (!searchDiaOnline && !searchCarrefour && !searchJumbo)
                {
                    await DisplayAlert("Error", "Por favor selecciona al menos una tienda", "OK");
                    return;
                }

                // Debug: Mostrar información de búsqueda
                await DisplayAlert("Debug", $"Buscando '{searchTerm}' en:\nDía: {searchDiaOnline}\nCarrefour: {searchCarrefour}\nJumbo: {searchJumbo}", "OK");

                // Realizar búsqueda
                var debugInfo = new List<string>();
                var results = await _scrapingService.SearchProductsAsync(searchTerm, searchDiaOnline, searchCarrefour, searchJumbo, debugInfo);

                // Debug: Mostrar información detallada
                var debugText = string.Join("\n", debugInfo);
                await DisplayAlert("Debug Detallado", debugText, "OK");

                // Mostrar resultados
                ResultsCollectionView.ItemsSource = results;
                ResultsCollectionView.IsVisible = true;

                if (results?.Count == 0)
                {
                    await DisplayAlert("Sin resultados", "No se encontraron productos para tu búsqueda", "OK");
                }
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error", $"Ocurrió un error durante la búsqueda: {ex.Message}", "OK");
            }
            finally
            {
                // Ocultar indicador de carga
                LoadingIndicator.IsVisible = false;
                LoadingIndicator.IsRunning = false;
                LoadingLabel.IsVisible = false;
            }
        }

        private async void OnOpenProductClicked(object sender, EventArgs e)
        {
            if (sender is Button button && button.CommandParameter is ProductOffer product)
            {
                if (!string.IsNullOrEmpty(product.ProductUrl))
                {
                    try
                    {
                        await Launcher.OpenAsync(product.ProductUrl);
                    }
                    catch (Exception ex)
                    {
                        await DisplayAlert("Error", $"No se pudo abrir el enlace: {ex.Message}", "OK");
                    }
                }
                else
                {
                    await DisplayAlert("Error", "No hay enlace disponible para este producto", "OK");
                }
            }
        }
    }
}
