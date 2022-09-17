using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Models
{
    public class Listing
    {   
        [Key]
        public int ListingId {get; set;}
        public string ListingName {get; set;}
        public string ListingDescription {get; set;}
    }
}