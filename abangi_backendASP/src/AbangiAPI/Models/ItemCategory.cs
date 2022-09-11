using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Models
{
    public class ItemCategory
    {
        [Key]
        [Required]
        public int ItemCategoryId {get; set;}
        [Required]
        [MaxLength(100)]
        public string ItemCategoryName {get; set;}
        [Required]
        [MaxLength(150)]
        public string ItemCategoryDescription {get; set;}
    }
}