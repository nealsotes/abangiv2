using System.Collections;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Helpers;
using AbangiAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace AbangiAPI.Data.SqlRepo
{
    public class SqlTransactionHistoryAPIRepo : ITransactionHistories
    {
        private readonly DataContext _context;
        public SqlTransactionHistoryAPIRepo(DataContext context)
        {
            _context = context;
        }
    
            
        
        public void AddTransactionHistory(TransactionHistory transactionHistory)
        {
            if (transactionHistory == null)
            {
                throw new ArgumentNullException(nameof(transactionHistory));
            }
            _context.TransactionHistories.Add(transactionHistory);
        }
        public async Task<TransactionHistory> DeleteTransactionHistory(int id)
        {
            if (id == 0)
            {
                throw new ArgumentNullException(nameof(id));
            }
            var transactionHistory = _context.TransactionHistories.FirstOrDefault(p => p.Id == id);
            if (transactionHistory == null)
            {
                throw new ArgumentNullException(nameof(transactionHistory));
            }
            _context.TransactionHistories.Remove(transactionHistory);
            _context.SaveChanges();
            return await Task.FromResult(transactionHistory);

        }

       
       
        public  Task<TransactionHistory> UpdateTransactionHistory(TransactionHistory transactionHistory)
        {
            throw new NotImplementedException();
        }   

        public void SaveChanges()
        {
            _context.SaveChanges();
            
        }

      
        public async Task<IEnumerable<TransactionHistory>> GetAllTransactionHistories()
        {
            return await _context.TransactionHistories.ToListAsync();
        }

        public Task<IEnumerable<TransactionHistory>> GetTransactionHistory(int id)
        {
           return Task.FromResult(_context.TransactionHistories.Where(p => p.Id == id) as IEnumerable<TransactionHistory>);
        }

        public  Task<IEnumerable<TransactionHistory>> GetAllTransactionHistoriesByUser(int userId )
        {
            throw new NotImplementedException();
        }
        
    }
}