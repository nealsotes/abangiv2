using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models;

namespace AbangiAPI.Data
{
    public interface IItemCategoryAPIRepo
    {
        bool SaveChanges();
        Task<IEnumerable<ItemCategory>> GetAllItemCategories();
        Task<ItemCategory> GetItemCategoryById(int id);
        void CreateItemCategory(ItemCategory itemCategory);
        void UpdateItemCategory(ItemCategory itemCategory);
        void DeleteItemCategory(ItemCategory itemCategory);
       Task<IEnumerable<ItemInformation>> GetItemByCategory(string name, int id);
    }
}