* Jr not combination
Step 1: filter

Select * from (
Select UUID,Combination_name,REPLACE(REPLACE (Combination_name,', Jr','###'),',Jr','###') as a from artist_combination_joy_06082019
where 
Combination_name like '%, Jr%'
or
Combination_name like '%,Jr%'
and 
joy_checking is null
) as t1
where 
(
a not like '%&%' and
a not like '%+%' and
a not like '%,%' and
a not like '%ft.%' and 
a not like '% feat %' and
a not like '% and %' and
a not like '%(%' and
a not like '% x %' and 
a not like '% duet %' and
a not like '%;%' and 
a not like '% with %' and 
a not like '%/%' and
a not like '% prod.%' and
a not like '% Y %' and
a not like '%featuring%' and 
a not like '% vs %')

Step 2: Update list tren
Update artist_combination_joy_06082019 set joy_checking ='{"groupname": "Jr"}'where uuid = "AE34177F51CE4CEABE68283B4FF83763";

* Con lai Jr combination in combination
