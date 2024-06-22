using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace budget_flow_server.Models
{
    public class User
    {
        [Key]
        public int UserId { get; set; } 
        public String Email { get; set; } = String.Empty;
         public String Username { get; set; } = String.Empty;

        public String Password { get; set; } = String.Empty;

        public decimal IncomeLbn { get; set; }

        public decimal IncomeUsd { get; set; }


    }
}