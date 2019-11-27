drop table mge.final_file
drop table mge.final_version
drop table mge.final_Q2

SELECT * into mge.final_version from mge.IC_BP_v2

SELECT * from mge.final_version
EXEC sp_rename 'mge.final_version.BPAlerts', 'BPStatus'

SELECT Top 10.* from mge.final_version

alter table mge.final_version 
add blood_pressure_level VARCHAR(255)

update mge.final_version
set blood_pressure_level = 
    (CASE
    WHEN BPStatus = 'Hypo1' THEN '1'
    WHEN BPStatus = 'Normal' THEN '1'
    WHEN BPStatus = 'Hypo2'  THEN '0'
    WHEN BPStatus = 'HTN1'  THEN '0'
    WHEN BPStatus = 'HTN2'  THEN '0'
    WHEN BPStatus = 'HTN3'  THEN '0'
    else NULL
    END)
    
 SELECT Top 10.* from mge.final_version
    
  SELECT A.*, B.* into mge.final_file from mge.final_version A
  inner join 
  dbo.Demographics B
  on A.ID = B.contactid
  
  SELECT Top 10.* from mge.final_file
  
  alter table mge.final_file
  add week_count VARCHAR(255)
  
  UPDATE mge.final_file
  SET week_count = datediff(week, TRY_CONVERT(date,tri_enrollmentcompletedate), ObservedTime)
  
  select Top 10.A.* from(
  select ID, avg(TRY_CONVERT(float, blood_pressure_level)) as score, week_count 
  from mge.final_file
  where week_count <= 12 and week_count > 0
  group by ID, week_count)A
  
  select Top 10.T.* from(
  select (C.B_score-C.score) as diff_score from
  (select A.ID, A.score, B.score as B_score, A.week_count as former_count, B.week_count as later_count from
  (select ID, avg(TRY_CONVERT(float, blood_pressure_level)) as score, week_count 
  from mge.final_file
  where week_count <= 12 and week_count > 0
  group by ID, week_count)A
  left join 
  (select ID, avg(TRY_CONVERT(float, blood_pressure_level)) as score, week_count 
  from mge.final_file
  where week_count <= 12 and week_count > 0
  group by ID, week_count)B
  on A.id = B.id 
  where A.week_count = 1)C
  where C.later_count = 12)T
  
  select T.* from(
  select D.diff_score from
  (select (C.B_score-C.score) as diff_score from
  (select A.ID, A.score, B.score as B_score, A.week_count as former_count, B.week_count as later_count from
  (select ID, avg(TRY_CONVERT(float, blood_pressure_level)) as score, week_count 
  from mge.final_file
  where week_count <= 12 and week_count > 0
  group by ID, week_count)A
  left join 
  (select ID, avg(TRY_CONVERT(float, blood_pressure_level)) as score, week_count 
  from mge.final_file
  where week_count <= 12 and week_count > 0
  group by ID, week_count)B
  on A.id = B.id 
  where A.week_count = 1)C
  where C.later_count = 12)D
  where D.diff_score = 0)T

  
  select * into mge.final_Q2
  from
  (select A.*, B.*, C.* from dbo.Demographics A 
  inner join 
  dbo.Conditions B 
  on A.contactid = B.tri_patientid
  inner join 
  dbo.TextMessages C 
  on A.contactid = C.tri_contactid)T_2
  inner join
  (select T.contactid as T_contactid, max(T.TextSentDate)as latest_date from
  (select A.*, B.*, C.* from dbo.Demographics A 
  inner join 
  dbo.Conditions B 
  on A.contactid = B.tri_patientid
  inner join 
  dbo.TextMessages C 
  on A.contactid = C.tri_contactid)T
  group by T.contactid)T_1
  on 
  T_2.contactid = T_1.T_contactid and T_2.TextSentDate = T_1.latest_date

  ALTER TABLE mge.final_Q2
  drop column T_contactid,TextSentDate
  
  select Top 10.* from mge.final_Q2
 
  
  
  
  
  