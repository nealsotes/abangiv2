using System.Collections.ObjectModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Models.Stripe
{
    public class CreateCustomerResource
    {
        public string Email { get; set; }
        public string Name  { get; set; }
        
       public CreateCardResource Card { get; set; }
    }
}