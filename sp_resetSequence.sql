/****** Object:  StoredProcedure [dbo].[USP_ResetMCSequence]    Script Date: 6/18/2022 12:31:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--reset a sequence  (needs update for sequence,table and field names (need to parameterize))
CREATE PROCEDURE [dbo].[USP_ResetMCSequence] 
AS
DECLARE @MCSeq INT =0;
DECLARE @seq NVARCHAR(4000);
BEGIN

SET @MCSeq = (SELECT CAST(SUBSTRING(MAX(ContractNumber),4,6) AS INT) FROM dbo.Dim_MasterContract);
IF OBJECT_ID('MCSequence') IS NOT NULL
DROP SEQUENCE [dbo].[MCSequence]

SET @seq = N'
CREATE SEQUENCE [dbo].[MCSequence] AS INT
	START WITH ' + CAST(@MCSeq+1 AS NVARCHAR) + '
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999
	CACHE;'

EXEC(@seq);

END
GO


