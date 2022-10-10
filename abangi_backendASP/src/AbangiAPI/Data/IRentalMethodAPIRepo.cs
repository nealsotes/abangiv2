using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models;

namespace AbangiAPI.Data
{
    public interface IRentalMethodAPIRepo
    {
        bool SaveChanges();
        Task<IEnumerable<RentalMethod>> GetAllRentalMethods();
        Task<RentalMethod> GetRentalMethodById(int id);
        void CreateRentalMethod(RentalMethod rentalMethod);
        void UpdateRentalMethod(RentalMethod rentalMethod);
        void DeleteRentalMethod(RentalMethod rentalMethod);
    }
}