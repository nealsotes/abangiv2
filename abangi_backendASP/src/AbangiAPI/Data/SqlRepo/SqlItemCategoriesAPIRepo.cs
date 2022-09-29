using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Helpers;
using AbangiAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace AbangiAPI.Data.SqlRepo
{
    public class SqlItemCategoriesAPIRepo : IItemCategoryAPIRepo
    {
        private readonly DataContext _context;
        public SqlItemCategoriesAPIRepo(DataContext context)
        {
            _context = context;    
        }
        public void CreateItemCategory(ItemCategory itemCategory)
        {
            throw new NotImplementedException();
        }

        public void DeleteItemCategory(ItemCategory itemCategory)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<ItemCategory> GetAllItemCategories()
        {
            return _context.ItemCategories.Include(i => i.Items).ToList();
        }

         public async Task<IEnumerable<ItemInformation>> GetItemByCategory(string name)
        {
            var Item = (from i in _context.Items
                        join ic in _context.ItemCategories on i.ItemCategoryId equals ic.ItemCategoryId
                        join u in _context.Users on i.UserId equals u.UserId
                        join r in _context.RentalMethods on i.RentalMethodId equals r.RentalMethodId
                        where ic.ItemCategoryName.ToLower() == name
                        select new ItemInformation
                        {
                            ItemId = i.ItemId,
                            ItemName = i.ItemName,
                            Description = i.ItemDescription,
                            Price = i.ItemPrice,
                            Category = ic.ItemCategoryName,
                            Owner = u.FullName,
                            RentalMethod = r.RentalMethodName,
                            Location = i.ItemLocation
                        }).ToListAsync();
            return await Item;
        }

        public ItemCategory GetItemCategoryById(int id)
        {
            return _context.ItemCategories.FirstOrDefault(p => p.ItemCategoryId == id);
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