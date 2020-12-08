use FPnA
go
create table cus_mytest (col1 int)
use HIS_DW
go
create table cus_mytest (col1 int,col2 int)
select * from HIS_DW..cus_mytest
use FPnA
go

DECLARE @MyTable sysname
set @MyTable = 'cus_mytest'
DECLARE @COLTOADD sysname
DECLARE @COLDataType varchar(255)
DECLARE cusNewCol CURSOR FAST_FORWARD LOCAL FOR
        SELECT 
	--otherSystem.TABLE_NAME, 
	otherSystem.COLUMN_NAME,
	otherSystem.DATA_TYPE
	 
	FROM [NS]..INFORMATION_SCHEMA.COLUMNS otherSystem
    --FROM [SQL-instancename].[QTS_DEV1].INFORMATION_SCHEMA.COLUMNS otherSystem --linked server name and info schema object format
    WHERE 1= 1 and
        otherSystem.TABLE_NAME = @MyTable
		and otherSystem.COLUMN_NAME not in 
		(
		SELECT 
		mysystem.COLUMN_NAME	 
		FROM [NS]..INFORMATION_SCHEMA.COLUMNS mysystem

		)
OPEN cusNewCol
    FETCH NEXT FROM cusNewCol INTO @COLTOADD,@COLDataType
  WHILE (@@fetch_status<>-1)
  BEGIN
	EXEC ('alter table ' +  @MyTable + ' add ' + @COLTOADD + ' ' + @COLDataType)
    
    FETCH NEXT FROM cusNewCol INTO @COLTOADD,@COLDataType
END
CLOSE cusNewCol
DEALLOCATE cusNewCol
exec ('select * from ' + @MyTable)



use FPnA
go
Drop table cus_mytest

use HIS_DW
go
Drop table cus_mytest



DECLARE @MyTable sysname
set @MyTable = 'cus_mytest'
DECLARE @COLTOADD sysname
DECLARE @COLDataType varchar(255)
DECLARE cusNewCol CURSOR FAST_FORWARD LOCAL FOR
        SELECT 
	--otherSystem.TABLE_NAME, 
	otherSystem.COLUMN_NAME,
	otherSystem.DATA_TYPE
	 
	FROM [NS].[Quatris Healthco].[Administrator].[CENTRICITY_INFO] otherSystem
    --FROM [SQL-instancename].[QTS_DEV1].INFORMATION_SCHEMA.COLUMNS otherSystem --linked server name and info schema object format
  --  WHERE 1= 1 and
  --      otherSystem.TABLE_NAME = @MyTable
		--and otherSystem.COLUMN_NAME not in 
		--(
		--SELECT 
		--mysystem.COLUMN_NAME	 
		--FROM [NS]..INFORMATION_SCHEMA.COLUMNS mysystem

		--)
OPEN cusNewCol
    FETCH NEXT FROM cusNewCol INTO @COLTOADD,@COLDataType
  WHILE (@@fetch_status<>-1)
  BEGIN
	EXEC ('alter table ' +  @MyTable + ' add ' + @COLTOADD + ' ' + @COLDataType)
    
    FETCH NEXT FROM cusNewCol INTO @COLTOADD,@COLDataType
END
CLOSE cusNewCol
DEALLOCATE cusNewCol
exec ('select * from ' + @MyTable)
