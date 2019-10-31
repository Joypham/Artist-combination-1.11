* total list
with t1 as (
select uuid, Combination_name from artist_combination_joy_06082019
where joy_checking is null),
t2 as (
select uuid as uuid_band, Combination_name as Combination_name_band from artist_combination_joy_06082019
where joy_checking is not null)
Select * from t1
Join t2 on t1.Combination_name like CONCAT ('%',t2.Combination_name_band,'%')
ORDER BY t1.Combination_name
