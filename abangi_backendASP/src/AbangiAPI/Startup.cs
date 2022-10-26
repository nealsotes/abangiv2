using System.Threading.Tasks;
using System.Text;
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Builder;
using Newtonsoft.Json.Serialization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.AspNetCore.SpaServices.Webpack;
using AutoMapper;
using AbangiAPI.Helpers;
using AbangiAPI.Services;
using AbangiAPI.Data;
using AbangiAPI.Data.SqlRepo;
using Microsoft.AspNetCore.Http;


using Microsoft.Extensions.DependencyInjection.Extensions;
using AbangiAPI.Hubs;

namespace AbangiAPI
{
    public class Startup
    {
        private readonly IWebHostEnvironment _env;
        protected IConfiguration _configuration{get;}
        public Startup(IConfiguration configuration, IWebHostEnvironment env)
        {
            _env = env;
            _configuration = configuration;
        }

        // This method gets called by the runtime. Use this method to add services to the container.
        // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940
        
        public void ConfigureServices(IServiceCollection services)
        {
          
            services.AddCors();
            services.AddRazorPages();
           
         
            services.AddDbContext<DataContext>();
            services.AddControllers().AddNewtonsoftJson(s => {
                s.SerializerSettings.ContractResolver = new CamelCasePropertyNamesContractResolver();
                s.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore;
            });
            services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());
            //configure DI for application repo
            services.AddScoped<IUserAPIRepo, SqlUserAPIRepo>();
            services.AddScoped<IItemAPIRepo, SqlItemAPIRepo>();
            services.AddScoped<IRentalMethodAPIRepo, SqlRentaMethodAPIREpo>();
            services.AddScoped<IItemCategoryAPIRepo, SqlItemCategoriesAPIRepo>();
            services.AddScoped<IRoleAPIRepo, SqlRoleAPIRepo>();
            services.AddScoped<IUserRoleAPIRepo, SqlUserRoleAPIRepo>();
            services.AddScoped<IRentalAPIRepo, SqlRentalAPIRepo>();
            services.TryAddSingleton<IHttpContextAccessor, HttpContextAccessor>();
         
            services.AddControllersWithViews();
            services.AddCoreAdmin();
            services.AddSignalR(options => {
                options.EnableDetailedErrors = true;
            });
            //configure strongly typed settings objects
            var appSettingsSection = _configuration.GetSection("AppSettings");
            services.Configure<AppSettings>(appSettingsSection);
        
       
        

           //configure jwt authentication
           var appSettings = appSettingsSection.Get<AppSettings>();
           var key = Encoding.ASCII.GetBytes(appSettings.Secret);
           services.AddAuthentication(x => 
           {
                x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;

           })
           .AddJwtBearer(x =>
           {
                x.Events = new JwtBearerEvents
                {
                    OnTokenValidated = context => 
                    {
                        var userService = context.HttpContext.RequestServices.GetRequiredService<IUserAPIRepo>();
                        var userId = int.Parse(context.Principal.Identity.Name);
                        var user = userService.GetById(userId);
                        if(user == null)
                        {
                            //return unauthorized if user no longer exists
                            context.Fail("Unauthorized");
                        }
                        return Task.CompletedTask;
                    }
                };
                x.RequireHttpsMetadata = false;
                x.SaveToken = true;
                x.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuer = false,
                    ValidateAudience =false
                };
           });
            
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        [Obsolete]
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, DataContext dataContext)
        {
            //migrate any database changes on startup(includes initial db creation)
            dataContext.Database.Migrate();

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
               
            }

         

            app.UseRouting();
            //global cors policy 
            app.UseCors(x => x
                .AllowAnyOrigin()
                .AllowAnyMethod()
                .AllowAnyHeader()

            );
            app.UseAuthentication();
            app.UseAuthorization();
            app.UseStaticFiles();
           
            app.UseEndpoints(endpoints =>
            {
               endpoints.MapControllers();
              
            });
            app.UseSignalR(routes =>
            {
               routes.MapHub<ChatHub>("/chatHub");
            });
             
        }
    }
}
