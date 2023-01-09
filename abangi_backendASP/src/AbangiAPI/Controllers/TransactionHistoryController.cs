using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Data;
using AbangiAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace AbangiAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TransactionHistoryController : ControllerBase
    {
        private readonly ITransactionHistories _repository;

        public TransactionHistoryController(ITransactionHistories repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TransactionHistory>>> GetAllTransactionHistories()
        {
            var transactionHistories = await _repository.GetAllTransactionHistories();
            return Ok(transactionHistories);
        }
        [HttpGet("{id}")]
        public ActionResult<TransactionHistory> GetTransactionHistory(int id)
        {
            var transactionHistory = _repository.GetTransactionHistory(id);
            return Ok(transactionHistory);
        }
        [HttpGet("{userid}", Name = "GetTransactionHistoryByRenter"), Route("GetTransactionHistoryByRenter/{userid}")]
        public ActionResult<TransactionHistory> GetTransactionHistoryByRenter(int userid)
        {
            var transactionHistory = _repository.GetAllTransactionHistoriesByRenter(userid);
            return Ok(transactionHistory);
        }
        [HttpGet("{userid}", Name = "GetTransactionHistoryByOwner"), Route("GetTransactionHistoryByOwner/{userid}")]
        public ActionResult<TransactionHistory> GetTransactionHistoryByOwner(int userid)
        {
            var transactionHistory = _repository.GetAllTransactionHistoriesByOwner(userid);
            return Ok(transactionHistory);
        }
        [HttpPost]
        public ActionResult<TransactionHistory> AddTransactionHistory(TransactionHistory transactionHistory)
        {
            _repository.AddTransactionHistory(transactionHistory);
            _repository.SaveChanges();
            return Ok(transactionHistory);
        }
        [HttpPut]
        public ActionResult<TransactionHistory> UpdateTransactionHistory(TransactionHistory transactionHistory)
        {
            _repository.UpdateTransactionHistory(transactionHistory);
            _repository.SaveChanges();
            return Ok(transactionHistory);
        }
        [HttpDelete("{id}")]
        public ActionResult<TransactionHistory> DeleteTransactionHistory(int id)
        {
            var transactionHistory = _repository.GetTransactionHistory(id);
            _repository.DeleteTransactionHistory(id);
            _repository.SaveChanges();
            return Ok(transactionHistory);
        }
        
    }
}