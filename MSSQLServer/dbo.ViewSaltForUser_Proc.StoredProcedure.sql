USE [LycheeActivityOnNode414]
GO
/****** Object:  StoredProcedure [dbo].[ViewSaltForUser_Proc]    Script Date: 11/17/2017 2:53:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 11/4/2017
-- Description:	Returns the user's salt to middle end. Need this for hashing correctly
-- =============================================
CREATE PROCEDURE [dbo].[ViewSaltForUser_Proc]
	@Username as varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @WhatIsError as varchar(200) = ''
	DECLARE @Salt as varchar(22) = ''

	IF EXISTS(SELECT TOP 1 Salt FROM UserTbl WHERE Username=@Username)
	BEGIN
		SELECT @Salt = Salt FROM UserTbl WHERE Username = @Username
	END
	ELSE
	BEGIN
		SET @WhatIsError = 'Incorrect username or password'
	END

	SELECT	CASE @WhatIsError 
				WHEN '' THEN 'true' 
				ELSE 'false' 
			END as Success, @WhatIsError as Error, @Salt as Salt

END
GO
