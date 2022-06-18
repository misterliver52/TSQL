/****** Object:  UserDefinedFunction [dbo].[RemoveSpecialChar]    Script Date: 6/18/2022 12:33:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--remove special characters

CREATE FUNCTION [dbo].[RemoveSpecialChar]
(
    @s VARCHAR(256)
)
RETURNS VARCHAR(256)
WITH SCHEMABINDING
BEGIN
    IF @s IS NULL
        RETURN NULL;
    DECLARE @s2 VARCHAR(256) = '',
            @l INT = LEN(@s),
            @p INT = 1;

    WHILE @p <= @l
    BEGIN
        DECLARE @c INT;
        SET @c = ASCII(SUBSTRING(@s, @p, 1));
        IF @c
           BETWEEN 48 AND 57
           OR @c
           BETWEEN 65 AND 90
           OR @c
           BETWEEN 97 AND 122
            SET @s2 = @s2 + CHAR(@c);
        SET @p = @p + 1;
    END;

    IF LEN(@s2) = 0
        RETURN NULL;
    RETURN LOWER(@s2);
END;

GO


