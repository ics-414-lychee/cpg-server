USE [LycheeActivityOnNode414]
GO
/****** Object:  StoredProcedure [dbo].[ViewSingleProject_Proc]    Script Date: 11/17/2017 2:53:14 AM ******/
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
