using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Entities;
using Microsoft.AspNetCore.Http;

namespace AbangiAPI.Models
{
    public class Item
    {   
      

        [Key]
        [Required]
        public int ItemId {get; set;}

        public ItemCategory ItemCategory {get; set;}
        public int ItemCategoryId {get; set;}

        public User User {get; set;}
        public int UserId {get; set;}
        public int RentalMethodId {get; set;}

        
        [Required]
        
        public string ItemImage {get; set;}

        [DataType(DataType.Date)]
        public DateTime DateCreated {get; set;}
        [DataType(DataType.Date)]
        public DateTime StartDate {get; set;}
        [DataType(DataType.Date)]
        public DateTime EndDate {get; set;}

        [Required]
        [MaxLength(250)]
        public string ItemName {get;set;}
        [Required]
        public double ItemPrice {get; set;}
        public string ItemLocation {get; set;}
        
        [Required]  
        [MaxLength(150)]
        public string ItemDescription {get; set;}
       
    }
}