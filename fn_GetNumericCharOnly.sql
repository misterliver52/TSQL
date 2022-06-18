/****** Object:  UserDefinedFunction [dbo].[udfGetOnlyNumeric]    Script Date: 6/18/2022 12:33:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--return only numeric characters from string

CREATE  FUNCTION [dbo].[udfGetOnlyNumeric](
@String NVARCHAR(100)
)
RETURNS NVARCHAR(100)
WITH SCHEMABINDING
AS  BEGIN
-- Remove non-digit characters 
WHILE PATINDEX('%[^0-9]%', @String) > 0  
SET @String = REPLACE(@String, SUBSTRING(@String,PATINDEX('%[^0-9]%', @String),1),'') 

RETURN @String
END

GO


