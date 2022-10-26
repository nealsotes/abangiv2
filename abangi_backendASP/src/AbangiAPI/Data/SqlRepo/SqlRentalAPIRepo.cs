using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Helpers;
using AbangiAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace AbangiAPI.Data.SqlRepo
{
    public class SqlRentalAPIRepo : IRentalAPIRepo
    {
        private readonly DataContext _context;
        public SqlRentalAPIRepo(DataContext context)
        {
            _context = context;
        }
       
        public async void CreateRental(Rental rental)
        {
            if(rental == null)
            {
                throw new ArgumentNullException(nameof(rental));
            }
           await _context.Rentals.AddAsync(rental);
        }

        public async Task<IEnumerable<RentalInformation>> GetAllRentals()
        {
            var rentalList = await (from r in _context.Rentals
                              join i in _context.Items on r.ItemId equals i.ItemId
                              join u in _context.Users on r.UserId equals u.UserId
                
                              join c in _context.UserRoles on u.UserId equals c.UserId
                             
                              select new RentalInformation
                              {
                                  RentalId = r.RentalId,
                                  RenterName = u.FullName,
                                  ItemName = i.ItemName,
                                  ItemImage = i.ItemImage,
                                  ItemCategory = i.ItemCategory.ItemCategoryName,
                                  ItemLocation = i.ItemLocation,
                                  ItemOwner = i.User.FullName,
                                  AbangiVerified = c.AbangiVerified,
                                  RentalStatus = r.RentalStatus,
                                  StartDate = r.StartDate,
                                  EndDate = r.EndDate
                              }).ToListAsync();
            return rentalList;
        }

        public async Task<RentalInformation> GetRentalById(int id)
        {
            var rental = await (from r in _context.Rentals
                          join i in _context.Items on r.ItemId equals i.ItemId
                          join u in _context.Users on r.UserId equals u.UserId
                          join c in _context.UserRoles on u.UserId equals c.UserId
                          where r.RentalId == id
                          select new RentalInformation
                          {
                              RentalId = r.RentalId,
                              RenterName = u.FullName,
                              ItemName = i.ItemName,
                              ItemImage = i.ItemImage,
                              ItemCategory = i.ItemCategory.ItemCategoryName,
                              ItemLocation = i.ItemLocation,
                              AbangiVerified = c.AbangiVerified,
                              RentalStatus = r.RentalStatus,
                              StartDate = r.StartDate,
                              EndDate = r.EndDate
                          }).FirstOrDefaultAsync(r => r.RentalId == id);
            return rental;
        }

        public async Task<RentalInformation> GetRentalByUserId(int id)
        {
            var rentalList = await (from r in _context.Rentals
                              join i in _context.Items on r.ItemId equals i.ItemId
                              join u in _context.Users on r.UserId equals u.UserId
                              join c in _context.UserRoles on u.UserId equals c.UserId
                              where u.UserId == id
                              select new RentalInformation
                              {
                                  RentalId = r.RentalId,
                                  RenterName = u.FullName,
                                  ItemName = i.ItemName,
                                  ItemImage = i.ItemImage,
                                  ItemCategory = i.ItemCategory.ItemCategoryName,
                                  ItemLocation = i.ItemLocation,
                                  AbangiVerified = c.AbangiVerified,
                                  RentalStatus = r.RentalStatus,
                                  StartDate = r.StartDate,
                                  EndDate = r.EndDate
                              }).FirstOrDefaultAsync();
            return rentalList;
        }

        public bool SaveChanges()
        {
             return (_context.SaveChanges() >= 0);
        }
    }
}