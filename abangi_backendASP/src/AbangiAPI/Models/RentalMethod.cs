using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Models
{
    public class RentalMethod
    {
        [Key]
        public int RentalMethodId {get; set;}
        [Required]
        public string RentalMethodName {get; set;}
        public string RentalMethodDescription {get; set;}
    }
}