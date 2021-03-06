USE [LycheeActivityOnNode414]
GO
/****** Object:  Table [dbo].[UserAuthenticationTbl]    Script Date: 11/17/2017 2:53:14 AM ******/
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
