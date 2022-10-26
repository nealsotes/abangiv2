using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models;

namespace AbangiAPI.Data
{
    public interface IRentalAPIRepo
    {
        bool SaveChanges();
        Task<IEnumerable<RentalInformation>> GetAllRentals();
        Task<RentalInformation> GetRentalById(int id);
        void CreateRental(Rental rental);
        Task<RentalInformation> GetRentalByUserId(int id);
    }
}