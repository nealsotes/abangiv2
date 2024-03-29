using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Dtos;
using AbangiAPI.Helpers;
using AbangiAPI.Models;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;

namespace AbangiAPI.Data.SqlRepo
{
    public class SqlItemAPIRepo : IItemAPIRepo
    {
        private readonly DataContext _context; 
        private readonly IWebHostEnvironment environment;
        public SqlItemAPIRepo(DataContext context, IWebHostEnvironment hostEnvironment)
        {
            _context = context;
            environment = hostEnvironment;
        }
       
        public void  CreateItem(Item item)
        {
            if(item == null)
            {
                throw new ArgumentNullException(nameof(item));
            }
            if(_context.Items.Any(i => i.ItemName.ToLower() == item.ItemName.ToLower()))
            {
                throw new AppException("Item already exists");
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
                           join r in _context.RentalMethods on i.RentalMethodId equals r.RentalMethodId
                           join c in _context.UserRoles on u.UserId equals c.UserId

                           select new ItemInformation
                           {
                                ItemId = i.ItemId,
                                ItemName = i.ItemName,
                                Description = i.ItemDescription,
                                Price = i.ItemPrice,
                                Category = ic.ItemCategoryName,
                                Owner = u.FullName,
                                RentalMethod = r.RentalMethodName,
                                Location = i.ItemLocation,
                                Image = i.ItemImage,
                                DateCreated = i.DateCreated,
                                StartDate = i.StartDate,
                                EndDate = i.EndDate,
                                AbangiVerified = c.AbangiVerified
                               
                           }).ToListAsync();
            return await itemList;
        }

        public async Task<ItemInformation> GetItemById(int id)
        {
             var itemList = await (from i in _context.Items
                           join ic in _context.ItemCategories on i.ItemCategoryId equals ic.ItemCategoryId
                           join u in _context.Users on i.UserId equals u.UserId
                           join r in _context.RentalMethods on i.RentalMethodId equals r.RentalMethodId
                            where i.ItemId == id
                           select new ItemInformation
                           {
                                 ItemId = i.ItemId,
                                 ItemName = i.ItemName,
                                 Description = i.ItemDescription,
                                 Price = i.ItemPrice,
                                 Category = ic.ItemCategoryName,
                                 Owner = u.FullName,
                                RentalMethod = r.RentalMethodName,
                                Location = i.ItemLocation,
                                Image = i.ItemImage,
                                DateCreated = i.DateCreated,
                                StartDate = i.StartDate,
                                EndDate = i.EndDate          
                                
                           }).FirstOrDefaultAsync(i => i.ItemId == id);
            return  itemList;
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

        public void  SavePostImageAsync(ItemCreateDto itemCreateDto)
        { 
            //save image to wwwroot/image
            string wwwRootPath = environment.WebRootPath;
            string fileName = Path.GetFileNameWithoutExtension(itemCreateDto.Image.FileName);
            string extension = Path.GetExtension(itemCreateDto.Image.FileName);
            itemCreateDto.ItemImage = fileName = fileName + DateTime.Now.ToString("yymmssfff") + extension;
            string path = Path.Combine(wwwRootPath + "/image/", fileName);

            using (var fileStream = new FileStream(path
                , FileMode.Create))
            {
                itemCreateDto.Image.CopyTo(fileStream);
            }
            SaveChanges();
        }

        public async Task<IEnumerable<ItemInformation>> GetAllItemsByUser(int id)
        {
          var userItems = await (from i in _context.Items
                           join ic in _context.ItemCategories on i.ItemCategoryId equals ic.ItemCategoryId
                           join u in _context.Users on i.UserId equals u.UserId
                           join r in _context.RentalMethods on i.RentalMethodId equals r.RentalMethodId
                           join rt in _context.Rentals on i.ItemId equals rt.ItemId
                           
                            where i.UserId == id
                           select new ItemInformation
                           {
                                ItemId = i.ItemId,
                                ItemName = i.ItemName,
                                Description = i.ItemDescription,
                                Price = i.ItemPrice,
                                Category = ic.ItemCategoryName,
                                Owner = u.FullName,
                                RentalMethod = r.RentalMethodName,
                                RentalStatus = rt.RentalStatus,
                                RentalId = rt.RentalId,
                                RenterName = rt.User.FullName,
                                Location = i.ItemLocation,
                               
                                Image = i.ItemImage,
                                DateCreated = i.DateCreated,
                                StartDate = i.StartDate,
                                EndDate = i.EndDate
                                
                           }).ToListAsync();
            return userItems;
            
        
        }

        // public async Task<IEnumerable<ItemInformation>> GetUserItemListings(int id)
        // {
        //     var items = (from i in _context.Items
                      
        //                    join ic in _context.ItemCategories on i.ItemCategoryId equals ic.ItemCategoryId
        //                    join u in _context.Users on i.UserId equals u.UserId 
        //                    join rt in _context.Rentals on i.ItemId equals rt.ItemId      
        //                    where i.UserId == id
        //                    select new ItemInformation
        //                    {
        //                         ItemId = i.ItemId,
        //                         ItemName = i.ItemName,
        //                         Description = i.ItemDescription,
        //                         Price = i.ItemPrice,
        //                         Category = ic.ItemCategoryName,
        //                         RentalStatus = rt.RentalStatus,
        //                         Location = i.ItemLocation,
        //                         Image = i.ItemImage,
        //                         DateCreated = i.DateCreated,
        //                         StartDate = i.StartDate,
        //                         EndDate = i.EndDate
                                
        //                     }).ToListAsync();
        //     return await items;
        // }
        public async Task<IEnumerable<ItemInformation>> GetUserItemListings(int id, string rentalStatus = "")
{
    var items = await (from i in _context.Items
                       join ic in _context.ItemCategories on i.ItemCategoryId equals ic.ItemCategoryId
                       join u in _context.Users on i.UserId equals u.UserId 
                       join rt in _context.Rentals on i.ItemId equals rt.ItemId      
                       where i.UserId == id
                       select new ItemInformation
                       {
                            ItemId = i.ItemId,
                            ItemName = i.ItemName,
                            Description = i.ItemDescription,
                            Price = i.ItemPrice,
                            Category = ic.ItemCategoryName,
                            RentalStatus = rt.RentalStatus,
                            Location = i.ItemLocation,
                            Image = i.ItemImage,
                            DateCreated = i.DateCreated,
                            StartDate = i.StartDate,
                            EndDate = i.EndDate
                       }).ToListAsync();
    if (!string.IsNullOrEmpty(rentalStatus))
    {
        items = items.Where(i => i.RentalStatus == rentalStatus).ToList();
    }
    return items;
}


        public Task<Item> GetItemName(string name)
        {
            return _context.Items.FirstOrDefaultAsync(p => p.ItemName == name);
        }
    }
}