using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Dtos
{
    public class ItemCreateDto
    {
        public int ItemCategoryId { get; set; }
        public int UserId { get; set; }

        [Required]
        public string ItemName { get; set; }
        [Required]
        public double ItemPrice { get; set; }
        [Required]
        public string ItemDescription { get; set; }
        [Required]
        public string ItemImage { get; set; }
    }
}