USE [LycheeActivityOnNode414]
GO
/****** Object:  Table [dbo].[UserTbl]    Script Date: 11/17/2017 2:53:14 AM ******/
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
