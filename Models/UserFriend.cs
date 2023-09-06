using System.ComponentModel.DataAnnotations;

namespace Facebook.Models
{
	public class UserFriend
	{
		[Key]
		public int id { get; set; }

		public int UserId { get; set; }
		public int FriendId { get; set; }
		public bool isFriendRequest { get; set; }
        public bool? isAlreadyYourFriend { get; set; }
    }
}
