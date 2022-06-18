/****** Object:  StoredProcedure [dbo].[USP_TruncateAllTablesInSchema]    Script Date: 1/26/2022 9:11:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***********************************************
*                                              *
* Created by Benjamin Smith  2021-08-26        *
* Truncate all tables in dbo schema            *
***********************************************/

ALTER PROCEDURE [dbo].[USP_TruncateAllTablesInSchema]
    @schema NVARCHAR(50)

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
	SET @schema = 'dbo'
    DECLARE @table NVARCHAR(255)

    DECLARE db_cursor CURSOR FOR 
        SELECT t.name
          FROM sys.tables t INNER JOIN
               sys.schemas s ON 
                    t.schema_id=s.schema_id
         WHERE s.name=@schema
         ORDER BY 1

    OPEN db_cursor   

    FETCH NEXT FROM db_cursor INTO @table   

    WHILE @@FETCH_STATUS = 0   
    BEGIN   
           DECLARE @sql NVARCHAR(1000)

           SET @sql = 'truncate table [' + @schema + '].[' + @table + ']'

           EXEC sp_sqlexec @sql

           FETCH NEXT FROM db_cursor INTO @table   
    END   

    CLOSE db_cursor   
    DEALLOCATE db_cursor 

END
GO


