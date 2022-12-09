using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Models.Stripe
{
    public class ChargeResource
    {
        public string ChargeId { get; set; }
        public string Currency { get; set; }
        public long Amount { get; set; }
        public string CustomerId { get; set; }
        public string ReceiptEmail { get; set; }
        public string Description { get; set; }
    }
}