USE [master]
GO
/****** Object:  Database [LycheeActivityOnNode414]    Script Date: 11/17/2017 2:52:54 AM ******/
CREATE DATABASE [LycheeActivityOnNode414]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LycheeActivityOnNode414', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\LycheeActivityOnNode414.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON
( NAME = N'LycheeActivityOnNode414_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\LycheeActivityOnNode414_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [LycheeActivityOnNode414] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LycheeActivityOnNode414].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LycheeActivityOnNode414] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET ARITHABORT OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET RECOVERY FULL 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET  MULTI_USER 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LycheeActivityOnNode414] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LycheeActivityOnNode414] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'LycheeActivityOnNode414', N'ON'
GO
ALTER DATABASE [LycheeActivityOnNode414] SET QUERY_STORE = OFF
GO
USE [LycheeActivityOnNode414]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [LycheeActivityOnNode414]
GO
/****** Object:  Table [dbo].[NodeTbl]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NodeTbl](
	[ProjectID] [bigint] NOT NULL,
	[NodeID] [int] NOT NULL,
	[NodeName] [varchar](50) NOT NULL,
	[OptimalTime] [float] NOT NULL,
	[NormalTime] [float] NOT NULL,
	[PessimisticTime] [float] NOT NULL,
	[DependencyNodeID] [int] NOT NULL,
	[Description] [varchar](600) NULL,
 CONSTRAINT [PK_NodeTbl_1] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC,
	[NodeID] ASC,
	[DependencyNodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectTbl]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectTbl](
	[ProjectID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProjectName] [varchar](50) NOT NULL,
	[ProjectOwner] [varchar](50) NOT NULL,
	[ProjectDeadline] [float] NOT NULL,
 CONSTRAINT [PK_ProjectTbl] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAddedToProjectsTbl]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAddedToProjectsTbl](
	[Username] [varchar](50) NOT NULL,
	[ProjectID] [bigint] NOT NULL,
 CONSTRAINT [PK_UserAddedToProjectsTbl] PRIMARY KEY CLUSTERED 
(
	[Username] ASC,
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAuthenticationTbl]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAuthenticationTbl](
	[Username] [varchar](50) NOT NULL,
	[Authtoken] [varchar](40) NOT NULL,
	[LastTimeUsed] [datetime] NOT NULL,
 CONSTRAINT [PK_UserAuthenticationTbl] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTbl]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTbl](
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](60) NOT NULL,
	[Salt] [varchar](22) NOT NULL,
 CONSTRAINT [PK_UserTable] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[CreateProject_Proc]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 11/5/2017
-- Description:	Creates a project if project does not exist for this user.
--				Returns ProjectID in addition to Error, ErrorMessage
--				Only care about projects that the user OWNS. I.E, a user can own a project named Test and also be added to a project named Test
--				BUT the user cannot OWN two projects called Test.
-- =============================================
CREATE PROCEDURE [dbo].[CreateProject_Proc] 
	@Username as varchar(50),
	@ProjectName as varchar(50),
	@ProjectDeadline as float
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @WhatIsError as varchar(200) = ''
	DECLARE @ProjectID as bigint = 0

	--If not exists, we are allowed to create the project. Otherwise, the project already exists
	IF NOT EXISTS(SELECT ProjectID FROM ProjectTbl WHERE ProjectName = @ProjectName AND ProjectOwner = @Username)
	BEGIN
		INSERT INTO ProjectTbl (
			ProjectName,
			ProjectOwner,
			ProjectDeadline
		)
		VALUES(@ProjectName, @Username, @ProjectDeadline)

		SELECT @ProjectID = ProjectID
		FROM ProjectTbl
		WHERE ProjectName = @ProjectName AND ProjectOwner = @Username

	END
	ELSE
	BEGIN
		SET @WhatIsError = 'Project name already exists. Please choose another name'
	END

	SELECT	CASE @WhatIsError 
				WHEN '' THEN 'true' 
				ELSE 'false' 
			END as Success, @WhatIsError as Error, @ProjectID as PID

END
GO
/****** Object:  StoredProcedure [dbo].[DeleteProject_Proc]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 10/29/2017
-- Description:	Deletes projects. Only the owner may delete the project
-- =============================================
CREATE PROCEDURE [dbo].[DeleteProject_Proc]
	@Username varchar(50),	--Owner
	@ProjectID bigint		--Project ID to delete
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @WhatIsError as varchar(200) = ''

	--If project exists where the project is the owner, we can successfully do deletion. Otherwise, we need to tell the front that the project doesnt exist
	IF EXISTS(SELECT TOP 1 ProjectID FROM ProjectTbl WHERE ProjectOwner = @Username AND ProjectID = @ProjectID)
	BEGIN
		DELETE FROM ProjectTbl WHERE ProjectOwner = @Username AND ProjectID = @ProjectID
		DELETE FROM UserAddedToProjectsTbl WHERE ProjectID = @ProjectID
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT TOP 1 ProjectID FROM ProjectTbl WHERE ProjectID = @ProjectID)
		BEGIN
			SET @WhatIsError = 'Only the project owner can delete this project'
		END
		ELSE
		BEGIN
			SET @WhatIsError = 'User or project does not exist'
		END
	END

	SELECT	CASE @WhatIsError 
				WHEN '' THEN 'true' 
				ELSE 'false' 
			END as Success, @WhatIsError as Error

END
GO
/****** Object:  StoredProcedure [dbo].[MaintenanceAuthentication_Proc]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 11/6/2017
-- Description:	If there has been no change within 30 minutes to an hour for a user, assume log off or afk and
--				change the user's auth token to make them login again.
-- =============================================
CREATE PROCEDURE [dbo].[MaintenanceAuthentication_Proc]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF EXISTS(SELECT Username FROM UserAuthenticationTbl GROUP BY Username, LastTimeUsed HAVING DATEDIFF(minute, LastTimeUsed, GETDATE()) >= 30)
	BEGIN
		UPDATE UserAuthenticationTbl
		SET Authtoken = (
			SELECT
				c1 AS [text()]
			FROM
				(
					SELECT TOP (40) c1
					FROM
					(
						VALUES
							('A'), ('B'), ('C'), ('D'), ('E'), ('F'), ('G'), ('H'), ('I'), ('J'),
							('K'), ('L'), ('M'), ('N'), ('O'), ('P'), ('Q'), ('R'), ('S'), ('T'),
							('U'), ('V'), ('W'), ('X'), ('Y'), ('Z'), ('0'), ('1'), ('2'), ('3'),
							('4'), ('5'), ('6'), ('7'), ('8'), ('9'), ('#'), ('$'), ('!'), ('@'), 
							('%'), ('^'), ('*')
					) AS T1(c1)
					ORDER BY ABS(CHECKSUM(NEWID()))
				) AS T2
			FOR XML PATH('')
			)
		FROM UserAuthenticationTbl
		WHERE Username in (	SELECT Username 
							FROM UserAuthenticationTbl 
							GROUP BY Username, LastTimeUsed
							HAVING 
								DATEDIFF(minute, LastTimeUsed, GETDATE()) >= 30)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[UserAuthentication_Proc]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 11/4/2017
-- Description:	Checks if the user is authorized
-- =============================================
CREATE PROCEDURE [dbo].[UserAuthentication_Proc]
	@Username varchar(50),		--User to atuhenticate
	@Authtoken varchar(40)		--Project ID to delete
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @WhatIsError as varchar(200) = ''

	IF EXISTS(SELECT TOP 1 Username FROM UserAuthenticationTbl WHERE Username = @Username AND Authtoken = @Authtoken)
	BEGIN
		UPDATE UserAuthenticationTbl
		SET LastTimeUsed = GETDATE()
		WHERE Username = @Username AND Authtoken = @Authtoken
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT TOP 1 Username FROM UserAuthenticationTbl WHERE Username = @Username)
		BEGIN
			--Authtoken is invalid
			SET @WhatIsError = 'Please re-login'
		END
		ELSE
		BEGIN
			--User does not exist
			SET @WhatIsError = 'Username does not exist'
		END
	END

	SELECT	CASE @WhatIsError 
				WHEN '' THEN 'true' 
				ELSE 'false' 
			END as Success, @WhatIsError as Error

END
GO
/****** Object:  StoredProcedure [dbo].[UserInitializeSaveFullProject_Proc]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 11/5/2017
-- Description:	To init full save, delete all nodes (this proc assumes that full save happens right after)
-- =============================================
CREATE PROCEDURE [dbo].[UserInitializeSaveFullProject_Proc] 
	@Username as varchar(50), --Perform verification that User is part of project (to be safe)
	@ProjectID as bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @WhatIsError as varchar(200) = ''

	IF EXISTS(	SELECT *
				FROM ProjectTbl pt
				LEFT JOIN UserAddedToProjectsTbl uap
				ON
					pt.ProjectID = uap.ProjectID
				WHERE
					(ProjectOwner = @Username OR Username = @Username)
					AND (pt.ProjectID = @ProjectID OR uap.ProjectID = @ProjectID))
	BEGIN
		DELETE FROM NodeTbl WHERE ProjectID = @ProjectID
	END
	ELSE
	BEGIN
		SET @WhatIsError = 'Project does not exist'
	END

	SELECT	CASE @WhatIsError 
				WHEN '' THEN 'true' 
				ELSE 'false' 
			END as Success, @WhatIsError as Error
    
END
GO
/****** Object:  StoredProcedure [dbo].[UserLoginOrCreate_Proc]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 10/29/2017
-- Description:	Verifies a user login or creates a new login depending on @Action parameter
--		If the Action is 1, a Username can only be inserted into the table if the username does not exist
-- =============================================
CREATE PROCEDURE [dbo].[UserLoginOrCreate_Proc]
	@Username	varchar(50),
	@Password	varchar(60),
	@Salt		varchar(22), --Only used when @Action is 1
	@Action		bit --0 refers to login, 1 refers to create
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Error message that returns something when an error occurs
	DECLARE @WhatIsError varchar(200) = ''
	DECLARE @Auth as varchar(40)

	--Generate new AuthToken
	SET @Auth = (
	SELECT
		c1 AS [text()]
	FROM
		(
			SELECT TOP (40) c1
			FROM
			(
				VALUES
					('A'), ('B'), ('C'), ('D'), ('E'), ('F'), ('G'), ('H'), ('I'), ('J'),
					('K'), ('L'), ('M'), ('N'), ('O'), ('P'), ('Q'), ('R'), ('S'), ('T'),
					('U'), ('V'), ('W'), ('X'), ('Y'), ('Z'), ('0'), ('1'), ('2'), ('3'),
					('4'), ('5'), ('6'), ('7'), ('8'), ('9'), ('#'), ('$'), ('!'), ('@'), 
					('%'), ('^'), ('*')
			) AS T1(c1)
			ORDER BY ABS(CHECKSUM(NEWID()))
		) AS T2
	FOR XML PATH('')
	)

	IF @Action = 1
	BEGIN
		IF EXISTS(SELECT TOP 1 Username FROM UserTbl WHERE Username = @Username)
		BEGIN
			SET @WhatIsError = 'Username already exists'
		END
		ELSE
		BEGIN
			INSERT INTO UserTbl (
				Username,
				[Password],
				Salt
			)
			VALUES (@Username, @Password, @Salt)

			INSERT INTO UserAuthenticationTbl (
				Username,
				Authtoken,
				LastTimeUsed
			)
			VALUES(@Username, @Auth, GETDATE()) --Date always overridden on successful login anyway

		END
	END
	ELSE
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 Username FROM UserTbl WHERE Username = @Username AND [Password] = @Password)
		BEGIN
			SET @WhatIsError = 'Incorrect username or password'
		END
		ELSE
		BEGIN
			--Succcessful login
			UPDATE UserAuthenticationTbl 
			SET Authtoken = @Auth,
				LastTimeUsed = GETDATE()
			WHERE
				Username = @Username

		END
	END

	SELECT	CASE @WhatIsError 
				WHEN '' THEN 'true' 
				ELSE 'false' 
			END as Success, @WhatIsError as Error, @Auth as Authtoken

END
GO
/****** Object:  StoredProcedure [dbo].[UserSaveSingleNode_Proc]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 11/5/2017
-- Description:	Saves a single node to project
-- =============================================
CREATE PROCEDURE [dbo].[UserSaveSingleNode_Proc] 
	@Username as varchar(50), --Perform verification that User is part of project (to be safe)
	@ProjectID as bigint,
	@NodeID as int,
	@NodeName as varchar(50),
	@OptimalTime as float,
	@NormalTime as float,
	@PessimisticTime as float,
	@DependencyNodeID as int,
	@Description as varchar(600)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @WhatIsError as varchar(200) = ''

	IF EXISTS(	SELECT *
				FROM ProjectTbl pt
				LEFT JOIN UserAddedToProjectsTbl uap
				ON
					pt.ProjectID = uap.ProjectID
				WHERE
					ProjectOwner = @Username OR Username = @Username)
	BEGIN
		INSERT INTO NodeTbl (
			ProjectID,
			NodeID,
			NodeName,
			OptimalTime,
			NormalTime,
			PessimisticTime,
			DependencyNodeID,
			Description
		)
		VALUES(@ProjectID, @NodeID, @NodeName, @OptimalTime, @NormalTime, @PessimisticTime, @DependencyNodeID, @Description)
	END
	ELSE
	BEGIN
		SET @WhatIsError = 'Project does not exist'
	END

	SELECT	CASE @WhatIsError 
				WHEN '' THEN 'true' 
				ELSE 'false' 
			END as Success, @WhatIsError as Error
    
END
GO
/****** Object:  StoredProcedure [dbo].[UserUpdateProject_Proc]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 11/17/2017
-- Description:	Updates project's deadline (and if implemented later, name)
-- =============================================
CREATE PROCEDURE [dbo].[UserUpdateProject_Proc] 
	@Username as varchar(50), --Perform verification that User is part of project (to be safe)
	@ProjectID as bigint,
	@ProjectDeadline as float
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @WhatIsError as varchar(200) = ''

	IF EXISTS(	SELECT *
				FROM ProjectTbl pt
				LEFT JOIN UserAddedToProjectsTbl uap
				ON
					pt.ProjectID = uap.ProjectID
				WHERE
					ProjectOwner = @Username OR Username = @Username)
	BEGIN
		
		UPDATE ProjectTbl
		SET ProjectDeadline = @ProjectDeadline
		WHERE ProjectID = @ProjectID
		
	END
	ELSE
	BEGIN
		SET @WhatIsError = 'Project does not exist'
	END

	SELECT	CASE @WhatIsError 
				WHEN '' THEN 'true' 
				ELSE 'false' 
			END as Success, @WhatIsError as Error
    
END
GO
/****** Object:  StoredProcedure [dbo].[ViewAllAvailableProjects_Proc]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 10/29/2017
-- Description:	Gets all the user's projects that they are added to and gives the ProjectID and ProjectName
-- =============================================
CREATE PROCEDURE [dbo].[ViewAllAvailableProjects_Proc]
	@Username as varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	SELECT CASE WHEN ppid IS NULL THEN upid ELSE ppid END, pn, deadline --Case choose either or
	FROM
		(SELECT pt.ProjectID as ppid, uap.ProjectID as upid, ProjectName as pn, pt.ProjectDeadline as deadline --Get the ProjectID and ProjectName
		FROM ProjectTbl pt --From this table we get access to every existing project and the owner
		LEFT JOIN UserAddedToProjectsTbl uap --From this table we get access to every user who is added to another project and is not the owner
		ON
			pt.ProjectID = uap.ProjectID
		WHERE
			ProjectOwner = @Username OR Username = @Username --Get the projects where the user is either the owner or added to it
		) as b
END
GO
/****** Object:  StoredProcedure [dbo].[ViewRandomGeneratedSalt_Proc]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 11/5/2017
-- Description:	Generates a random salt
-- =============================================
CREATE PROCEDURE [dbo].[ViewRandomGeneratedSalt_Proc]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Salt as varchar(22) = ''

	SET @Salt = (
	SELECT
		c1 AS [text()]
	FROM
		(
		SELECT TOP (22) c1
		FROM
			(
		VALUES
			('A'), ('B'), ('C'), ('D'), ('E'), ('F'), ('G'), ('H'), ('I'), ('J'),
			('K'), ('L'), ('M'), ('N'), ('O'), ('P'), ('Q'), ('R'), ('S'), ('T'),
			('U'), ('V'), ('W'), ('X'), ('Y'), ('Z'), ('0'), ('1'), ('2'), ('3'),
			('4'), ('5'), ('6'), ('7'), ('8'), ('9'), ('a'), ('b'), ('c'), ('d'),
			('e'), ('f'), ('g'), ('h'), ('i'), ('j'), ('k'), ('l'), ('m'), ('n'),
			('o'), ('p'), ('q'), ('r'), ('s'), ('t'), ('u'), ('v'), ('w'), ('x'),
			('y'), ('z')
			) AS T1(c1)
		ORDER BY ABS(CHECKSUM(NEWID()))
		) AS T2
	FOR XML PATH('')
	);

	SELECT @Salt as Salt

END
GO
/****** Object:  StoredProcedure [dbo].[ViewSaltForUser_Proc]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 11/4/2017
-- Description:	Returns the user's salt to middle end. Need this for hashing correctly
-- =============================================
CREATE PROCEDURE [dbo].[ViewSaltForUser_Proc]
	@Username as varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @WhatIsError as varchar(200) = ''
	DECLARE @Salt as varchar(22) = ''

	IF EXISTS(SELECT TOP 1 Salt FROM UserTbl WHERE Username=@Username)
	BEGIN
		SELECT @Salt = Salt FROM UserTbl WHERE Username = @Username
	END
	ELSE
	BEGIN
		SET @WhatIsError = 'Incorrect username or password'
	END

	SELECT	CASE @WhatIsError 
				WHEN '' THEN 'true' 
				ELSE 'false' 
			END as Success, @WhatIsError as Error, @Salt as Salt

END
GO
/****** Object:  StoredProcedure [dbo].[ViewSingleProject_Proc]    Script Date: 11/17/2017 2:52:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 11/4/2017
-- Description:	Gets a single project. User must be either added to owner to the project in question
CREATE PROCEDURE [dbo].[ViewSingleProject_Proc]
	@Username as varchar(50),
	@ProjectID as bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @WhatIsError as varchar(200) = ''


	IF NOT EXISTS(SELECT *
	FROM ProjectTbl pt --From this table we get access to every existing project and the owner
	LEFT JOIN UserAddedToProjectsTbl uap --From this table we get access to every user who is added to another project and is not the owner
	ON
		pt.ProjectID = uap.ProjectID
	WHERE
		(ProjectOwner = @Username OR Username = @Username) --Get the projects where the user is either the owner or added to it
		AND (pt.ProjectID = @ProjectID OR uap.ProjectID = @ProjectID))
	BEGIN
		SET @WhatIsError = 'Project does not exist' --Best thing to output to user
	END

	SELECT	CASE @WhatIsError 
				WHEN '' THEN 'true' 
				ELSE 'false' 
			END as Success, @WhatIsError as Error

	IF @WhatIsError = ''
	BEGIN
		--Output second result set which should be all the nodes to a project since we confirmed that the user is added to the project
		SELECT * FROM NodeTbl WHERE ProjectID = @ProjectID
	END

END
GO
USE [master]
GO
ALTER DATABASE [LycheeActivityOnNode414] SET  READ_WRITE 
GO
