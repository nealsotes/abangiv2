using System.Threading;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models.Stripe;

namespace AbangiAPI.Data.StripeServices
{
    public interface IStripeService
    {
        Task<CustomerResource> CreateCustomer(CreateCustomerResource resource, CancellationToken cancellationToken);
        Task<ChargeResource> CreateCharge(CreateChargeResource resource, CancellationToken cancellationToken);

        Task<CollectingFeesResource> CollectingFees(CollectingFeesResources resource, CancellationToken cancellationToken);
    }
}