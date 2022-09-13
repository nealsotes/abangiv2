using System.ComponentModel.DataAnnotations.Schema;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Entities;
namespace AbangiAPI.Models
{
    public class Item
    {   
        [Key]
        [Required]
        public int ItemId {get; set;}

        [ForeignKey("ItemCategoryId")]
        public ItemCategory ItemCategory {get; set;}
    
        [ForeignKey("UserId")]
        public User User {get; set;}
        public string ItemImage {get; set;}

        [Required]
        [MaxLength(250)]
        public string ItemName {get;set;}
        [Required]
        public double ItemPrice {get; set;}
        [Required]
        [MaxLength(150)]
        public string ItemDescription {get; set;}

        public List<ItemCategory> ItemCategories {get; set;}
    }
}