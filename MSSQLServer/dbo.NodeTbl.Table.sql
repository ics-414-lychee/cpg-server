USE [LycheeActivityOnNode414]
GO
/****** Object:  Table [dbo].[NodeTbl]    Script Date: 11/17/2017 2:53:14 AM ******/
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
