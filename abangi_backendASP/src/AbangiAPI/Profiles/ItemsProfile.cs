using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AbangiAPI.Dtos;
using AbangiAPI.Models;
using AutoMapper;

namespace AbangiAPI.Profiles
{
    public class ItemsProfile : Profile
    {
       public ItemsProfile()
       {
              CreateMap<Item, ItemReadDto>();
              CreateMap<Rental, RentalReadDto>();
              CreateMap<ItemCreateDto, Item>();
              CreateMap<RentalCreateDto,Rental>();
              CreateMap<ItemUpdateDto, Item>();
              CreateMap<Item, ItemUpdateDto>();
              CreateMap<RentalMethodUpdateDto, RentalMethod>();
             
       }
    }

}