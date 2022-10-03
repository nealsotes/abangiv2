using System.ComponentModel.DataAnnotations.Schema;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace AbangiAPI.Models
{
    public class ItemInformation
    {
        public int ItemId {get; set;}
        public string ItemName {get; set;}
        [Column("Description")]
        public string Description {get; set;}
        [Column("Price")]
        public double Price {get; set;}
        [Column("Category")]
        public string Category {get; set;}
        [Column("Owner")]
        public string Owner{get; set;}
        [Column("RentalMethod")]
        public string RentalMethod {get; set;}
        [Column("Location")]
        public string Location {get; set;}
        [Column("Image")]
        public string Image {get; set;}
        
    }
}