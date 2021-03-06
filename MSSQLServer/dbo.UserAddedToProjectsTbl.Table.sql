USE [LycheeActivityOnNode414]
GO
/****** Object:  Table [dbo].[UserAddedToProjectsTbl]    Script Date: 11/17/2017 2:53:14 AM ******/
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
