USE [LycheeActivityOnNode414]
GO
/****** Object:  StoredProcedure [dbo].[UserUpdateProject_Proc]    Script Date: 11/17/2017 2:53:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 11/17/2017
-- Description:	Updates project's deadline (and if implemented later, name)
-- =============================================
CREATE PROCEDURE [dbo].[UserUpdateProject_Proc] 
	@Username as varchar(50), --Perform verification that User is part of project (to be safe)
	@ProjectID as bigint,
	@ProjectDeadline as float
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @WhatIsError as varchar(200) = ''

	IF EXISTS(	SELECT *
				FROM ProjectTbl pt
				LEFT JOIN UserAddedToProjectsTbl uap
				ON
					pt.ProjectID = uap.ProjectID
				WHERE
					ProjectOwner = @Username OR Username = @Username)
	BEGIN
		
		UPDATE ProjectTbl
		SET ProjectDeadline = @ProjectDeadline
		WHERE ProjectID = @ProjectID
		
	END
	ELSE
	BEGIN
		SET @WhatIsError = 'Project does not exist'
	END

	SELECT	CASE @WhatIsError 
				WHEN '' THEN 'true' 
				ELSE 'false' 
			END as Success, @WhatIsError as Error
    
END
GO
