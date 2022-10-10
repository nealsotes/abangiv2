using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Helpers;
using AbangiAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace AbangiAPI.Data.SqlRepo
{
    public class SqlRentaMethodAPIREpo : IRentalMethodAPIRepo
    {
        private readonly DataContext _context;
        public SqlRentaMethodAPIREpo(DataContext context)
        {
            _context = context;
        }
        public void CreateRentalMethod(RentalMethod rentalMethod)
        {
            if(rentalMethod == null)
            {
                throw new ArgumentNullException(nameof(rentalMethod));
            }
          _context.RentalMethods.Add(rentalMethod);
        }

        public void DeleteRentalMethod(RentalMethod rentalMethod)
        {
            if(rentalMethod == null)
            {
                throw new ArgumentNullException(nameof(rentalMethod));
            }
            _context.RentalMethods.Remove(rentalMethod);
        }

        public async Task<IEnumerable<RentalMethod>> GetAllRentalMethods()
        {
           return await _context.RentalMethods.ToListAsync();
        }

        public async Task<RentalMethod> GetRentalMethodById(int id)
        {
            return await _context.RentalMethods.FirstOrDefaultAsync(p => p.RentalMethodId == id);
        }

        public bool SaveChanges()
        {
            return (_context.SaveChanges() >= 0);
        }

        public void UpdateRentalMethod(RentalMethod rentalMethod)
        {
            throw new NotImplementedException();
        }
    }
}