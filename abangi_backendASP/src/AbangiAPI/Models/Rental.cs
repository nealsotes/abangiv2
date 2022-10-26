using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Entities;

namespace AbangiAPI.Models
{
    public class Rental
    {
        [Key]
        public int RentalId { get; set; }
        public int ItemId { get; set; }
        public Item Item { get; set; }
        public int UserId { get; set; }
        public User User { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public String RentalStatus { get; set; }
        public DateTime DateCreated { get; set; }
        public string RentalRemarks { get; set; }
        public ICollection<Item> Items { get; set; }
        
    }
}