USE [LycheeActivityOnNode414]
GO
/****** Object:  Table [dbo].[UserTbl]    Script Date: 11/5/2017 5:42:50 PM ******/
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
