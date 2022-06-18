/****** Object:  UserDefinedFunction [dbo].[fn_get_hash_fields]    Script Date: 6/18/2022 12:33:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--get hash fields from a table to generate record hash value with related SProc , ignoring create/update dates and hashkey field itself, ignore clob/blob data
/* 2021-05-13  (BS) update decimal hash value to include numeric_scale */


CREATE FUNCTION [dbo].[fn_get_hash_fields] (@p_table_name 
VARCHAR(100),@p_schema_name VARCHAR(20))
RETURNS VARCHAR(MAX)
AS
BEGIN
DECLARE @szSqlString AS VARCHAR(MAX)
SET @szSqlString = ''    
      SELECT @szSqlString = @szSqlString +
            CASE DATA_TYPE 
                    WHEN 'int'           THEN 'ISNULL(RTRIM(CONVERT(varchar(10),[' + COLUMN_NAME + '])),'''')'
                    WHEN 'tinyint'       THEN 'ISNULL(RTRIM(CONVERT(varchar(10),[' + COLUMN_NAME + '])),'''')'
                    WHEN 'smallint'      THEN 'ISNULL(RTRIM(CONVERT(varchar(10),[' + COLUMN_NAME + '])),'''')'
                    WHEN 'bigint'        THEN 'ISNULL(RTRIM(CONVERT(varchar(10),[' + COLUMN_NAME + '],112)),'''')'  
                    WHEN 'datetime2'     THEN 'ISNULL(RTRIM(CONVERT(varchar(10),[' + COLUMN_NAME + '])),'''')'
                    WHEN 'datetime'      THEN 'ISNULL(RTRIM(CONVERT(varchar(10),[' + COLUMN_NAME + '],112)),'''')'
                    WHEN 'smalldatetime' THEN 'ISNULL(RTRIM(CONVERT(varchar(10),[' + COLUMN_NAME + '],112)),'''')'
                    WHEN 'date'          THEN 'ISNULL(RTRIM(CONVERT(varchar(10),[' + COLUMN_NAME + '],112)),'''')' 
                    WHEN 'bit'           THEN 'ISNULL(RTRIM(CONVERT(varchar(1),[' + COLUMN_NAME + '])),'''')'  
                    WHEN 'decimal'       THEN 'ISNULL(RTRIM(CONVERT(varchar('+ CONVERT(VARCHAR(2),NUMERIC_PRECISION + NUMERIC_SCALE + 1) + '),[' + COLUMN_NAME + '])),'''')' 
                    WHEN 'numeric'       THEN 'ISNULL(RTRIM(CONVERT(varchar('+ CONVERT(VARCHAR(2),NUMERIC_PRECISION + NUMERIC_SCALE + 1) + '),[' + COLUMN_NAME + '])),'''')' 
                    ELSE                      'ISNULL(RTRIM([' + COLUMN_NAME + ']),'''')'
                 END + '+'
            FROM   INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_SCHEMA = @p_schema_name 
            AND TABLE_NAME = @p_table_name                
            AND (COLUMN_NAME NOT IN ('HASHKEY','ETL_Load_Date_Time','DateCreation','LastDateUpdateFromLegacy','LastDateUpdateFromProcess'))
            AND [DATA_TYPE] NOT IN ( 'TEXT', 'IMAGE')

    RETURN LEFT(ISNULL(@szSqlString, ''),LEN(@szSqlString)-1)
END  



GO


