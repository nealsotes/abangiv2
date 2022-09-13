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
           return (_context.SaveChanges() >= 0);
        }

        public void UpdateItem(Item item)
        {
            throw new NotImplementedException();
        }
    }
}