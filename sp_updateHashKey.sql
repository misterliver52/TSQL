/****** Object:  StoredProcedure [dbo].[USP_UpdateHashKey]    Script Date: 6/18/2022 12:48:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--call fn_GetHashFields  to generate hashkey in table
CREATE PROCEDURE [dbo].[USP_UpdateHashKey] (@p_table_name 
VARCHAR(100),@p_schema_name VARCHAR(20))
AS 
BEGIN

DECLARE @hashFields NVARCHAR(MAX)
SET @hashFields = (SELECT [dbo].[fn_gethashfields](@p_table_name,@p_schema_name))

DECLARE @sql NVARCHAR(MAX) 
SET @sql = 'Update ' +@p_schema_name+'.'+@p_table_name + ' Set HashKey = HASHBYTES(''MD5'',' +@hashFields +')' 

EXEC (@sql)	

END
GO


