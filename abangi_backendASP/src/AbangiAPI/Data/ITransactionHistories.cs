using System.Collections;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models;

namespace AbangiAPI.Data
{
    public interface ITransactionHistories
    {
        void AddTransactionHistory(TransactionHistory transactionHistory);
        public Task<IEnumerable<TransactionHistory>> GetTransactionHistory(int id);
        public Task<IEnumerable<TransactionHistory>> GetAllTransactionHistories();
        public Task<TransactionHistory> UpdateTransactionHistory(TransactionHistory transactionHistory);
        public Task<TransactionHistory> DeleteTransactionHistory(int id);
        public Task<IEnumerable<TransactionHistory>> GetAllTransactionHistoriesByUser(int id);
        public Task<IEnumerable<TransactionHistory>> GetAllTransactionHistoriesByOwner(int id);
        public Task<IEnumerable<TransactionHistory>> GetAllTransactionHistoriesByRenter(int id);
        public void SaveChanges();
    }
}