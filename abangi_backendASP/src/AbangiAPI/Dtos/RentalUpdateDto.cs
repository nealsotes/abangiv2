using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Dtos
{
    public class RentalUpdateDto
    {
        public int RentalId { get; set; }
        public int UserId { get; set; }
        public int ItemId { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string RentalStatus { get; set; }
        public string RentalRemarks { get; set; }
    }
}