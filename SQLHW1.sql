#Q1
SELECT * into [mge].HW1_181 from Demographics
exec sp_rename 'mge.HW1_181.tri_age','Age','column'
alter table [mge].HW1_181
drop column gender
exec sp_rename 'mge.HW1_181.gendercode','Gender','column'
exec sp_rename 'mge.HW1_181.contactid','ID','column'
exec sp_rename 'mge.HW1_181.address1_stateorprovince','State','column'
exec sp_rename 'mge.HW1_181.tri_imaginecareenrollmentemailsentdate','EmailSentdate','column'
exec sp_rename 'mge.HW1_181.tri_enrollmentcompletedate','Completedate','column'
SELECT * from [mge].HW1_181

#Q1.g
ALTER TABLE [mge].HW1_181
add completeperiod NVARCHAR(255)

UPDATE [mge].HW1_181
SET completeperiod = DATEDIFF(DAY,  try_convert(date, EmailSentdate, 101), try_convert(date, Completedate, 101))
SELECT Top 10 * from [mge].HW1_181
WHERE completeperiod != 'Null'



#Q2
ALTER TABLE [mge].HW1_181
add Enrollment_Status NVARCHAR(255)

update [mge].HW1_181
set Enrollment_Status = 
    (CASE
    WHEN tri_imaginecareenrollmentstatus = '167410011' THEN 'Complete'
    WHEN tri_imaginecareenrollmentstatus = '167410001' THEN 'Email sent'
    WHEN tri_imaginecareenrollmentstatus = '167410004' THEN 'Non responder'
    WHEN tri_imaginecareenrollmentstatus = '167410005' THEN 'Facilitated Enrollment'
    WHEN tri_imaginecareenrollmentstatus = '167410002' THEN 'Incomplete Enrollment'
    WHEN tri_imaginecareenrollmentstatus = '167410003' THEN 'Opted Out'
    WHEN tri_imaginecareenrollmentstatus = '167410000' THEN 'Unprocessed'
    WHEN tri_imaginecareenrollmentstatus = '167410006' THEN 'Second email sent'
    else NULL
    END)
    
SELECT Top 10 * from [mge].HW1_181
WHERE tri_imaginecareenrollmentstatus = '167410006'

Q3
ALTER TABLE [mge].HW1_181
add Sex NVARCHAR(255)

update [mge].HW1_181
set Sex = 
    (CASE
    WHEN Gender = '1' THEN 'male'
    WHEN Gender = '2' THEN 'female'
    WHEN Gender = '167410000' THEN 'other'
    WHEN Gender = 'NULL' THEN 'Unknown'
    END)
SELECT Top 10 * from [mge].HW1_181
WHERE Gender = '167410000'



#Q4
ALTER TABLE [mge].HW1_181
add Age_group NVARCHAR(255)

update [mge].HW1_181
set Age_group = 
    (CASE
    WHEN Age <= '25' THEN '0-25'
    WHEN Age > '25' and Age <= '50' THEN '26-50'
    WHEN Age > '50' and Age <= '75' THEN '51-75'
    WHEN Age > '75' THEN '>75'
    END)
SELECT Top 10 * from [mge].HW1_181
