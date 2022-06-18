/****** Object:  UserDefinedFunction [dbo].[RemoveNonASCII]    Script Date: 6/18/2022 12:33:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--remove non ascii characters
CREATE FUNCTION [dbo].[RemoveNonASCII] 
(
    @in_string NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
 
    DECLARE @Result NVARCHAR(MAX)
    SET @Result = ''
 
    DECLARE @character NVARCHAR(1)
    DECLARE @index INT
 
    SET @index = 1
    WHILE @index <= LEN(@in_string)
    BEGIN
        SET @character = SUBSTRING(@in_string, @index, 1)
   
        IF (UNICODE(@character) BETWEEN 32 AND 127) OR UNICODE(@character) IN (10,11)
            SET @Result = @Result + @character
        SET @index = @index + 1
    END
 
    RETURN @Result
END
GO


