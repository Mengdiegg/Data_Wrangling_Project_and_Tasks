# Data_Wrangling_Project_and_Tasks/Project 1
For project 1,  I completed four main tasks as follows: 
1.	 Rename all the columns for eg.,
a)	TriAge to Age
b)	GenderCode to Gender
c)	ContactID to ID
d)	Address1Stateorprovince to State
e)	TriImagineCareenrollmentemailsentdate to EmailSentdate
f)	Trienrollmentcompletedate to Completedate
g)	Calculate the time (in days) to complete enrollment and create a new column to have this data



2.	Create a new column “Enrollment Status”
a)	Insert Status=Complete :code is 167410011
b)	Insert Status=Email sent :code is 167410001
c)	Insert Status=Non responder: Code is 167410004
d)	Insert Status=Facilitated Enrollment: Code  is 167410005
e)	Insert Status= Incomplete Enrollments: Code  is 167410002
f)	Insert Status= Opted Out: Code  is 167410003
g)	Insert Status= Unprocessed: Code  is 167410000
h)	Insert Status= Second email sent : Code  is 167410006

3.	Create a new Column “Sex”
a)	Insert sex=female if code=2
b)	Insert sex=male if code=1
c)	Insert sex=other if code =167410000
d)	Insert sex=Unknown if code =’NULL’

4.	Create a new column “Age group” and create age groups with an interval of 25 yrs. for example 0-25 years as ‘0-25’, 26-50 as “26-50” and so on...
