using System.ComponentModel.DataAnnotations.Schema;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using System.ComponentModel.DataAnnotations;

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
        [Column("AbangiVerified")]
        public bool AbangiVerified {get; set;}
        [Column("Status")]
        public string Status {get; set;}

        [DataType(DataType.Date)]
        public DateTime DateCreated {get; set;}
        [DataType(DataType.Date)]
        public DateTime StartDate {get; set;}
        [DataType(DataType.Date)]
        public DateTime EndDate {get; set;}
    }
}