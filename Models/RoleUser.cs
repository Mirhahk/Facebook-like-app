using System.ComponentModel.DataAnnotations;

namespace Facebook.Models
{
	public class RoleUser
	{
		[Key]
		public int Id { get; set; }

		public string roleName { get; set; }
	}
}
