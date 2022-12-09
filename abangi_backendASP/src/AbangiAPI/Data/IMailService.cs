using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models;

namespace AbangiAPI.Data
{
    public interface IMailService
    {
        Task SendEmailAsync(MailRequest mailRequest);
    }
}