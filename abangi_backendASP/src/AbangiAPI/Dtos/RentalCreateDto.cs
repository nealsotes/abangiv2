using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AbangiAPI.Dtos
{
    public class RentalCreateDto
    {
        public RentalCreateDto()
        {
            DateCreated = DateTime.Now;
        }
        public int RentalId { get; set; }
        public int UserId { get; set; }
        public int ItemId { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public String RentalStatus { get; set; }
        public DateTime DateCreated { get; set; }
    }
}