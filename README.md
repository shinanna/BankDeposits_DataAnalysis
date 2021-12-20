# Project3_Group4
Data preparation project on bank deposits dataset

TO DO TO DATE 20/12/2021
- Harmonize files: different number of rows 
      Bank deposit - Before encoding .csv
      Bank deposit - Final version.ipynb
- 3 SQL tables
- Clean repo
- Trello
- Slides
- Lacks from instructions: Extra: try to build the helpful functions for data preparation

Encoded columns: object dtype
age                                   int64
job                                  object
marital                              object
education                            object
default                              object
balance                               int64
housing                              object
loan                                 object
contact                              object
day                                   int64
month                                object
duration                              int64
campaign                              int64
pdays                               float64
previous                              int64
poutcome                             object
Subscription to deposit (target)     object

Encoding keys legend:

	      0	      1	      2	      3	      4	      5	      6	            7	      8	      9	      10	      11
job	      admin.	blue-collar	entrepreneurhousemaid	management	retired	self-employed	services	student	technician	unemployed	unknown
marital	divorced	married	no	      single								
education	primary	secondary	tertiary	unknown								
default	no	      yes										
housing	no	      yes										
loan	no	yes										
contact	unknown	cellular	telephone									
poutcome	unknown	failure	other	      success								
Subscription
to deposit 
(target)	no	      yes

![image](https://user-images.githubusercontent.com/93386700/146784030-76bebe18-c56e-411e-8b7c-0b79f9d4bc5d.png)
