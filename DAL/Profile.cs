using Facebook.Context;
using Facebook.IRepository;
using Facebook.Models;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;

namespace Facebook.DAL
{

    /*The GetProfileById method retrieves a user's profile from the database based on their ID. It returns the 
     * user's profile information.

The GetAllUser method retrieves all user profiles from the database, excluding the admin user. It returns a list of
	user profiles.

The deleteUser method deletes a user from the database based on their ID. It first checks if the user exists, 
	removes it from the context, and saves the changes. It returns true if 
	the deletion is successful; otherwise, it returns false.*/
    public class Profile : IProfile
	{
		private readonly DataContext _context;
		public Profile(DataContext context)
		{
			_context = context;
		}
		public UserLogin GetProfileById(int id)
		{
			var user = _context.Login.FirstOrDefault(x => x.Id == id);
			return user;
		}

		public List<UserLogin> GetAllUser()
		{
			var user = _context.Login.Where(x => x.Username.ToLower() != "admin").ToList();
			return user;
		}

		public bool deleteUser(int id)
		{
			bool flag = false;
			var user = _context.Login.FirstOrDefault(x => x.Id == id);
			if (user != null)
			{
				_context.Login.Remove(user);
			}
			int res = _context.SaveChanges();
			if (res > 0)
				flag = true;
			return flag;
		}
	}
}
