USE [LycheeActivityOnNode414]
GO
/****** Object:  StoredProcedure [dbo].[CreateProject_Proc]    Script Date: 11/8/2017 10:32:58 AM ******/
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
	@ProjectName as varchar(50)
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
			ProjectOwner
		)
		VALUES(@ProjectName, @Username)

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
