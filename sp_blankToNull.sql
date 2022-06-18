/****** Object:  StoredProcedure [dbo].[USP_CRMBlankToNull]    Script Date: 6/18/2022 12:30:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--convert blanks to NULLS  (schema and table need to be parameterized)

CREATE PROCEDURE [dbo].[USP_CRMBlankToNull] AS
BEGIN
DECLARE @STMT AS NVARCHAR(MAX)
;

SELECT
		/*@STMT =*/ STRING_AGG(
							  CAST('UPDATE ' + TABLE_SCHEMA + '.' + TABLE_NAME
								   + ' SET [' + COLUMN_NAME + '] = NULLIF('
								   + COLUMN_NAME + ','''')' AS VARCHAR(MAX))
							, ';'
						  )
FROM	INFORMATION_SCHEMA.COLUMNS
WHERE
		TABLE_SCHEMA   = 'stg'
		AND (TABLE_NAME LIKE 'CRM%' OR TABLE_NAME LIKE 'CPQ%')
;


EXECUTE(@STMT)
;

END
GO


