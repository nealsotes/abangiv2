using System.Threading;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Data.StripeServices;
using AbangiAPI.Models.Stripe;
using Microsoft.AspNetCore.Mvc;

namespace AbangiAPI.Controllers.StripeController
{
    [ApiController]
    [Route("api/[controller]")]
    public class StripeController : ControllerBase
    {
        private readonly IStripeService _stripeService;
        public StripeController(IStripeService stripeService)
        {
            _stripeService = stripeService;
        }
       [HttpPost("customer")]
       public async Task<ActionResult<CustomerResource>> CreateCustomer([FromBody] CreateCustomerResource resource, CancellationToken cancellationToken)
        {
              var response = await _stripeService.CreateCustomer(resource, cancellationToken);
              return Ok(response);
        }
       [HttpPost("charge")]
         public async Task<ActionResult<ChargeResource>> CreateCharge([FromBody] CreateChargeResource resource, CancellationToken cancellationToken)
        {
            var response = await _stripeService.CreateCharge(resource, cancellationToken);
            return Ok(response);
        }
        [HttpPost("collectingfees")]
        public async Task<ActionResult<CollectingFeesResource>> CollectingFees([FromBody] CollectingFeesResources resource, CancellationToken cancellationToken)
        {
            var response = await _stripeService.CollectingFees(resource, cancellationToken);
            return Ok(response);
        }
    }
}