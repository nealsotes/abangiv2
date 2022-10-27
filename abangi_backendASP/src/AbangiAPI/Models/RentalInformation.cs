using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Models
{
    public class RentalInformation
    {
        public int RentalId {get; set;}
    
        public string RenterName {get; set;}
        public string ItemName {get; set;}
        public string ItemImage {get; set;}
        public string ItemCategory {get; set;}
        public string ItemLocation {get; set;}
        public string ItemOwner {get; set;}
        public string ItemRentalMethod {get; set;}
        public bool AbangiVerified {get; set;}
        public string RentalStatus {get; set;}
        public string RentalRemarks {get; set;}
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }

    }
}