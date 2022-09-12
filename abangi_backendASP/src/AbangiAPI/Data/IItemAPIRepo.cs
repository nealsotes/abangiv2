using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models;

namespace AbangiAPI.Data
{
    public interface IItemAPIRepo
    {
        bool SaveChanges();
        IEnumerable<Item> GetAllItems();
        Item GetItemById(int id);
        void CreateItem(Item item);
        void UpdateItem(Item item);
        void DeleteItem(Item item);
    }
}