using System.Net.Mime;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Helpers;
using AbangiAPI.Models;
using Microsoft.EntityFrameworkCore;
using System.IO;
using Microsoft.AspNetCore.Hosting;

namespace AbangiAPI.Data.SqlRepo
{
    public class SqlItemCategoriesAPIRepo : IItemCategoryAPIRepo
    {
        private readonly DataContext _context;
         private readonly IWebHostEnvironment webHostEnvironment; 
        public SqlItemCategoriesAPIRepo(DataContext context, IWebHostEnvironment hostEnvironment)
        {
            _context = context;
            webHostEnvironment = hostEnvironment;
        }
       
        public void CreateItemCategory(ItemCategory itemCategory)
        {
            if(itemCategory == null)
            {
                throw new ArgumentNullException(nameof(itemCategory));
            }
            _context.ItemCategories.Add(itemCategory);
        }

        public void DeleteItemCategory(ItemCategory itemCategory)
        {
            throw new NotImplementedException();
        }

        public async Task<IEnumerable<ItemCategory>> GetAllItemCategories()
        {
            return await _context.ItemCategories.Include(i => i.Items).ToListAsync();
        }

         public async Task<IEnumerable<ItemInformation>> GetItemByCategory(string name, int id)
        {
            var itemRented = _context.Rentals.Select(r => r.ItemId);
            var itemResult = _context.Items.Where(i => !itemRented.Contains(i.ItemId));
            
            var Item = (from i in itemResult
                        join ic in _context.ItemCategories on i.ItemCategoryId equals ic.ItemCategoryId
                        join u in _context.Users on i.UserId equals u.UserId
                        join r in _context.RentalMethods on i.RentalMethodId equals r.RentalMethodId 
                        join c in _context.UserRoles on u.UserId equals c.UserId 
                        
                        where ic.ItemCategoryName.ToLower() == name && c.UserId != id 
                        select new ItemInformation
                        {
                            ItemId = i.ItemId,
                            ItemName = i.ItemName,
                            Description = i.ItemDescription,
                            Price = i.ItemPrice,
                            Category = ic.ItemCategoryName,
                            Owner = u.FullName,
                           
                            RentalMethod = r.RentalMethodName,
                            Location = i.ItemLocation,
                            Image = i.ItemImage,
                            AbangiVerified = c.AbangiVerified,
                            DateCreated = i.DateCreated,
                            StartDate = i.StartDate,
                           
                            EndDate = i.EndDate,
                            Status = u.Status
                        }).ToListAsync();
            return await Item;
        }

       
       
        public async Task<ItemCategory> GetItemCategoryById(int id)
        {
            return await _context.ItemCategories.FirstOrDefaultAsync(p => p.ItemCategoryId == id);
        }
    
        public bool SaveChanges()
        {
            throw new NotImplementedException();
        }

        public void UpdateItemCategory(ItemCategory itemCategory)
        {
            throw new NotImplementedException();
        }
    }
}