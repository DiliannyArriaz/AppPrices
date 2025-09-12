using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PriceTrackerApp.Models
{
    public class ProductOffer
    {
        public string ProductName { get; set; } = string.Empty;
        public string Store { get; set; } = string.Empty;
        public string Price { get; set; } = string.Empty;
        public string ProductUrl { get; set; } = string.Empty;
        public decimal PriceValue { get; set; }
        public bool IsAvailable { get; set; } = true;
        public string AvailabilityText { get; set; } = "Disponible";
        
        // Propiedades para descuentos
        public decimal OriginalPrice { get; set; }
        public string OriginalPriceText { get; set; } = string.Empty;
        public int DiscountPercentage { get; set; }
        public bool HasDiscount { get; set; }
        public string DiscountText { get; set; } = string.Empty;
        
        // Propiedades para promociones especiales
        public bool HasSpecialPromotion { get; set; }
        public string PromotionText { get; set; } = string.Empty;
    }
}
