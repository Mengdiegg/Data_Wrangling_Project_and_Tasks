# qbs181
There are four files include project1, project2, midterm_project, final_project.
I have been given the permission to make your work public

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
    

For project 2,  I completed six main tasks as follows:

1.	Create a new column “Enrollment group” in the table Phonecall
a)	Insert EnrollmentGroup=Clinical Alert :code is 125060000
b)	Insert EnrollmentGroup =Health Coaching :code is 125060001
c)	Insert EnrollmentGroup =Technixal Question: Code is 125060002
d)	Insert EnrollmentGroup =Administrative: Code  is 125060003
e)	Insert EnrollmentGroup =Other: Code  is 125060004
f)	Insert EnrollmentGroup =Lack of engagement : Code  is 125060005

2.	Obtain the # of records for each enrollment group

3.	Merge the Phone call encounter table with Call duration table.

4.	Find out the # of records for different call outcomes and call type. Use 1-Inbound and 2-Outbound, for call types; use 1-No response,2-Left voice mail and 3 successful. Please also find the call duration for each of the enrollment groups 


5.	Merge the tables Demographics, Conditions and TextMessages. Find the # of texts/per week, by the type of sender. Draw a visual using ggplot to obtain # of texts and color it by the type of sender

6.	Obtain the count of texts based on the chronic condition over a period of time (say per week). Draw a visual using ggplot to obtain the counts

For midterm-project, I firstly found some problems to clean the dataset and I listed all of them to make the table more clear. Then I used ODBC library in R t connect the dataset in the sql database. I then continue used sqlquery to operate the data in th dataset in sql. For each question, I explained that the reasons why I made this change and how I made this change. I also provide sql codes for reference.

For final project, I completed 3 main tasks as follows:
1)	Consider the following blood pressure dataset (IC_BP_v2.csv). Perform the following operations
a.	Convert BP alerts to BP status
b.	Define Hypotension-1 & Normal as Controlled blood pressure Hypotension-2, Hypertension-1, Hypertension-2 & Hypertension-3 as Uncontrolled blood pressure: Controlled & Uncontrolled blood pressure as 1 or 0 (Dichotomous Outcomes) 
c.	Merge this table with demographics (SQL table) to obtain their enrollment dates
d.	Create a 12-week interval of averaged scores of each customer 
e.	Compare the scores from baseline (first week) to follow-up scores (12 weeks)
f.	How many customers were brought from uncontrolled regime to controlled regime after 12 weeks of intervention?


2)	Merge the tables Demographics, Conditions and TextMessages. 
Obtain the final dataset such that we have 1 Row per ID by choosing on the latest date when the text was sent (if sent on multiple days)

3)	Repeat Question 2 in R. 
Hint: You might want to use tidyr/dplyr packages

For Q3, I also provided R codes.
























