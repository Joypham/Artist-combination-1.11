* Xac dinh qua nguon allmusic:
UPDATE artist_combination_joy_06082019
JOIN (
Select 
artist_combination_joy_06082019.uuid,
artist_combination_joy_06082019.Combination_name
artist_combination_joy_06082019.Info,
allmusicartistinfo.id,
cast (CONCAT('{"source_allmusic": "',allmusicartistinfo.id,'"}') as Json) as Joy
from artist_combination_joy_06082019
Join allmusicartistinfo on artist_combination_joy_06082019.Combination_name = allmusicartistinfo.name
where artist_combination_joy_06082019.joy_checking is NULL

) as t1
on t1.uuid = artist_combination_joy_06082019.uuid
set
artist_combination_joy_06082019.joy_checking = JSON_SET(IFNULL(artist_combination_joy_06082019.joy_checking, JSON_OBJECT()),'$.groupname',t1.joy)

* Xac dinh qua nguon wiki

UPDATE artist_combination_joy_06082019
JOIN (

Select * from (Select 
uuid,
Combination_name,
REPLACE(info -> '$.wiki.brief','&amp;',',') as wiki, 
cast (
CONCAT('{"wiki": ',info -> '$.wiki_url','}') as Json) as wikiurl,
joy_checking
from artist_combination_joy_06082019
where
joy_checking is null
and 
info -> '$.wiki.brief' is not null
and
info -> '$.wiki.brief' not like '%null%') as t1
where 
t1.wiki like CONCAT('"',t1.Combination_name,'%')
) as t2
on t2.uuid = artist_combination_joy_06082019.uuid and artist_combination_joy_06082019.joy_checking is null
set 
artist_combination_joy_06082019.joy_checking= JSON_SET(IFNULL(artist_combination_joy_06082019.joy_checking, JSON_OBJECT()),'$.groupname',t2.wikiurl)
