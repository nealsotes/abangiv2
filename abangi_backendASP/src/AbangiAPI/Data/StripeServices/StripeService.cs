using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using AbangiAPI.Models.Stripe;
using Stripe;

namespace AbangiAPI.Data.StripeServices
{
    public class StripeService : IStripeService
    {
        private readonly TokenService _tokenService;
        private readonly CustomerService _customerService;
        private readonly ChargeService _chargeService;

        public StripeService( TokenService tokenService, CustomerService customerService, ChargeService chargeService)
        {
            _tokenService = tokenService;
            _customerService = customerService;
            _chargeService = chargeService;
        }

        public Task<CollectingFeesResource> CollectingFees(CollectingFeesResources resource, CancellationToken cancellationToken)
        {
           // throw new NotImplementedException();
           var service = new PaymentIntentService();
           var createOptions = new PaymentIntentCreateOptions
           {
               Amount = resource.Amount,
               Currency = resource.Currency,
               TransferData = new PaymentIntentTransferDataOptions
               {
                   Destination = resource.TransferData,
               },
           };
              var paymentIntent = service.Create(createOptions);
                var collectingFeesResource = new CollectingFeesResource
                {
                    Amount = paymentIntent.Amount,
                    Currency = paymentIntent.Currency,
                    TransactionFee = resource.Amount - 200
                };
                return Task.FromResult(collectingFeesResource);

        }

        public async Task<ChargeResource> CreateCharge(CreateChargeResource resource, CancellationToken cancellationToken)
        {
            var chargeOptions = new ChargeCreateOptions
            {
                Amount = resource.Amount,
                Currency = resource.Currency,
                Customer = resource.CustomerId,
                ReceiptEmail = resource.ReceiptEmail,
                Description = resource.Description
            };

            var charge = await _chargeService.CreateAsync(chargeOptions, null, cancellationToken);
           
            return new ChargeResource
            {
                ChargeId = charge.Id,
                Amount = charge.Amount,
                Currency = charge.Currency,
                CustomerId = charge.CustomerId,
                ReceiptEmail = charge.ReceiptEmail,
                Description = charge.Description
            };
        }

        public async Task<CustomerResource> CreateCustomer(CreateCustomerResource resource, CancellationToken cancellationToken)
        {
            var tokenOptions = new TokenCreateOptions
            {
               Card = new TokenCardOptions
               {
                   Name = resource.Name,
                   Number = resource.Card.Number,
                   ExpMonth = resource.Card.ExpMonth,
                   ExpYear = resource.Card.ExpYear,
                   Cvc = resource.Card.Cvc
               }
            };
            var token = await _tokenService.CreateAsync(tokenOptions, null, cancellationToken);
            var customerOptions = new CustomerCreateOptions
            {
                Email = resource.Email,
                Name = resource.Name,
                Source =token.Id
            };
            var customer = await _customerService.CreateAsync(customerOptions, null, cancellationToken);
            return new CustomerResource
            {
                CustomerId = customer.Id,
                Email = customer.Email,
                Name = customer.Name
            };
        }
    }
}