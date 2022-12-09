using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Models
{
    public class TransactionHistory
    {
        public int Id { get; set; }
        public string Renter { get; set; }
        
        public string Owner { get; set; }
        public string ItemRented { get; set; }
      
        public DateTime DateRented { get; set; }
        public DateTime DateReturned { get; set; }
        public string PaymentStatus { get; set; }
        public int AmountPaid { get; set; }
        public string ItemLocation { get; set; }
        public int ItemPrice { get; set; }
        public string ItemCategory { get; set; }
        public string PaymentMethod { get; set; }
        public string TransactionStatus { get; set; }
        public DateTime TimeStamp { get; set; }
        

        public TransactionHistory()
        {
            TimeStamp = DateTime.Now;
        }
        
    }
}