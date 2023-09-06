using System;
using System.ComponentModel.DataAnnotations;

namespace Facebook.Models
{
	public class Posts
	{
		[Key]
		public int Id { get; set; }
		public string title { get; set; }
		public string description { get; set; }
		public string filepath { get; set; }
		public DateTime createdAt { get; set; }
		public int userId { get; set; }
	}
}
