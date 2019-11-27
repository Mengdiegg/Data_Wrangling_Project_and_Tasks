library("RODBC")
library(dplyr)

myconn <- odbcConnect("qbs181","mge","mge@qbs181")


#Q1.	Create a new column "Enrollment group" 

new_phonecall <- sqlQuery(myconn, "select * into mge.phonecall from dbo.Phonecall")

new_phonecall <- sqlQuery(myconn, "SELECT A.*, B.EncounterCode into [mge].phonecallhw from mge.phonecall A
left join [dbo].PhoneCall_Encounter B
on A.tri_CustomerIDEntityReference = B.CustomerId")


result_Q1 <- sqlQuery(myconn, "alter table mge.phonecallhw add Enrollment_group VARCHAR(255);

update mge.phonecallhw set Enrollment_group='Clinical Alert' where [EncounterCode]='125060000';
update mge.phonecallhw set Enrollment_group='Health Coaching' where [EncounterCode]='125060001';
update mge.phonecallhw set Enrollment_group='Technixal Question' where [EncounterCode]='125060002';
update mge.phonecallhw set Enrollment_group='Administrative' where [EncounterCode]='125060003';
update mge.phonecallhw set Enrollment_group='Other' where [EncounterCode]='125060004';
update mge.phonecallhw set Enrollment_group='Lack of engagement' where [EncounterCode]='125060005';")

result_show <- sqlQuery(myconn, "select Top 10 * FROM mge.phonecallhw")

#Q2
result_Q2 <- sqlQuery(myconn, "select Enrollment_group, count(*) as 'Number' 
from mge.phonecallhw
group by Enrollment_group")

#Q3
calljoint <- sqlQuery(myconn, "select A.*, B.* into mge.calljoint from dbo.PhoneCall_Encounter A
inner join 
dbo.CallDuration B
on A.CustomerId = B.tri_CustomerIDEntityReference")

result_Q3 <- sqlQuery(myconn, "select Top 10 * from mge.calljoint")

#Q4

call_counts <- sqlQuery(myconn, "select CallOutcome, count(*) as 'Number' 
into mge.callcounts 
from mge.calljoint
group by CallOutcome;
select * from mge.callcounts
alter table mge.callcounts add Call_Outcome varchar(255)
update mge.callcounts set Call_Outcome='No response' where [CallOutcome]= 1
update mge.callcounts set Call_Outcome='Left voice mail' where [CallOutcome]= 2
update mge.callcounts set Call_Outcome='successful' where [CallOutcome]= 3")

result_Q4_1 <- sqlQuery(myconn, "select Top 10 * from [mge].callcounts")


call_joint <- sqlQuery(myconn, "select CallType, count(*) as 'Number' 
into mge.typecounts
from mge.calljoint
group by CallType;
select * from mge.typecounts
alter table mge.typecounts add Call_Type varchar(255)
update mge.typecounts set Call_Type='Inbound' where [CallType]= 1
update mge.typecounts set Call_Type='Outbound' where [CallType]= 2")

result_Q4_2 <- sqlQuery(myconn, "select Top 10 * from [mge].calljoint")

update_call_joint <- sqlQuery(myconn, "alter table mge.calljoint add Enrollment_group VARCHAR(255)
update mge.calljoint set Enrollment_group='Clinical Alert' where [EncounterCode]='125060000';
update mge.calljoint set Enrollment_group='Health Coaching' where [EncounterCode]='125060001';
update mge.calljoint set Enrollment_group='Technixal Question' where [EncounterCode]='125060002';
update mge.calljoint set Enrollment_group='Administrative' where [EncounterCode]='125060003';
update mge.calljoint set Enrollment_group='Other' where [EncounterCode]='125060004';
update mge.calljoint set Enrollment_group='Lack of engagement' where [EncounterCode]='125060005';")

result_Q4_3 <- sqlQuery(myconn, "select Enrollment_group, sum(cast(CallDuration as int)) as 'Total Duration'
from mge.calljoint
group by Enrollment_group
order by Enrollment_group;")

#Q5
mergetable <- sqlQuery(myconn, "select A.*, B.*, C.* into [mge].mergetables from [dbo].TextMessages A 
left join [dbo].Conditions B
on A.tri_contactId = B.tri_patientid
left join [dbo].Demographics C
on A.tri_contactId = C.contactid
")

mergetable <- sqlQuery(myconn, "select * from [mge].mergetables")

Addweeks <- sqlQuery(myconn, "Alter Table [mge].mergetables
add weeks NVARCHAR(255)
update [mge].mergetables
set weeks = Datepart(wk, TextSentDate) ")

groupby_nw <- sqlQuery(myconn, "SELECT SenderName as Sender, count(weeks) as week_number_System, weeks as weeks into [mge].HW2_Q5
from [mge].mergetables
Group BY SenderName, weeks
ORDER BY Sender, weeks
")

result_Q5 <- sqlQuery(myconn, "select Top 10 * from [mge].HW2_Q5")

install.packages("ggplot2")
library(ggplot2)

result_Q5 %>%
  group_by(Sender) %>%
  ggplot(., aes(x = weeks, y = week_number_System, color = Sender)) + geom_line() + theme_minimal()


#Q6
chronic_text <-sqlQuery(myconn, "select A.*, B.tri_name into [mge].chronic_text_2 from [dbo].TextMessages A 
left join [dbo].Conditions B 
on A.tri_contactId = B.tri_patientid
where B.tri_name = 'COPD';
")

update_chronic <- sqlQuery(myconn, "Alter Table [mge].chronic_text_2
add weeks NVARCHAR(255)
update [mge].chronic_text_2
set weeks = Datepart(wk, TextSentDate) ")

temp <- sqlQuery(myconn, "select weeks, count(weeks) as 'number_text'
into mge.HW2_Q6
from mge.chronic_text_2
group by weeks
ORDER by weeks")

result_Q6 <- sqlQuery(myconn, "SELECT * from mge.HW2_Q6")

result_Q6 %>%
  ggplot(., aes(x = weeks, y = number_text)) + geom_line() + theme_minimal()




