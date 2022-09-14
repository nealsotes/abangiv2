using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Dtos;
using AbangiAPI.Helpers;
using AbangiAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace AbangiAPI.Data.SqlRepo
{
    public class SqlItemAPIRepo : IItemAPIRepo
    {
        private readonly DataContext _context; 
        public SqlItemAPIRepo(DataContext context)
        {
            _context = context;
        }
        public void CreateItem(Item item)
        {
            if(item == null)
            {
                throw new ArgumentNullException(nameof(item));
            }
            _context.Items.Add(item);
        }

        public void DeleteItem(Item item)
        {
            if(item == null)
            {
                throw new ArgumentNullException(nameof(item));
            }
            _context.Items.Remove(item);
        }

        public async Task<IEnumerable<ItemInformation>> GetAllItems()
        {
           var itemList = (from i in _context.Items
                           join ic in _context.ItemCategories on i.ItemCategoryId equals ic.ItemCategoryId
                           join u in _context.Users on i.UserId equals u.UserId
                           select new ItemInformation
                           {
                                 ItemId = i.ItemId,
                                 ItemName = i.ItemName,
                                 Description = i.ItemDescription,
                                 Price = i.ItemPrice,
                                 Category = ic.ItemCategoryName,
                                 Owner = u.FullName,
                           }).ToListAsync();
            return await itemList;
        }

        public ItemInformation GetItemById(int id)
        {
             var itemList = (from i in _context.Items
                           join ic in _context.ItemCategories on i.ItemCategoryId equals ic.ItemCategoryId
                           join u in _context.Users on i.UserId equals u.UserId
                           select new ItemInformation
                           {
                                 ItemId = i.ItemId,
                                 ItemName = i.ItemName,
                                 Description = i.ItemDescription,
                                 Price = i.ItemPrice,
                                 Category = ic.ItemCategoryName,
                                 Owner = u.FullName,
                           }).FirstOrDefaultAsync(i => i.ItemId == id);
            return itemList.Result;
        }

        public bool SaveChanges()
        {
           return (_context.SaveChanges() >= 0);
        }

        public void UpdateItem(Item item)
        {
            throw new NotImplementedException();
        }
        public Item GetItemById2(int id)
        {
            return _context.Items.FirstOrDefault(p => p.ItemId == id);
        }
    }
}