USE [LycheeActivityOnNode414]
GO
/****** Object:  StoredProcedure [dbo].[ViewAllAvailableProjects_Proc]    Script Date: 11/4/2017 4:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 10/29/2017
-- Description:	Gets all the user's projects that they are added to and gives the ProjectID and ProjectName
-- =============================================
ALTER PROCEDURE [dbo].[ViewAllAvailableProjects_Proc]
	@Username as varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT pt.ProjectID, ProjectName --Get the ProjectID and ProjectName
	FROM ProjectTbl pt --From this table we get access to every existing project and the owner
	LEFT JOIN UserAddedToProjectsTbl uap --From this table we get access to every user who is added to another project and is not the owner
	ON
		pt.ProjectID = uap.ProjectID
	WHERE
		ProjectOwner = @Username OR Username = @Username --Get the projects where the user is either the owner or added to it

END
