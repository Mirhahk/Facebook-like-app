using Facebook.Models;
using Microsoft.EntityFrameworkCore;

namespace Facebook.Context
{
	public class DataContext : DbContext
	{
		public DataContext(DbContextOptions options) : base(options)
		{

		}

		public DbSet<UserLogin> Login { get; set; }
		public DbSet<UserProfile> Profiles { get; set; }
		public DbSet<Role> Roles { get; set; }
		public DbSet<RoleUser> RoleUsers { get; set; }
		public DbSet<Posts> Posts { get; set; }
		public DbSet<UserFriend> UserFriends { get; set; }
	}
}
