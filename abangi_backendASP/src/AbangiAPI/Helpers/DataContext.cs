using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using AbangiAPI.Entities;
using Npgsql;
using System.Collections.Generic;
using AbangiAPI.Models;


namespace AbangiAPI.Helpers
{
    public class DataContext : DbContext
    {
         protected readonly IConfiguration Configuration;

      

        public DataContext(IConfiguration configuration) 
        {
            Configuration = configuration;
        }
        
      

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var builder = new NpgsqlConnectionStringBuilder();
            builder.ConnectionString = Configuration.GetConnectionString("PostgreSqlConnection");
            builder.Username = Configuration["UserID"];
            builder.Password = Configuration["Password"];
            
           optionsBuilder.UseNpgsql(builder.ConnectionString);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
           base.OnModelCreating(modelBuilder);
           
        }
        public DbSet<User> Users {get; set;}
        public DbSet<Item> Items {get; set;}
        public DbSet<ItemCategory> ItemCategories {get; set;}
        public DbSet<RentalMethod> RentalMethods {get; set;}
        public DbSet<UserRole> UserRoles {get; set;}
        public DbSet<Role> Roles {get; set;}
        public DbSet<Rental> Rentals {get; set;}
        public DbSet<Feedback> Feedbacks {get; set;}
        public DbSet<TransactionHistory> TransactionHistories {get; set;}
        public DbSet<Message> Messages {get; set;}
    }
}