USE [LycheeActivityOnNode414]
GO
/****** Object:  StoredProcedure [dbo].[ViewRandomGeneratedSalt_Proc]    Script Date: 11/17/2017 2:53:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Nishiguchi
-- Create date: 11/5/2017
-- Description:	Generates a random salt
-- =============================================
CREATE PROCEDURE [dbo].[ViewRandomGeneratedSalt_Proc]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Salt as varchar(22) = ''

	SET @Salt = (
	SELECT
		c1 AS [text()]
	FROM
		(
		SELECT TOP (22) c1
		FROM
			(
		VALUES
			('A'), ('B'), ('C'), ('D'), ('E'), ('F'), ('G'), ('H'), ('I'), ('J'),
			('K'), ('L'), ('M'), ('N'), ('O'), ('P'), ('Q'), ('R'), ('S'), ('T'),
			('U'), ('V'), ('W'), ('X'), ('Y'), ('Z'), ('0'), ('1'), ('2'), ('3'),
			('4'), ('5'), ('6'), ('7'), ('8'), ('9'), ('a'), ('b'), ('c'), ('d'),
			('e'), ('f'), ('g'), ('h'), ('i'), ('j'), ('k'), ('l'), ('m'), ('n'),
			('o'), ('p'), ('q'), ('r'), ('s'), ('t'), ('u'), ('v'), ('w'), ('x'),
			('y'), ('z')
			) AS T1(c1)
		ORDER BY ABS(CHECKSUM(NEWID()))
		) AS T2
	FOR XML PATH('')
	);

	SELECT @Salt as Salt

END
GO
