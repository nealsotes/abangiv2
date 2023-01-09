using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Dtos;
using AbangiAPI.Models;

namespace AbangiAPI.Data
{
    public interface IItemAPIRepo
    {
        bool SaveChanges();
        Task<IEnumerable<ItemInformation>> GetAllItems();
        Task<IEnumerable<ItemInformation>> GetAllItemsByUser(int id);
        Task<ItemInformation> GetItemById(int id);
        Item GetItemById2(int id);
        void CreateItem(Item item);
        void UpdateItem(Item item);
        void DeleteItem(Item item);
        void SavePostImageAsync(ItemCreateDto itemCreateDto);
        Task<IEnumerable<ItemInformation>> GetUserItemListings(int id);
        Task<Item> GetItemName(string name);
    }
    
}
