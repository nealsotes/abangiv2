using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Dtos
{
    public class ItemUpdateDto
    {
        [Required]
        public string ItemName { get; set; }
        [Required]
        public double ItemPrice { get; set; }
        [Required]
        public string ItemDescription { get; set; }
        [Required]
        public string ItemImage { get; set; }

    }
}