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
        Task<Rental> GetIdPatch(int id);
        void CreateRental(Rental rental);
        Task<IEnumerable<RentalInformation>> GetRentalByUserId(int id);
        Task<IEnumerable<RentalInformation>> GetRentalByOwnerId(int id);
        void UpdateViaPatch(Rental rental);
        void DeleteRental(Rental rental);
    }
}