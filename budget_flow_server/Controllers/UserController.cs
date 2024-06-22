using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using budget_flow_server.Data;
using budget_flow_server.Models;
using Microsoft.AspNetCore.Mvc;

namespace budget_flow_server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
         private readonly ApplicationDBContext _context;
        public UserController(ApplicationDBContext context)
        {
            _context = context;
        }

        [HttpGet]

        public IActionResult Get()
        {
            var posts = _context.User.ToList();
            return Ok(posts);
        }


        [HttpGet("{email}")]
        public IActionResult GetByEmail(string email)
        {
            var user = _context.User.FirstOrDefault(u => u.Email == email);
            if (user == null)
            {
                return NotFound();
            }
            return Ok(user);
        }
        
        
       [HttpGet("{email}/password/{password}")]
        public IActionResult Get(string email, string password)
        {
            var user = _context.User.FirstOrDefault(u => u.Email == email && u.Password == password);
            if (user == null)
            {
                return NotFound();
            }
            return Ok(user);
        }

        [HttpGet("id/{userId}")]
        public IActionResult Get(int userId)
        {
            var post = _context.User.Find(userId);
            if (post == null)
            {
                return NotFound();
            }
            return Ok(post);
        }

        [HttpPost]
        public IActionResult Post([FromBody] User user)
        {
            if (ModelState.IsValid)
            {
                _context.User.Add(user);
                _context.SaveChanges();
                return Ok(user);
            }
            return BadRequest();
        }

        [HttpPut("{userId}")]
        public IActionResult Update([FromRoute] int userId,[FromBody] User user)
        {
            var existingUser = _context.User.Find(userId);
            if (existingUser == null)
            {
                return NotFound();
            }

            existingUser.IncomeLbn = user.IncomeLbn;
            existingUser.IncomeUsd = user.IncomeUsd;
        
            _context.SaveChanges();
        
            return Ok(existingUser);
        }
    }
}