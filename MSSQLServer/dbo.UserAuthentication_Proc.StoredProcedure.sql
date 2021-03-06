USE [LycheeActivityOnNode414]
GO
/****** Object:  StoredProcedure [dbo].[UserAuthentication_Proc]    Script Date: 11/17/2017 2:53:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 11/4/2017
-- Description:	Checks if the user is authorized
-- =============================================
CREATE PROCEDURE [dbo].[UserAuthentication_Proc]
	@Username varchar(50),		--User to atuhenticate
	@Authtoken varchar(40)		--Project ID to delete
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @WhatIsError as varchar(200) = ''

	IF EXISTS(SELECT TOP 1 Username FROM UserAuthenticationTbl WHERE Username = @Username AND Authtoken = @Authtoken)
	BEGIN
		UPDATE UserAuthenticationTbl
		SET LastTimeUsed = GETDATE()
		WHERE Username = @Username AND Authtoken = @Authtoken
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT TOP 1 Username FROM UserAuthenticationTbl WHERE Username = @Username)
		BEGIN
			--Authtoken is invalid
			SET @WhatIsError = 'Please re-login'
		END
		ELSE
		BEGIN
			--User does not exist
			SET @WhatIsError = 'Username does not exist'
		END
	END

	SELECT	CASE @WhatIsError 
				WHEN '' THEN 'true' 
				ELSE 'false' 
			END as Success, @WhatIsError as Error

END
GO
