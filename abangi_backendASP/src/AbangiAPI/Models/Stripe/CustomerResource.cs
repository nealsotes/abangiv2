using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Models.Stripe
{
    public class CustomerResource
    {
        public string CustomerId { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }
    }
}