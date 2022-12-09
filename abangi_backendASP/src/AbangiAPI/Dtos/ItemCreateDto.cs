using System.Diagnostics;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using System.Text.Json;
using Newtonsoft.Json;
namespace AbangiAPI.Dtos
{
    public class ItemCreateDto
    {
        
        
        public int ItemCategoryId { get; set; }
        [Required]
        public int UserId { get; set; }

        [Required(ErrorMessage = "Item name is required")]
        public string ItemName { get; set; }
        [Required(ErrorMessage = "Price is required")]
        public double ItemPrice { get; set; }
        [Required(ErrorMessage = "Description is required")]
        public string ItemDescription { get; set; }
       
        public IFormFile Image { get; set; }
       
        public string ItemImage { get; set; }
        [Required(ErrorMessage = "Location is required")]
        public string ItemLocation { get; set; }
        [Required]
        public int RentalMethodId { get; set; }
        
      
        [DataType(DataType.Date)]
        public DateTime DateCreated {get; set;}
        [DataType(DataType.Date)]
        [Required(ErrorMessage = "Start date is required")]
        public DateTime StartDate {get; set;}
        [Required(ErrorMessage = "End date is required")]
        [DataType(DataType.Date)]
        public DateTime EndDate {get; set;}

      public ItemCreateDto()
      {
          DateCreated = DateTime.Now;
      }
    }
}