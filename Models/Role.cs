using System.ComponentModel.DataAnnotations;

namespace Facebook.Models
{
	public class Role
	{
		[Key]
		public int Id { get; set; }
		public int RoleId { get; set; }
		public int userLoginId { get; set; }
	}
}
