using System.Runtime.InteropServices;
using System;
using System.Collections.Generic;
using System.Linq;
using AbangiAPI.Entities;
using AbangiAPI.Helpers;

namespace AbangiAPI.Services
{
    public interface IUserAPIRepo 
    {
        User Authenticate(String email, string password);
        IEnumerable<User> GetAll();
        User GetById(int id);
        User Create(User user, string password);
        void Update(User user, string password = null);
        void Delete(int id);
    
    }


    public class SqlUserAPIRepo : IUserAPIRepo
    {

        private readonly DataContext _context;
        public SqlUserAPIRepo(DataContext context)
        {
            _context = context;
        }

        public User Authenticate(string email, string password)
        {
            if(string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                return null;
            }
            
           
        
            var user = _context.Users.SingleOrDefault(x => x.Email == email);
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
       
       


        public User Create(User user, string password)
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
            _context.Users.Add(user);
            _context.SaveChanges();

            return user;
        }

        public void Delete(int id)
        {
            var user = _context.Users.Find(id);
            if(user != null)
            {
                _context.Users.Remove(user);
                _context.SaveChanges();
            }
        }

        public IEnumerable<User> GetAll()
        {
            return _context.Users;
        }

        public User GetById(int id)
        {
            return _context.Users.FirstOrDefault(p => p.UserId == id);
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
            if(!string.IsNullOrWhiteSpace(userParam.Name))
            {
                user.Name = userParam.Name;
            }
            if(!string.IsNullOrWhiteSpace(userParam.Phone))
            {
                user.Phone = userParam.Phone;
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
    }

    
   
}