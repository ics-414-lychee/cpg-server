USE [LycheeActivityOnNode414]
GO
/****** Object:  Table [dbo].[ProjectTbl]    Script Date: 11/17/2017 2:53:14 AM ******/
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
