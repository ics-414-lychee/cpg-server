USE [LycheeActivityOnNode414]
GO
/****** Object:  Table [dbo].[NodeTbl]    Script Date: 11/5/2017 4:24:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NodeTbl](
	[ProjectID] [bigint] NOT NULL,
	[NodeID] [int] IDENTITY(1,1) NOT NULL,
	[NodeName] [varchar](50) NOT NULL,
	[OptimalTime] [float] NOT NULL,
	[NormalTime] [float] NOT NULL,
	[PessimisticTime] [float] NOT NULL,
	[DependencyNodeID] [int] NULL,
	[Description] [varchar](255) NULL,
 CONSTRAINT [PK_NodeTbl] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC,
	[NodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
