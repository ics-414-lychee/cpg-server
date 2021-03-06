USE [LycheeActivityOnNode414]
GO
/****** Object:  StoredProcedure [dbo].[UserLoginOrCreate_Proc]    Script Date: 11/17/2017 2:53:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 10/29/2017
-- Description:	Verifies a user login or creates a new login depending on @Action parameter
--		If the Action is 1, a Username can only be inserted into the table if the username does not exist
-- =============================================
CREATE PROCEDURE [dbo].[UserLoginOrCreate_Proc]
	@Username	varchar(50),
	@Password	varchar(60),
	@Salt		varchar(22), --Only used when @Action is 1
	@Action		bit --0 refers to login, 1 refers to create
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Error message that returns something when an error occurs
	DECLARE @WhatIsError varchar(200) = ''
	DECLARE @Auth as varchar(40)

	--Generate new AuthToken
	SET @Auth = (
	SELECT
		c1 AS [text()]
	FROM
		(
			SELECT TOP (40) c1
			FROM
			(
				VALUES
					('A'), ('B'), ('C'), ('D'), ('E'), ('F'), ('G'), ('H'), ('I'), ('J'),
					('K'), ('L'), ('M'), ('N'), ('O'), ('P'), ('Q'), ('R'), ('S'), ('T'),
					('U'), ('V'), ('W'), ('X'), ('Y'), ('Z'), ('0'), ('1'), ('2'), ('3'),
					('4'), ('5'), ('6'), ('7'), ('8'), ('9'), ('#'), ('$'), ('!'), ('@'), 
					('%'), ('^'), ('*')
			) AS T1(c1)
			ORDER BY ABS(CHECKSUM(NEWID()))
		) AS T2
	FOR XML PATH('')
	)

	IF @Action = 1
	BEGIN
		IF EXISTS(SELECT TOP 1 Username FROM UserTbl WHERE Username = @Username)
		BEGIN
			SET @WhatIsError = 'Username already exists'
		END
		ELSE
		BEGIN
			INSERT INTO UserTbl (
				Username,
				[Password],
				Salt
			)
			VALUES (@Username, @Password, @Salt)

			INSERT INTO UserAuthenticationTbl (
				Username,
				Authtoken,
				LastTimeUsed
			)
			VALUES(@Username, @Auth, GETDATE()) --Date always overridden on successful login anyway

		END
	END
	ELSE
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 Username FROM UserTbl WHERE Username = @Username AND [Password] = @Password)
		BEGIN
			SET @WhatIsError = 'Incorrect username or password'
		END
		ELSE
		BEGIN
			--Succcessful login
			UPDATE UserAuthenticationTbl 
			SET Authtoken = @Auth,
				LastTimeUsed = GETDATE()
			WHERE
				Username = @Username

		END
	END

	SELECT	CASE @WhatIsError 
				WHEN '' THEN 'true' 
				ELSE 'false' 
			END as Success, @WhatIsError as Error, @Auth as Authtoken

END
GO
