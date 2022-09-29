using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace AbangiAPI.Dtos
{
    public class ItemCreateDto
    {
        public int ItemCategoryId { get; set; }
        [Required]
        public int UserId { get; set; }

        [Required]
        public string ItemName { get; set; }
        [Required]
        public double ItemPrice { get; set; }
        [Required]
        public string ItemDescription { get; set; }
       
        public string ItemImage { get; set; }
        [Required]
        public string ItemLocation { get; set; }
        [Required]
        public int RentalMethodId { get; set; }
    }
}