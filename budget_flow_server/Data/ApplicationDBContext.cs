using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace budget_flow_server.Data
{
    public class ApplicationDBContext : DbContext
    {
         public ApplicationDBContext(DbContextOptions options) : base(options)
        {
        }

        public DbSet<Models.User> User { get; set; }

    }
}