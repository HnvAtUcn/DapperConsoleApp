USE [master]
GO
/****** Object:  Database [BookDB]    Script Date: 14-04-2023 09:45:36 ******/
CREATE DATABASE [BookDB]
GO
USE [BookDB]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 14-04-2023 09:45:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[BookId] [int] IDENTITY(1,1) NOT NULL,
	[Isbn] [char](13) NOT NULL,
	[Title] [varchar](200) NOT NULL,
	[Description] [varchar](max) NULL,
	[Price] [float] NULL,
	[Cover] [varchar](200) NULL,
	[DateAcquired] [datetime] NULL,
	[Active] [bit] NOT NULL,
	[LanguageId] [int] NOT NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Language]    Script Date: 14-04-2023 09:45:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[LanguageId] [int] IDENTITY(1,1) NOT NULL,
	[LangCode] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewExample]    Script Date: 14-04-2023 09:45:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewExample]
AS
SELECT        dbo.Book.Title, dbo.Book.Description, dbo.Language.LangCode, dbo.Book.Price
FROM            dbo.Book INNER JOIN
                         dbo.Language ON dbo.Book.LanguageId = dbo.Language.LanguageId
GO
/****** Object:  Table [dbo].[Author]    Script Date: 14-04-2023 09:45:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[AuthorId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[Description] [varchar](2000) NULL,
	[NationalityId] [int] NOT NULL,
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[AuthorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookAuthor]    Script Date: 14-04-2023 09:45:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookAuthor](
	[BookId] [int] NOT NULL,
	[AuthorId] [int] NOT NULL,
 CONSTRAINT [PK_BookAuthor] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC,
	[AuthorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nationality]    Script Date: 14-04-2023 09:45:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nationality](
	[NationalityId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Nationality] PRIMARY KEY CLUSTERED 
(
	[NationalityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[BigMessyView]    Script Date: 14-04-2023 09:45:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BigMessyView]
AS
SELECT        dbo.Language.LanguageId, dbo.Language.LangCode AS Name, dbo.Author.FirstName, dbo.Author.LastName, dbo.Book.Title, dbo.Language.LangCode AS Expr1, dbo.Nationality.Name AS Expr2
FROM            dbo.Nationality INNER JOIN
                         dbo.Author ON dbo.Nationality.NationalityId = dbo.Author.NationalityId INNER JOIN
                         dbo.BookAuthor ON dbo.Author.AuthorId = dbo.BookAuthor.AuthorId INNER JOIN
                         dbo.Language INNER JOIN
                         dbo.Book ON dbo.Language.LanguageId = dbo.Book.LanguageId ON dbo.BookAuthor.BookId = dbo.Book.BookId
GO
/****** Object:  Table [dbo].[BookGenre]    Script Date: 14-04-2023 09:45:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookGenre](
	[BookId] [int] NOT NULL,
	[GenreId] [int] NOT NULL,
 CONSTRAINT [PK_BookGenre] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC,
	[GenreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genre]    Script Date: 14-04-2023 09:45:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genre](
	[GenreId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Description] [varchar](2000) NULL,
 CONSTRAINT [PK_Genre] PRIMARY KEY CLUSTERED 
(
	[GenreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Author] ON 
GO
INSERT [dbo].[Author] ([AuthorId], [FirstName], [LastName], [Description], [NationalityId]) VALUES (1, N'Michael', N'Andersen', N'blabla di bla', 1)
GO
INSERT [dbo].[Author] ([AuthorId], [FirstName], [LastName], [Description], [NationalityId]) VALUES (3, N'Michael', N'Jackson', N'Bla more blah', 3)
GO
INSERT [dbo].[Author] ([AuthorId], [FirstName], [LastName], [Description], [NationalityId]) VALUES (4, N'Hanne', N'Jensen', N'Forfatter fra Danmark', 1)
GO
INSERT [dbo].[Author] ([AuthorId], [FirstName], [LastName], [Description], [NationalityId]) VALUES (5, N'Joan', N'Ibsen', N'Kendt fra TV', 2)
GO
INSERT [dbo].[Author] ([AuthorId], [FirstName], [LastName], [Description], [NationalityId]) VALUES (6, N'John', N'Mellow', N'From Utah', 3)
GO
INSERT [dbo].[Author] ([AuthorId], [FirstName], [LastName], [Description], [NationalityId]) VALUES (7, N'Ingrid', N'Bergman', N'Very well known', 4)
GO
INSERT [dbo].[Author] ([AuthorId], [FirstName], [LastName], [Description], [NationalityId]) VALUES (8, N'Peter', N'Ingeson', N'Some text here!', 5)
GO
INSERT [dbo].[Author] ([AuthorId], [FirstName], [LastName], [Description], [NationalityId]) VALUES (9, N'Ulrik', N'Mogensen', N'Some text here!', 2)
GO
INSERT [dbo].[Author] ([AuthorId], [FirstName], [LastName], [Description], [NationalityId]) VALUES (10, N'Ulla', N'Henriksen', N'Some text here!', 1)
GO
SET IDENTITY_INSERT [dbo].[Author] OFF
GO
SET IDENTITY_INSERT [dbo].[Book] ON 
GO
INSERT [dbo].[Book] ([BookId], [Isbn], [Title], [Description], [Price], [Cover], [DateAcquired], [Active], [LanguageId]) VALUES (1, N'1234124512345', N'De 7 sm� nisser', N'This is a classic', 125, N'10humans.jpg', CAST(N'2018-09-17T13:12:48.000' AS DateTime), 1, 1)
GO
INSERT [dbo].[Book] ([BookId], [Isbn], [Title], [Description], [Price], [Cover], [DateAcquired], [Active], [LanguageId]) VALUES (3, N'2131236232131', N'Harry Potter and Supernan', N'A variant of a movie!', 99.95, N'21lessons.jpg', CAST(N'2018-09-17T00:00:00.000' AS DateTime), 1, 2)
GO
INSERT [dbo].[Book] ([BookId], [Isbn], [Title], [Description], [Price], [Cover], [DateAcquired], [Active], [LanguageId]) VALUES (4, N'2183213576575', N'De vise sten', N'Harry potter and the way of the stones!', 159, N'eleanor.jpg', CAST(N'2017-02-23T00:00:00.000' AS DateTime), 1, 4)
GO
INSERT [dbo].[Book] ([BookId], [Isbn], [Title], [Description], [Price], [Cover], [DateAcquired], [Active], [LanguageId]) VALUES (5, N'2136217367666', N'Den usynlige mand', N'Another classic', 199, N'fon.jpg', CAST(N'2016-01-31T00:00:00.000' AS DateTime), 1, 2)
GO
INSERT [dbo].[Book] ([BookId], [Isbn], [Title], [Description], [Price], [Cover], [DateAcquired], [Active], [LanguageId]) VALUES (6, N'11111        ', N'Frokost!', NULL, 87.5, N'geo.jpg', CAST(N'2018-09-25T13:40:14.643' AS DateTime), 1, 1)
GO
INSERT [dbo].[Book] ([BookId], [Isbn], [Title], [Description], [Price], [Cover], [DateAcquired], [Active], [LanguageId]) VALUES (7, N'MHA1234567890', N'Julehygge og gl�gg', N'bla bla bla tekst her!', 99.75, N'hoftime.jpg', CAST(N'2018-10-01T13:03:36.290' AS DateTime), 1, 1)
GO
INSERT [dbo].[Book] ([BookId], [Isbn], [Title], [Description], [Price], [Cover], [DateAcquired], [Active], [LanguageId]) VALUES (11, N'612368213    ', N'Gummi Tarzan', N'blabla', 139, N'homodeus.jpg', CAST(N'2018-10-01T00:00:00.000' AS DateTime), 1, 1)
GO
INSERT [dbo].[Book] ([BookId], [Isbn], [Title], [Description], [Price], [Cover], [DateAcquired], [Active], [LanguageId]) VALUES (12, N'127362183    ', N'Julemanden Vol 2', N'ajsdhajsdj', 90.9, N'littlefires.jpg', CAST(N'2018-01-22T00:00:00.000' AS DateTime), 1, 2)
GO
INSERT [dbo].[Book] ([BookId], [Isbn], [Title], [Description], [Price], [Cover], [DateAcquired], [Active], [LanguageId]) VALUES (13, N'126321783    ', N'Mine morgener p� Jorden', N'adhskhdsdas', 88, N'sapiens.jpg', CAST(N'2018-02-22T00:00:00.000' AS DateTime), 1, 3)
GO
SET IDENTITY_INSERT [dbo].[Book] OFF
GO
INSERT [dbo].[BookAuthor] ([BookId], [AuthorId]) VALUES (1, 1)
GO
INSERT [dbo].[BookAuthor] ([BookId], [AuthorId]) VALUES (1, 3)
GO
INSERT [dbo].[BookAuthor] ([BookId], [AuthorId]) VALUES (3, 3)
GO
INSERT [dbo].[BookAuthor] ([BookId], [AuthorId]) VALUES (3, 4)
GO
INSERT [dbo].[BookAuthor] ([BookId], [AuthorId]) VALUES (3, 5)
GO
INSERT [dbo].[BookAuthor] ([BookId], [AuthorId]) VALUES (4, 1)
GO
INSERT [dbo].[BookAuthor] ([BookId], [AuthorId]) VALUES (4, 3)
GO
INSERT [dbo].[BookAuthor] ([BookId], [AuthorId]) VALUES (4, 8)
GO
INSERT [dbo].[BookAuthor] ([BookId], [AuthorId]) VALUES (4, 9)
GO
INSERT [dbo].[BookAuthor] ([BookId], [AuthorId]) VALUES (5, 4)
GO
INSERT [dbo].[BookAuthor] ([BookId], [AuthorId]) VALUES (5, 7)
GO
INSERT [dbo].[BookAuthor] ([BookId], [AuthorId]) VALUES (5, 8)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (1, 2)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (1, 3)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (1, 4)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (3, 7)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (3, 8)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (4, 4)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (4, 5)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (4, 7)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (5, 1)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (5, 2)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (6, 1)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (6, 2)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (6, 3)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (7, 1)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (7, 2)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (7, 4)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (7, 5)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (11, 1)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (11, 2)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (11, 3)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (11, 4)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (12, 1)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (12, 2)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (12, 3)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (12, 5)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (13, 1)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (13, 2)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (13, 3)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (13, 4)
GO
INSERT [dbo].[BookGenre] ([BookId], [GenreId]) VALUES (13, 5)
GO
SET IDENTITY_INSERT [dbo].[Genre] ON 
GO
INSERT [dbo].[Genre] ([GenreId], [Name], [Description]) VALUES (1, N'Thriller', NULL)
GO
INSERT [dbo].[Genre] ([GenreId], [Name], [Description]) VALUES (2, N'Sci-Fi', NULL)
GO
INSERT [dbo].[Genre] ([GenreId], [Name], [Description]) VALUES (3, N'Fantasy', NULL)
GO
INSERT [dbo].[Genre] ([GenreId], [Name], [Description]) VALUES (4, N'Adventure', NULL)
GO
INSERT [dbo].[Genre] ([GenreId], [Name], [Description]) VALUES (5, N'Drama', NULL)
GO
INSERT [dbo].[Genre] ([GenreId], [Name], [Description]) VALUES (6, N'Horror', NULL)
GO
INSERT [dbo].[Genre] ([GenreId], [Name], [Description]) VALUES (7, N'Fiction', NULL)
GO
INSERT [dbo].[Genre] ([GenreId], [Name], [Description]) VALUES (8, N'Western', NULL)
GO
SET IDENTITY_INSERT [dbo].[Genre] OFF
GO
SET IDENTITY_INSERT [dbo].[Language] ON 
GO
INSERT [dbo].[Language] ([LanguageId], [LangCode]) VALUES (1, N'Danish')
GO
INSERT [dbo].[Language] ([LanguageId], [LangCode]) VALUES (2, N'English')
GO
INSERT [dbo].[Language] ([LanguageId], [LangCode]) VALUES (3, N'Swedish')
GO
INSERT [dbo].[Language] ([LanguageId], [LangCode]) VALUES (4, N'Norwegian')
GO
SET IDENTITY_INSERT [dbo].[Language] OFF
GO
SET IDENTITY_INSERT [dbo].[Nationality] ON 
GO
INSERT [dbo].[Nationality] ([NationalityId], [Name]) VALUES (1, N'Denmark')
GO
INSERT [dbo].[Nationality] ([NationalityId], [Name]) VALUES (2, N'Sweden')
GO
INSERT [dbo].[Nationality] ([NationalityId], [Name]) VALUES (3, N'USA')
GO
INSERT [dbo].[Nationality] ([NationalityId], [Name]) VALUES (4, N'Germany')
GO
INSERT [dbo].[Nationality] ([NationalityId], [Name]) VALUES (5, N'France')
GO
SET IDENTITY_INSERT [dbo].[Nationality] OFF
GO
ALTER TABLE [dbo].[Author]  WITH CHECK ADD  CONSTRAINT [FK_Author_Nationality] FOREIGN KEY([NationalityId])
REFERENCES [dbo].[Nationality] ([NationalityId])
GO
ALTER TABLE [dbo].[Author] CHECK CONSTRAINT [FK_Author_Nationality]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Language]
GO
ALTER TABLE [dbo].[BookAuthor]  WITH CHECK ADD  CONSTRAINT [FK_BookAuthor_Author] FOREIGN KEY([AuthorId])
REFERENCES [dbo].[Author] ([AuthorId])
GO
ALTER TABLE [dbo].[BookAuthor] CHECK CONSTRAINT [FK_BookAuthor_Author]
GO
ALTER TABLE [dbo].[BookAuthor]  WITH CHECK ADD  CONSTRAINT [FK_BookAuthor_Book] FOREIGN KEY([BookId])
REFERENCES [dbo].[Book] ([BookId])
GO
ALTER TABLE [dbo].[BookAuthor] CHECK CONSTRAINT [FK_BookAuthor_Book]
GO
ALTER TABLE [dbo].[BookGenre]  WITH CHECK ADD  CONSTRAINT [FK_BookGenre_Book] FOREIGN KEY([BookId])
REFERENCES [dbo].[Book] ([BookId])
GO
ALTER TABLE [dbo].[BookGenre] CHECK CONSTRAINT [FK_BookGenre_Book]
GO
ALTER TABLE [dbo].[BookGenre]  WITH CHECK ADD  CONSTRAINT [FK_BookGenre_Genre] FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genre] ([GenreId])
GO
ALTER TABLE [dbo].[BookGenre] CHECK CONSTRAINT [FK_BookGenre_Genre]
GO
USE [master]
GO
ALTER DATABASE [BookDB] SET  READ_WRITE 
GO
