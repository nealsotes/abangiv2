using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Models.Stripe
{
    public class CollectingFeesResource
    {
        public long Amount { get; set; }
        public string Currency { get; set; }
        public long TransactionFee { get; set; } = 100;


    }
}