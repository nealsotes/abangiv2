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
        IEnumerable<ItemCategory> GetAllItemCategories();
        ItemCategory GetItemCategoryById(int id);
        void CreateItemCategory(ItemCategory itemCategory);
        void UpdateItemCategory(ItemCategory itemCategory);
        void DeleteItemCategory(ItemCategory itemCategory);
    }
}