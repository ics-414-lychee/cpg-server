USE [LycheeActivityOnNode414]
GO
/****** Object:  StoredProcedure [dbo].[DeleteProject_Proc]    Script Date: 11/17/2017 2:53:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 10/29/2017
-- Description:	Deletes projects. Only the owner may delete the project
-- =============================================
CREATE PROCEDURE [dbo].[DeleteProject_Proc]
	@Username varchar(50),	--Owner
	@ProjectID bigint		--Project ID to delete
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @WhatIsError as varchar(200) = ''

	--If project exists where the project is the owner, we can successfully do deletion. Otherwise, we need to tell the front that the project doesnt exist
	IF EXISTS(SELECT TOP 1 ProjectID FROM ProjectTbl WHERE ProjectOwner = @Username AND ProjectID = @ProjectID)
	BEGIN
		DELETE FROM ProjectTbl WHERE ProjectOwner = @Username AND ProjectID = @ProjectID
		DELETE FROM UserAddedToProjectsTbl WHERE ProjectID = @ProjectID
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT TOP 1 ProjectID FROM ProjectTbl WHERE ProjectID = @ProjectID)
		BEGIN
			SET @WhatIsError = 'Only the project owner can delete this project'
		END
		ELSE
		BEGIN
			SET @WhatIsError = 'User or project does not exist'
		END
	END

	SELECT	CASE @WhatIsError 
				WHEN '' THEN 'true' 
				ELSE 'false' 
			END as Success, @WhatIsError as Error

END
GO
