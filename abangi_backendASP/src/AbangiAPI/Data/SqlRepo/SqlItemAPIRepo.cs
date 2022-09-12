using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
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
            throw new NotImplementedException();
        }

        public void DeleteItem(Item item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Item> GetAllItems()
        {
            return _context.Items.ToList();
            
        }

        public Item GetItemById(int id)
        {
            return _context.Items.FirstOrDefault(p => p.ItemId == id);
        }

        public bool SaveChanges()
        {
            throw new NotImplementedException();
        }

        public void UpdateItem(Item item)
        {
            throw new NotImplementedException();
        }
    }
}