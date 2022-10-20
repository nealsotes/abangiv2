using System.IO;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using System;
using System.Collections.Generic;
using System.Linq;
using AbangiAPI.Entities;
using AbangiAPI.Helpers;
using AbangiAPI.Dtos;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.JsonPatch;
using Microsoft.AspNetCore.Mvc;

namespace AbangiAPI.Services
{
    public interface IUserAPIRepo 
    {
        Task<User> Authenticate(String email, string password);
       Task<IEnumerable<UserModel>> GetAll();
        Task<UserModel> GetById(int id);
        Task<User> GetByIdPatch(int id);
        Task<User> Create(User user, string password);
        void Update(User user, string password = null);
        void UpdateViaPatch(User user);
        void DeleteUser(User user);
        void SaveChanges();
        void SavePostUserImageAsync(RegisterModel userModel);

        void SavePostUserGovermentIdAsync(RegisterModel userModel);
        
    }   


    public class SqlUserAPIRepo : IUserAPIRepo
    {

        private readonly DataContext _context;
        private readonly IWebHostEnvironment _environment;
        public SqlUserAPIRepo(DataContext context, IWebHostEnvironment environment)
        {
            _context = context;
            _environment = environment;
        }

        public async Task<User> Authenticate(string email, string password)
        {
            if(string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                return null;
            }
            
           
        
            var user = await _context.Users.SingleOrDefaultAsync(x => x.Email == email);
            // check  if email is exists
            if(user == null)
            {
                return null;
            }
            //checked if password is correct
            if(!VerifyPasswordHash(password, user.PasswordHash, user.PasswordSalt))
            {
                return null;
            }
            return user;
           
        }
       
       


        public async Task<User> Create(User user, string password)
        {
            // validation
            if(string.IsNullOrWhiteSpace(password))
            {
                throw new AppException("Password is required");
            }
            if(_context.Users.Any(x => x.Email == user.Email))
            {
                throw new AppException($"Email {user.Email} is already taken");
            }
            byte[] passwordHash, passwordSalt;
            CreatePasswordHash(password, out passwordHash, out passwordSalt);
            
            user.PasswordHash = passwordHash;
            user.PasswordSalt = passwordSalt;
           await _context.Users.AddAsync(user);
            _context.SaveChanges();

            return user;
        }

        public void DeleteUser(User user)
        {
            if(user == null)
            {
                throw new AppException("User not found");
            }
            _context.Users.Remove(user);
        }

        public async Task<IEnumerable<UserModel>> GetAll()
        {
            var users = await(from u in _context.Users
                        join i in _context.UserRoles on u.UserId equals i.UserId
                        join r in _context.Roles on i.RoleId equals r.RoleId
                        select new UserModel
                        {
                            UserId = u.UserId,
                            FullName = u.FullName,
                            Email = u.Email,
                            Contact = u.Contact,
                            Address = u.Address,
                            Role = r.RoleName,
                            IsAbangiVerified = i.AbangiVerified == true ? "Abangi Verified" : "Not Abangi Verified",
                            
                        }
            
                        ).ToListAsync();
            return users;
                    
        }

     

        public void Update(User userParam, string password = null)
        {
            var user = _context.Users.Find(userParam.UserId);
            if(user == null)
            {
                throw new AppException("User not found");
            }
            //update email if it has changed
            if(!string.IsNullOrWhiteSpace(userParam.Email) && userParam.Email != user.Email)
            {
                //throw error if the new email is already taken
                if(_context.Users.Any(x => x.Email == userParam.Email))
                {
                    throw new AppException($"Email '{userParam.Email}' is already taken.");
                }
                user.Email = userParam.Email;
            }
            // update user properties if provided
            if(!string.IsNullOrWhiteSpace(userParam.FullName))
            {
                user.FullName = userParam.FullName;
            }
            if(!string.IsNullOrWhiteSpace(userParam.Contact))
            {
                user.Contact = userParam.Contact;
            }
            if(!string.IsNullOrWhiteSpace(userParam.Address))
            {
                user.Address = userParam.Address;
            }
            // update password if provided
            if(!string.IsNullOrWhiteSpace(password))
            {
                byte[] passwordHash,paasswordSalt;
                CreatePasswordHash(password, out passwordHash, out paasswordSalt);
                user.PasswordHash = passwordHash;
                user.PasswordSalt = paasswordSalt;
            }
            _context.Users.Update(user);
            _context.SaveChanges();

        }
        //private helper methods
        private static void CreatePasswordHash(string password, out byte[] passwordHash, out byte[] passwordSalt)
        {
            ThrowException(password);
            using(var hmac = new System.Security.Cryptography.HMACSHA512())
            {
                passwordSalt = hmac.Key;
                passwordHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
            }
        }
        private static void ThrowException(string password)
        {
              if(password == null) throw new ArgumentNullException("password");
              if (string.IsNullOrWhiteSpace(password)) throw new ArgumentException("Value cannot be empty or whitespace only string.", "password");

        }
        private static bool VerifyPasswordHash(string password, byte[] storedHash, byte[] storedSalt)
        {
            ThrowException(password);
            if (storedHash.Length != 64) throw new ArgumentException("Invalid length of password hash (64 bytes expected).", "passwordHash");
            if (storedSalt.Length != 128) throw new ArgumentException("Invalid length of password salt (128 bytes expected).", "passwordHash");

            using (var hmac = new System.Security.Cryptography.HMACSHA512(storedSalt))
            {
                var ComputeHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                for(int i = 0; i < ComputeHash.Length; i++)
                {
                    if(ComputeHash[i] != storedHash[i]) return false;
                }
            }
            return true;
        }

        public void SaveChanges()
        {
            _context.SaveChanges();
        }

        public async Task<UserModel> GetById(int id)
        {
           var user = await (from u in _context.Users
                        join i in _context.UserRoles on u.UserId equals i.UserId
                        join r in _context.Roles on i.RoleId equals r.RoleId
                        where u.UserId == id
                        select new UserModel
                        {
                            UserId = u.UserId,
                            FullName = u.FullName,
                            Email = u.Email,
                            Contact = u.Contact,
                            Address = u.Address,
                            Role = r.RoleName,
                            UserImage = u.UserImage,
                            Status = u.Status,
                            IsAbangiVerified = i.AbangiVerified == true ? "Abangi Verified" : "Not Abangi Verified",

                        }).FirstOrDefaultAsync(i => i.UserId == id);
            return user;
        }

        public void SavePostUserImageAsync(RegisterModel userModel)
        {
            var user = new UserModel();
            var uniqueFileName = FileHelper.GetUniqueFileName(userModel.UserImageFile.FileName);
            var uploads = Path.Combine(_environment.WebRootPath, "Images","UserImages", user.UserId.ToString());
            var filePath = Path.Combine(uploads, uniqueFileName);
            Directory.CreateDirectory(Path.GetDirectoryName(filePath));
            userModel.UserImageFile.CopyTo(new FileStream(filePath, FileMode.Create));
            userModel.UserImage = filePath;
            return;
        }

        public void UpdateViaPatch(User user)
        {
            
        }

        public async Task<User> GetByIdPatch(int id)
        {
           return await _context.Users.FirstOrDefaultAsync(i => i.UserId == id);
        }

        public void SavePostUserGovermentIdAsync(RegisterModel userModel)
        {
            var user = new UserModel();
            var uniqueFileName = FileHelper.GetUniqueFileName(userModel.UserGovernmentIdFile.FileName);
            var uploads = Path.Combine(_environment.WebRootPath, "Images", "UserGovernmentID", user.UserId.ToString());
            var filePath = Path.Combine(uploads, uniqueFileName);
            Directory.CreateDirectory(Path.GetDirectoryName(filePath));
            userModel.UserGovernmentIdFile.CopyTo(new FileStream(filePath, FileMode.Create));
            userModel.UserGovertId = filePath;
            return;
        }
    }

    
   
}