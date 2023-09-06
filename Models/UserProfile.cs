using System.ComponentModel.DataAnnotations;

namespace Facebook.Models
{
	public class UserProfile
	{
		[Key]
		public int Id { get; set; }
		public string name { get; set; }
		public string date { get; set; }
		public string month { get; set; }
		public string year { get; set; }
		public int gender { get; set; }
		public string profile_pic { get; set; }
		public int userLoginId { get; set; }

	}
}
