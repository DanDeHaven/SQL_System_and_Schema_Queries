USE NetSuite_ETL_Staging
GO

	IF Object_id('Accounts_Step_01') > 0
		DROP TABLE Accounts_Step_01;


SELECT TOP 1
	*
INTO
	NetSuite_ETL_Staging..Accounts_Step_01
FROM
	[NS].[Quatris Healthco].[QH Data Integration].[Accounts]


SELECT 
    c.name 'Column Name',
    t.Name 'Data type',
    c.max_length 'Max Length',
    c.precision ,
    c.scale ,
    c.is_nullable,
    ISNULL(i.is_primary_key, 0) 'Primary Key'
INTO
	Transaction_Lines_Step_02
FROM    
    sys.columns c
INNER JOIN 
    sys.types t ON c.user_type_id = t.user_type_id
LEFT OUTER JOIN 
    sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
LEFT OUTER JOIN 
    sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
WHERE
    c.object_id = OBJECT_ID('Accounts_Step_01')
	AND c.max_length <> 8000
	AND t.name <> 'ntext'

SELECT
	*
FROM
	Transaction_Lines_Step_02

EXEC sp_describe_first_result_set N'SELECT * FROM [Transaction_Lines_Step_01]'

EXEC sp_describe_first_result_set N'SELECT * FROM [NS].[Quatris Healthco].[QH Data Integration].[TRASACTION_LINES]'