using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Models;
using Xunit;

namespace AbangiAPI.Tests
{
    public class ItemTest
    {
        [Fact]
        public void Create()
        {
            var item = new Item
            {
                ItemName = "Kaha",
                ItemDescription = "Description",
                ItemPrice = 220,
                ItemLocation = "Babag",
            };
            item.ItemName = "Kaha";

            Assert.Equal("Kaha", item.ItemName);

        }
    }
}