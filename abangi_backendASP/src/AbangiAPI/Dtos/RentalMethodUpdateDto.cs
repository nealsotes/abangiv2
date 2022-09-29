using System;
using System.Collections.Generic;
using System.Linq;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;

namespace AbangiAPI.Dtos
{
    public class RentalMethodUpdateDto
    {
        [Required]
        public string RentalMethodName { get; set; }

        public string RentalMethodDescription { get; set; }
    
    }
}