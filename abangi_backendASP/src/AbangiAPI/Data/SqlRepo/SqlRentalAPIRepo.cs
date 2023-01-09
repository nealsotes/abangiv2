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

        public void DeleteRental(Rental rental)
        {
             _context.Rentals.Remove(rental);
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

        public async Task<Rental> GetIdPatch(int id)
        {
            return await _context.Rentals.FirstOrDefaultAsync(r => r.RentalId == id);
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

        public async Task<IEnumerable<RentalInformation>> GetRentalByOwnerId(int id)
        {
           var rentalList =  await (from r in _context.Rentals
                          join i in _context.Items on r.ItemId equals i.ItemId
                          join u in _context.Users on r.UserId equals u.UserId
                          join c in _context.UserRoles on u.UserId equals c.UserId
                          where i.UserId == id
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
                              ItemPrice = i.ItemPrice,
                              StartDate = r.StartDate,
                              EndDate = r.EndDate
                          }).ToListAsync();
            return rentalList;
        }

        public async Task<IEnumerable<RentalInformation>> GetRentalByUserId(int id)
        {
            var rentalList = (from r in _context.Rentals
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
                                  ItemOwner = i.User.FullName,
                                  ItemId = i.ItemId,
                                  Status = i.User.Status,
                                  ItemLocation = i.ItemLocation,
                                  ItemPrice = i.ItemPrice,
                                  AbangiVerified = c.AbangiVerified,
                                  RentalRemarks = r.RentalRemarks,
                                  RentalStatus = r.RentalStatus,
                                  StartDate = r.StartDate,
                                  EndDate = r.EndDate
                              }).ToListAsync();
            return await rentalList;
        }

        public bool SaveChanges()
        {
             return (_context.SaveChanges() >= 0);
        }

        public void UpdateViaPatch(Rental rental)
        {
            
        }
    }
}