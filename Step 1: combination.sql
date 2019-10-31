TRUNCATE TABLE artist_combination_joy_06082019;
INSERT into `artist_combination_joy_06082019` (id,uuid,valid,CreatedAt,UpdatedAt,Combination_name,Info,Ext)
SELECT
	id,
	uuid,
	Valid,
	CreatedAt,
	UpdatedAt,
	`Name`,
	Info,
	ext
FROM
	artists 
WHERE
	Valid > 0 
	AND (
		NAME LIKE '%&%' 
		OR NAME LIKE '%+%' 
		OR NAME LIKE '%,%' 
		OR NAME LIKE '%ft.%' 
		OR NAME LIKE '% feat %' 
		OR NAME LIKE '% and %' 
		OR NAME LIKE '%(%' 
		OR NAME LIKE '% x %' 
		OR NAME LIKE '% duet %' 
		OR NAME LIKE '%;%'
		OR NAME LIKE '% with %'
		OR NAME LIKE '%/%'
		OR NAME LIKE '% prod.%' 
		OR NAME LIKE '% Y %'
		OR NAME LIKE '%featuring%' 
		OR NAME LIKE '% vs %'
)
