using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Facebook.Models
{
	public class UserLogin
	{
		[Key]
		public int Id { get; set; }

		public string Username { get; set; }

		public string Password { get; set; }

		public string Email { get; set; }

		public DateTime? Datetime { get; set; }

		[NotMapped]
		public int roleId { get; set; }
		[NotMapped]
		public string roleName { get; set; }
		[NotMapped]
		public int FriendId { get; set; }
		[NotMapped]
		public bool isFriendRequest { get; set; }
		[NotMapped]
		public int UserFriend_pk_id { get; set; }
		[NotMapped]
		public bool isAlreadyFriend { get; set; }
	}
}
