using System.ComponentModel.DataAnnotations.Schema;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

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
    }
}