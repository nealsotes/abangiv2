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