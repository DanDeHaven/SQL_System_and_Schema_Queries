USE HIS_DM
GO

SELECT 
	OBJECT_SCHEMA_NAME(v.object_id) schema_name,
	v.name
FROM 
	sys.views as v;