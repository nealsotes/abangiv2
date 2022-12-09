using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models;

namespace AbangiAPI.Data
{
    public interface IFeedbackAPIRepos
    {
        bool SaveChanges();
        Task <IEnumerable<Feedback>> GetAllFeedbacks();
        Task <FeedbackInformation> GetFeedbackById(int id);
        void CreateFeedback (Feedback feedback);
        void UpdateFeedback(Feedback feedback);
        void DeleteFeedback(Feedback feedback);

        Task <IEnumerable<FeedbackInformation>> GetFeedbackByItemId(int id);

    }
}