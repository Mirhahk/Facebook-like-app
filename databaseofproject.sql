USE [master]
GO
/****** Object:  Database [SocialDb]    Script Date: 6/21/2023 4:37:46 PM ******/
CREATE DATABASE [SocialDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SocialDb', FILENAME = N'C:\Users\hj\Desktop\MSSQL16.MSSQLSERVER\MSSQL\DATA\SocialDb.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SocialDb_log', FILENAME = N'C:\Users\hj\Desktop\MSSQL16.MSSQLSERVER\MSSQL\DATA\SocialDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SocialDb] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SocialDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SocialDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SocialDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SocialDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SocialDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SocialDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [SocialDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SocialDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SocialDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SocialDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SocialDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SocialDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SocialDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SocialDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SocialDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SocialDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SocialDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SocialDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SocialDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SocialDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SocialDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SocialDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SocialDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SocialDb] SET RECOVERY FULL 
GO
ALTER DATABASE [SocialDb] SET  MULTI_USER 
GO
ALTER DATABASE [SocialDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SocialDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SocialDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SocialDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SocialDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SocialDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SocialDb', N'ON'
GO
ALTER DATABASE [SocialDb] SET QUERY_STORE = ON
GO
ALTER DATABASE [SocialDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SocialDb]
GO
/****** Object:  UserDefinedFunction [dbo].[GetGroupMemberCount]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Function to get the total number of group members
CREATE FUNCTION [dbo].[GetGroupMemberCount](@GroupId int)
RETURNS INT
AS
BEGIN
    DECLARE @MemberCount INT;
    SELECT @MemberCount = COUNT(*) FROM [dbo].[Group_Member] WHERE [GroupId] = @GroupId;
    RETURN @MemberCount;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetTotalAttendees]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Function: GetTotalAttendees
CREATE FUNCTION [dbo].[GetTotalAttendees](@EventId INT)
RETURNS INT
AS
BEGIN
DECLARE @TotalAttendees INT;
SELECT @TotalAttendees = COUNT(*) FROM [dbo].[Event_Attendee] WHERE [eventId] = @EventId;
RETURN @TotalAttendees;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetUnreadNotificationCount]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create a scalar-valued function to retrieve the number of unread notifications for a user
CREATE FUNCTION [dbo].[GetUnreadNotificationCount] (@userId INT)
RETURNS INT
AS
BEGIN
    DECLARE @unreadCount INT;
    
    SELECT @unreadCount = COUNT(*) FROM [dbo].[User_Notification] WHERE [UserId] = @userId AND [IsRead] = 0;
    
    RETURN @unreadCount;
END;
GO
/****** Object:  Table [dbo].[Reel]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[title] [nvarchar](max) NULL,
	[description] [nvarchar](max) NULL,
	[createdAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Reel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ReelView]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create the view for Reel and User_Reel tables
CREATE VIEW [dbo].[ReelView]
AS
SELECT r.[Id], r.[userId], r.[title], r.[description], r.[createdAt]
FROM [dbo].[Reel] r
GO
/****** Object:  Table [dbo].[User_Reel]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Reel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[reelId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[createdAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_User_Reel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[User_ReelView]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[User_ReelView]
AS
SELECT ur.[Id], ur.[reelId], ur.[userId]
FROM [dbo].[User_Reel] ur
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[IsRead] [bit] NOT NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Notification]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Notification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NotificationId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsRead] [bit] NOT NULL,
 CONSTRAINT [PK_User_Notification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[User_NotificationView]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a view for the User_Notification table
CREATE VIEW [dbo].[User_NotificationView]
AS
SELECT un.[Id], un.[NotificationId], un.[UserId], un.[IsRead], n.[Type], n.[Message], n.[CreatedAt]
FROM [dbo].[User_Notification] un
INNER JOIN [dbo].[Notification] n ON un.[NotificationId] = n.[Id];
GO
/****** Object:  Table [dbo].[Group]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[OwnerId] [int] NOT NULL,
	[MemberCount] [int] NOT NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Group_Member]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group_Member](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NOT NULL,
	[MemberId] [int] NOT NULL,
 CONSTRAINT [PK_Group_Member] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[GroupView]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- View to retrieve group details with member count
CREATE VIEW [dbo].[GroupView]
AS
SELECT g.[Id], g.[GroupName], g.[Description], g.[OwnerId], COUNT(gm.[Id]) AS [MemberCount]
FROM [dbo].[Group] g
LEFT JOIN [dbo].[Group_Member] gm ON g.[Id] = gm.[GroupId]
GROUP BY g.[Id], g.[GroupName], g.[Description], g.[OwnerId];
GO
/****** Object:  Table [dbo].[EventPost]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventPost](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PostContent] [nvarchar](max) NULL,
	[PostedBy] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_EventPost] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Login]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Login](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](max) NULL,
	[Password] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[Datetime] [datetime2](7) NULL,
 CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventName] [nvarchar](255) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Event_EventName] UNIQUE NONCLUSTERED 
(
	[EventName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[EventPostView]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- View: EventPostView
CREATE VIEW [dbo].[EventPostView]
AS
SELECT EP.[Id], EP.[PostContent], L.[Username] AS PostedByUsername, E.[EventName], EP.[CreatedAt]
FROM [dbo].[EventPost] EP
JOIN [dbo].[Login] L ON EP.[PostedBy] = L.[Id]
JOIN [dbo].[Event] E ON EP.[EventId] = E.[Id];
GO
/****** Object:  View [dbo].[LoginView]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LoginView] AS
SELECT l.Id , l.Username , l.Email , l.Datetime
FROM Login as l


GO
/****** Object:  View [dbo].[GroupMemberCountView]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[GroupMemberCountView]
AS
SELECT g.[Id] AS [GroupId], COUNT(gm.[Id]) AS [MemberCount]
FROM [dbo].[Group] g
LEFT JOIN [dbo].[Group_Member] gm ON g.[Id] = gm.[GroupId]
GROUP BY g.[Id];
GO
/****** Object:  Table [dbo].[Posts]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](max) NULL,
	[description] [nvarchar](max) NULL,
	[filepath] [nvarchar](max) NULL,
	[userId] [int] NOT NULL,
	[createdAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[PostView]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PostView]
AS
SELECT dbo.Posts.*, Id AS Expr1, title AS Expr2, description AS Expr3, filepath AS Expr4
FROM     dbo.Posts
GO
/****** Object:  Table [dbo].[Logging]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logging](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[descriptions] [varchar](100) NULL,
	[userId] [int] NULL,
 CONSTRAINT [PK_Logging] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[LoggingView]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LoggingView]
AS
SELECT dbo.Logging.*, Id AS Expr1, descriptions AS Expr2, userId AS Expr3
FROM     dbo.Logging
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] NOT NULL,
	[description] [varchar](50) NULL,
	[user_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CommentsView]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CommentsView]
AS
SELECT dbo.Comments.*, Id AS Expr1, description AS Expr2, user_id AS Expr3
FROM     dbo.Comments
GO
/****** Object:  View [dbo].[EventView]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create the view for Event table
CREATE VIEW [dbo].[EventView]
AS
SELECT [Id], [EventName], [CreatedAt], [UpdatedAt]
FROM [dbo].[Event]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommentLikes]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommentLikes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CommentId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event_Attendee]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event_Attendee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[eventId] [int] NOT NULL,
	[attendeeId] [int] NOT NULL,
 CONSTRAINT [PK_Event_Attendee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PageLike]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PageLike](
	[PageLikeId] [int] IDENTITY(1,1) NOT NULL,
	[PageId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_PageLike] PRIMARY KEY CLUSTERED 
(
	[PageLikeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pages]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](50) NULL,
	[description] [varchar](200) NULL,
	[page_owner] [varchar](50) NULL,
	[likesCount] [int] NULL,
	[user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PostDetailLike]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostDetailLike](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[postId] [int] NULL,
	[isLiked] [bit] NULL,
	[ReactedId] [int] NULL,
 CONSTRAINT [PK_User_LikeReaction_mapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profiles]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profiles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NULL,
	[date] [nvarchar](max) NULL,
	[month] [nvarchar](max) NULL,
	[year] [nvarchar](max) NULL,
	[gender] [int] NOT NULL,
	[profile_pic] [nvarchar](max) NULL,
	[userLoginId] [int] NOT NULL,
 CONSTRAINT [PK_Profiles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReactedTypes]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReactedTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReactedType] [nvarchar](10) NULL,
 CONSTRAINT [PK_ReactedTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[userLoginId] [int] NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleUsers]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleUsers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[roleName] [nvarchar](max) NULL,
 CONSTRAINT [PK_RoleUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Community]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Community](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CommunityId] [int] NOT NULL,
 CONSTRAINT [PK_User_Community] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserFriends]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserFriends](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FriendId] [int] NOT NULL,
	[isFriendRequest] [bit] NOT NULL,
	[UserId] [int] NOT NULL,
	[isAlreadyYourFriend] [bit] NULL,
 CONSTRAINT [PK_UserFriends] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Group] ADD  DEFAULT ((0)) FOR [MemberCount]
GO
ALTER TABLE [dbo].[Notification] ADD  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[Posts] ADD  DEFAULT ((0)) FOR [userId]
GO
ALTER TABLE [dbo].[Posts] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [createdAt]
GO
ALTER TABLE [dbo].[Profiles] ADD  DEFAULT ((0)) FOR [userLoginId]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT ((0)) FOR [userLoginId]
GO
ALTER TABLE [dbo].[User_Reel] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[UserFriends] ADD  DEFAULT (CONVERT([bit],(0))) FOR [isFriendRequest]
GO
ALTER TABLE [dbo].[UserFriends] ADD  DEFAULT ((0)) FOR [UserId]
GO
ALTER TABLE [dbo].[CommentLikes]  WITH CHECK ADD  CONSTRAINT [FK_CommentLikes_Comments] FOREIGN KEY([CommentId])
REFERENCES [dbo].[Comments] ([Id])
GO
ALTER TABLE [dbo].[CommentLikes] CHECK CONSTRAINT [FK_CommentLikes_Comments]
GO
ALTER TABLE [dbo].[CommentLikes]  WITH CHECK ADD  CONSTRAINT [FK_CommentLikes_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[CommentLikes] CHECK CONSTRAINT [FK_CommentLikes_Users]
GO
ALTER TABLE [dbo].[Event_Attendee]  WITH CHECK ADD  CONSTRAINT [FK_Event_Attendee_Event] FOREIGN KEY([eventId])
REFERENCES [dbo].[Event] ([Id])
GO
ALTER TABLE [dbo].[Event_Attendee] CHECK CONSTRAINT [FK_Event_Attendee_Event]
GO
ALTER TABLE [dbo].[Event_Attendee]  WITH CHECK ADD  CONSTRAINT [FK_Event_Attendee_Login] FOREIGN KEY([attendeeId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[Event_Attendee] CHECK CONSTRAINT [FK_Event_Attendee_Login]
GO
ALTER TABLE [dbo].[EventPost]  WITH CHECK ADD  CONSTRAINT [FK_EventPost_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Event] ([Id])
GO
ALTER TABLE [dbo].[EventPost] CHECK CONSTRAINT [FK_EventPost_Event]
GO
ALTER TABLE [dbo].[EventPost]  WITH CHECK ADD  CONSTRAINT [FK_EventPost_Login] FOREIGN KEY([PostedBy])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[EventPost] CHECK CONSTRAINT [FK_EventPost_Login]
GO
ALTER TABLE [dbo].[Group]  WITH CHECK ADD  CONSTRAINT [FK_Group_Owner] FOREIGN KEY([OwnerId])
REFERENCES [dbo].[Profiles] ([Id])
GO
ALTER TABLE [dbo].[Group] CHECK CONSTRAINT [FK_Group_Owner]
GO
ALTER TABLE [dbo].[Group_Member]  WITH CHECK ADD  CONSTRAINT [FK_Group_Member_Group] FOREIGN KEY([GroupId])
REFERENCES [dbo].[Group] ([Id])
GO
ALTER TABLE [dbo].[Group_Member] CHECK CONSTRAINT [FK_Group_Member_Group]
GO
ALTER TABLE [dbo].[Group_Member]  WITH CHECK ADD  CONSTRAINT [FK_Group_Member_Member] FOREIGN KEY([MemberId])
REFERENCES [dbo].[Profiles] ([Id])
GO
ALTER TABLE [dbo].[Group_Member] CHECK CONSTRAINT [FK_Group_Member_Member]
GO
ALTER TABLE [dbo].[PageLike]  WITH CHECK ADD  CONSTRAINT [FK_PageLike_Page] FOREIGN KEY([PageId])
REFERENCES [dbo].[Pages] ([Id])
GO
ALTER TABLE [dbo].[PageLike] CHECK CONSTRAINT [FK_PageLike_Page]
GO
ALTER TABLE [dbo].[PageLike]  WITH CHECK ADD  CONSTRAINT [FK_PageLike_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[PageLike] CHECK CONSTRAINT [FK_PageLike_User]
GO
ALTER TABLE [dbo].[PostDetailLike]  WITH CHECK ADD  CONSTRAINT [FK_PostDetailLike_Posts] FOREIGN KEY([postId])
REFERENCES [dbo].[Posts] ([Id])
GO
ALTER TABLE [dbo].[PostDetailLike] CHECK CONSTRAINT [FK_PostDetailLike_Posts]
GO
ALTER TABLE [dbo].[PostDetailLike]  WITH CHECK ADD  CONSTRAINT [FK_PostDetailLike_ReactedTypes] FOREIGN KEY([ReactedId])
REFERENCES [dbo].[ReactedTypes] ([Id])
GO
ALTER TABLE [dbo].[PostDetailLike] CHECK CONSTRAINT [FK_PostDetailLike_ReactedTypes]
GO
ALTER TABLE [dbo].[Profiles]  WITH CHECK ADD  CONSTRAINT [FK_Profiles_Login] FOREIGN KEY([userLoginId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[Profiles] CHECK CONSTRAINT [FK_Profiles_Login]
GO
ALTER TABLE [dbo].[Reel]  WITH CHECK ADD  CONSTRAINT [FK_Reel_Login] FOREIGN KEY([userId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[Reel] CHECK CONSTRAINT [FK_Reel_Login]
GO
ALTER TABLE [dbo].[Roles]  WITH NOCHECK ADD  CONSTRAINT [FK_Roles_RoleUsers] FOREIGN KEY([Id])
REFERENCES [dbo].[RoleUsers] ([Id])
GO
ALTER TABLE [dbo].[Roles] CHECK CONSTRAINT [FK_Roles_RoleUsers]
GO
ALTER TABLE [dbo].[User_Community]  WITH CHECK ADD  CONSTRAINT [FK_User_Community_Community] FOREIGN KEY([CommunityId])
REFERENCES [dbo].[Group] ([Id])
GO
ALTER TABLE [dbo].[User_Community] CHECK CONSTRAINT [FK_User_Community_Community]
GO
ALTER TABLE [dbo].[User_Community]  WITH CHECK ADD  CONSTRAINT [FK_User_Community_Login] FOREIGN KEY([UserId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[User_Community] CHECK CONSTRAINT [FK_User_Community_Login]
GO
ALTER TABLE [dbo].[User_Community]  WITH CHECK ADD  CONSTRAINT [FK_User_Community_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Profiles] ([Id])
GO
ALTER TABLE [dbo].[User_Community] CHECK CONSTRAINT [FK_User_Community_User]
GO
ALTER TABLE [dbo].[User_Notification]  WITH CHECK ADD  CONSTRAINT [FK_User_Notification_Login] FOREIGN KEY([UserId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[User_Notification] CHECK CONSTRAINT [FK_User_Notification_Login]
GO
ALTER TABLE [dbo].[User_Notification]  WITH CHECK ADD  CONSTRAINT [FK_User_Notification_Notification] FOREIGN KEY([NotificationId])
REFERENCES [dbo].[Notification] ([Id])
GO
ALTER TABLE [dbo].[User_Notification] CHECK CONSTRAINT [FK_User_Notification_Notification]
GO
ALTER TABLE [dbo].[User_Reel]  WITH CHECK ADD  CONSTRAINT [FK_User_Reel_Login] FOREIGN KEY([userId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[User_Reel] CHECK CONSTRAINT [FK_User_Reel_Login]
GO
ALTER TABLE [dbo].[User_Reel]  WITH CHECK ADD  CONSTRAINT [FK_User_Reel_Login1] FOREIGN KEY([userId])
REFERENCES [dbo].[Login] ([Id])
GO
ALTER TABLE [dbo].[User_Reel] CHECK CONSTRAINT [FK_User_Reel_Login1]
GO
ALTER TABLE [dbo].[User_Reel]  WITH CHECK ADD  CONSTRAINT [FK_User_Reel_Reel] FOREIGN KEY([reelId])
REFERENCES [dbo].[Reel] ([Id])
GO
ALTER TABLE [dbo].[User_Reel] CHECK CONSTRAINT [FK_User_Reel_Reel]
GO
/****** Object:  StoredProcedure [dbo].[AddEvent]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create the stored procedure for adding events
CREATE PROCEDURE [dbo].[AddEvent]
    @EventName NVARCHAR(255),
    @CreatedAt DATETIME,
    @EventId INT OUTPUT
AS
BEGIN
    -- Declare a variable to hold the result
    DECLARE @Result INT;

    -- Check if the event name already exists
    IF EXISTS (SELECT 1 FROM [dbo].[Event] WHERE [EventName] = @EventName)
    BEGIN
        SET @Result = 0; -- Event name already exists
    END
    ELSE
    BEGIN
        -- Insert the event into the Event table
        INSERT INTO [dbo].[Event] ([EventName], [CreatedAt])
        VALUES (@EventName, @CreatedAt);

        -- Get the ID of the inserted event
        SET @EventId = SCOPE_IDENTITY();

        SET @Result = 1; -- Event added successfully
    END

    -- Return the result and event ID
    SELECT @Result AS Result, @EventId AS EventId;
END
GO
/****** Object:  StoredProcedure [dbo].[AddEventAttendee]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Stored Procedure: AddEventAttendee
CREATE PROCEDURE [dbo].[AddEventAttendee]
@EventId INT,
@AttendeeId INT
AS
BEGIN
INSERT INTO [dbo].[Event_Attendee] ([eventId], [attendeeId])
VALUES (@EventId, @AttendeeId);
END;
GO
/****** Object:  StoredProcedure [dbo].[AddGroupMember]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure to add a new member to a group
CREATE PROCEDURE [dbo].[AddGroupMember]
    @GroupId INT,
    @MemberId INT
AS
BEGIN
    INSERT INTO [dbo].[Group_Member] ([GroupId], [MemberId])
    VALUES (@GroupId, @MemberId);
END;
GO
/****** Object:  StoredProcedure [dbo].[AddPageLike]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddPageLike]
    @PageId INT,
    @UserId INT
AS
BEGIN
    INSERT INTO [dbo].[PageLike] ([PageId], [UserId])
    VALUES (@PageId, @UserId)
END
GO
/****** Object:  StoredProcedure [dbo].[AddPost]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddPost]
	  @title NVARCHAR(255),
    @description NVARCHAR(255),
    @filepath NVARCHAR(255),
    @createdAt DATETIME,
    @userId INT,
	@result INT OUTPUT
   
AS
BEGIN
-- Declare a variable to hold the result
    DECLARE @PostId INT;
  INSERT INTO [dbo].[Posts]
           ([title]
           ,[description]
           ,[filepath]
           ,[userId]
           ,[createdAt])
     VALUES
          
           (@title, @description,@filepath, @userId, @createdAt)

		    -- Get the ID of the inserted post
    SET @PostId = SCOPE_IDENTITY();

    -- Check if the insertion was successful
    IF @PostId IS NOT NULL
    BEGIN
        -- Successful insertion
        SET @result = 1;
    END
    ELSE
    BEGIN
        -- Failed insertion
        SET @result = 0;
    END

    -- Return the result
    SELECT @result AS InsertionResult;
END

GO
/****** Object:  StoredProcedure [dbo].[AddUserReel]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create the stored procedure for adding user reels
CREATE PROCEDURE [dbo].[AddUserReel]
    @reelId INT,
    @userId INT,
    @result INT OUTPUT
AS
BEGIN
    -- Declare a variable to hold the result
    SET @result = 0;

    -- Check if the reelId and userId exist in the respective tables
    IF EXISTS (SELECT 1 FROM [dbo].[Reel] WHERE [Id] = @reelId) AND EXISTS (SELECT 1 FROM [dbo].[Login] WHERE [Id] = @userId)
    BEGIN
        -- Insert the user reel into the User_Reel table
        INSERT INTO [dbo].[User_Reel] ([reelId], [userId])
        VALUES (@reelId, @userId);

        SET @result = 1; -- User reel added successfully
    END

    -- Return the result
    SELECT @result AS Result;
END
GO
/****** Object:  StoredProcedure [dbo].[AddUserToCommunity]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddUserToCommunity]
    @UserId INT,
    @CommunityId INT
AS
BEGIN
    INSERT INTO [dbo].[User_Community] ([UserId], [CommunityId])
    VALUES (@UserId, @CommunityId);
END;
GO
/****** Object:  StoredProcedure [dbo].[CheckPageLike]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckPageLike]
    @PageId INT,
    @UserId INT,
    @IsLiked BIT OUTPUT
AS
BEGIN
    SET @IsLiked = 0

    IF EXISTS (
        SELECT 1
        FROM [dbo].[PageLike]
        WHERE [PageId] = @PageId AND [UserId] = @UserId
    )
    BEGIN
        SET @IsLiked = 1
    END
END
GO
/****** Object:  StoredProcedure [dbo].[CreateGroup]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateGroup]
    @GroupName VARCHAR(50),
    @Description VARCHAR(200),
    @OwnerId INT
AS
BEGIN
    INSERT INTO [dbo].[Group] ([GroupName], [Description], [OwnerId])
    VALUES (@GroupName, @Description, @OwnerId);
END;
GO
/****** Object:  StoredProcedure [dbo].[GetPageLikeCount]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetPageLikeCount]
    @PageId INT,
    @LikeCount INT OUTPUT
AS
BEGIN
    SELECT @LikeCount = COUNT(*) 
    FROM [dbo].[PageLike]
    WHERE [PageId] = @PageId
END
GO
/****** Object:  StoredProcedure [dbo].[LoginGetUser]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LoginGetUser]
	@username nvarchar(50),
	@password nvarchar(50)
AS
BEGIN
	
	SELECT l.Id , l.Username , l.Password, l.Datetime , l.Email , ru.Id as roleId  , ru.roleName from Login l inner join Roles r on l.Id = r.userLoginId inner join RoleUsers ru on r.RoleId = ru.Id
	where (l.Username = @username or l.Email = @username ) and l.Password = @password
END


GO
/****** Object:  StoredProcedure [dbo].[MarkNotificationAsRead]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to mark a notification as read for a user
CREATE PROCEDURE [dbo].[MarkNotificationAsRead] (@notificationId INT, @userId INT)
AS
BEGIN
    UPDATE [dbo].[User_Notification] SET [IsRead] = 1 WHERE [NotificationId] = @notificationId AND [UserId] = @userId;
END;
GO
/****** Object:  StoredProcedure [dbo].[RemovePageLike]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RemovePageLike]
    @PageLikeId INT
AS
BEGIN
    DELETE FROM [dbo].[PageLike]
    WHERE [PageLikeId] = @PageLikeId
END
GO
/****** Object:  StoredProcedure [dbo].[RemoveUserFromCommunity]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RemoveUserFromCommunity]
    @UserId INT,
    @CommunityId INT
AS
BEGIN
    DELETE FROM [dbo].[User_Community]
    WHERE [UserId] = @UserId AND [CommunityId] = @CommunityId;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUserFriendsByUserId]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetUserFriendsByUserId]
	@userid int

	as
BEGIN
	
	SELECT * from Login  l inner join UserFriends u_f   on l.Id = u_f.UserId where l.Id = @userid
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PostDetails]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PostDetails]
	@postId int

	as
BEGIN
	
	select * from Posts as p inner join Login as l on p.userId =  l.Id inner join PostDetailLike pd on p.Id = pd.postId 
	inner join ReactedTypes rt on pd.ReactedId = rt.Id where p.Id = @postId
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UserCommentMappingInfo]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UserCommentMappingInfo]
	@userid int

	as
BEGIN
	
	SELECT * from Profiles  user_profile inner join dbo.Comments  c on user_profile.Id = c.user_id where user_profile.Id = @userid
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UserPageMappingInfo]    Script Date: 6/21/2023 4:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UserPageMappingInfo]
	@userid int

	as
BEGIN
	
	SELECT * from Profiles  user_profile inner join dbo.Pages  user_page on user_profile.Id = user_page.user_id where user_profile.Id = @userid
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Comments"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CommentsView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CommentsView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Logging"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LoggingView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LoggingView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Posts"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PostView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PostView'
GO
USE [master]
GO
ALTER DATABASE [SocialDb] SET  READ_WRITE 
GO
