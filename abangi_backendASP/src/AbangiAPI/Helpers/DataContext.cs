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

        public DbSet<User> Users {get; set;}
        public DbSet<Item> Items {get; set;}
        public DbSet<ItemCategory> ItemCategories {get; set;}

        public DbSet<RentalMethod> RentalMethods {get; set;}
     
    }
}