using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Helpers;
using AbangiAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace AbangiAPI.Data.SqlRepo
{
    public class SqlFeedbackAPIRepo : IFeedbackAPIRepos
    {
        private readonly DataContext _context;
        public SqlFeedbackAPIRepo(DataContext context)
        {
            _context = context;
        }

        public void DeleteFeedback(Feedback feedback)
        {
             _context.Feedbacks.Remove(feedback);
        }

        public async Task<IEnumerable<Feedback>> GetAllFeedbacks()
        {
            if(_context == null)
            {
                throw new ArgumentNullException(nameof(_context));
            }
            return await _context.Feedbacks.ToListAsync();

        }

        public Task<FeedbackInformation> GetFeedbackById(int id)
        {
            var feedback = from f in _context.Feedbacks
                            join u in _context.Users on f.UserId equals u.UserId
                            join i in _context.Items on f.ItemId equals i.ItemId
                            
                            where f.FeedbackId == id
                            select new FeedbackInformation
                            {
                                FeedbackId = f.FeedbackId,
                                FullName = u.FullName,
                                ItemId = f.ItemId,
                                Ratings = f.Ratings,
                                Comments = f.Comments,
                                Date_Rated = f.Date_Rated
                            };
            return feedback.FirstOrDefaultAsync();
        }

        public bool SaveChanges()
        {
            return (_context.SaveChanges() >= 0);
        }

        public async void CreateFeedback (Feedback feedback)
        {   
            if(feedback == null)
            {
                throw new ArgumentNullException(nameof(feedback));
            }
            await _context.Feedbacks.AddAsync(feedback);
        }

        public void UpdateFeedback(Feedback feedback)
        {
            
        }

        public async Task<IEnumerable<FeedbackInformation>> GetFeedbackByItemId(int id)
        {
            var feedback = from f in _context.Feedbacks
                            join u in _context.Users on f.UserId equals u.UserId
                            join i in _context.Items on f.ItemId equals i.ItemId
                            
                            where f.ItemId == id
                            select new FeedbackInformation
                            {
                                FeedbackId = f.FeedbackId,
                                FullName = u.FullName,
                                ItemId = f.ItemId,
                                UserImage = u.UserImage,
                                Ratings = f.Ratings,
                                Comments = f.Comments,
                                Date_Rated = f.Date_Rated
                            };
            return await feedback.ToListAsync();
        }
    }
}