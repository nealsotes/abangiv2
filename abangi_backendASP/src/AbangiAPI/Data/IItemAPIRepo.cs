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
        Task<IEnumerable<ItemInformation>> GetAllItems();
        ItemInformation GetItemById(int id);
        Item GetItemById2(int id);
        void CreateItem(Item item);
        void UpdateItem(Item item);
        void DeleteItem(Item item);
       
    }
    
}
