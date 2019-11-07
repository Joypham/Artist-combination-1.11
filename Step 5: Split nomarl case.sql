-- 2: 42.063
-- 3: 48.800
-- 4: 50.065
-- 5: 50.384
-- 6: 50.502

Select 
t4.*,
a.UUID as part1UUID,
b.UUID as part2UUID,
IF(t4.count > 1,c.UUID,'no_value') as part3UUID,
IF(t4.count > 2,d.UUID,'no_value') as part4UUID,
IF(t4.count > 3,e.UUID,'no_value') as part5UUID,
IF(t4.count > 4,f.UUID,'no_value') as part6UUID

from 
(
Select
t3.UUID,
t3.Combination_name,
t3.joy2,
t3.count,
trim(SUBSTRING_INDEX(t3.joy2,'###',1)) as part1,
trim(SUBSTRING_INDEX(SUBSTRING_INDEX(t3.joy2,'###',2),'###',-1)) as part2,
trim(if(count>1,SUBSTRING_INDEX(SUBSTRING_INDEX(t3.joy2,'###',3),'###',-1),'')) as part3,
trim(if(count>2,SUBSTRING_INDEX(SUBSTRING_INDEX(t3.joy2,'###',4),'###',-1),'')) as part4,
trim(if(count>3,SUBSTRING_INDEX(SUBSTRING_INDEX(t3.joy2,'###',5),'###',-1),'')) as part5,
trim(if(count>4,SUBSTRING_INDEX(SUBSTRING_INDEX(t3.joy2,'###',6),'###',-1),'')) as part6

from (
Select 
t2.*,
(LENGTH(joy2) - LENGTH(REPLACE(joy2,'###','')))/3 as count
from (
Select 
UUID,
Combination_name,
-- Joy2= combination_name_reformat
if(LEFT(joy,3) = '###',if(right (joy,3) = '\#\#\#',MID(joy,4,LENGTH(joy)-6),MID(joy,4,LENGTH(joy)-3)),if(RIGHT(joy,3) = '###',SUBSTRING_INDEX(joy,'###',(LENGTH(joy) - LENGTH(REPLACE(joy,'###','')))/3),joy)) as joy2
from (
SELECT
    uuid,
    Combination_name,
    trim(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(replace( REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(Combination_name),'&','###'),',','###'),'feat.','###'),' with ','###'),' vs. ','###'),'ft.','###'),'featuring','###'),'feat','###'),' and ','###'),' x ','###'),'prod.','###'),' vs ', '###'),' y ','###'),'+','###'),' duet ','###'),'(','###'),')','###'),'######','###'),'### ###','###'),'######','###'),'### ###','###')) as joy

FROM
    artist_combination_joy_06082019
WHERE
    joy_checking IS NULL
) as t1
) as t2
having 
(count > 0
and 
count < 6)

) as t3
) as t4
left join artists a on a.name = t4.part1 and a.valid > 0
left JOIN artists b on b.name = t4.part2 and b.valid > 0
left JOIN artists c on c.name = t4.part3 and c.valid > 0
left JOIN artists d on d.name = t4.part4 and d.valid > 0
left JOIN artists e on e.name = t4.part5 and e.valid > 0
left JOIN artists f on f.name = t4.part6 and f.valid > 0
group by t4.UUID
