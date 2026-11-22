
library(ggplot2)
library(dplyr)
library(tidyr)
library(reshape)
library(sqldf)
library(ggthemes)

studentresult<-read.csv('C:\\Users\\marisa.llorens\\OneDrive - Technological University Dublin\\25-26\\Data Visualisation\\Week 9 Relationships\\studentresult.csv',sep=',',header=T)

head(studentresult)

#####SQLDF examples

marks <- sqldf('select Subject, sum(Mark_Written) as mark from studentresult group by subject')

markswritten <- sqldf('select Name, avg(Mark_Written) as Written_marks from studentresult group by Name')

avgmark <- sqldf("select AVG(Mark_Oral) from studentresult where Name = 'Mary Healy' AND Mark_Oral is not 'NA'") 


####Long Format###
##pivotlonger###

data_long <- pivot_longer(studentresult, cols = starts_with("mark"), names_to = "variable", values_to = "value")

head(data_long)

###Question 1###
#Sample code
###bar chart long table
ggplot(data_long, aes(x = Name, y = value, fill = variable) ) +
  geom_bar(stat="identity", position = 'dodge')  

ggplot(data_long, aes(x = Name, y = value, fill = variable) ) +
  geom_bar(stat="identity")   ## default is to stack

###Question 2###
#Sample code

studentresult %>%
  group_by(Subject) %>%
  summarise(addit = sum(Mark_Written)) %>%
  arrange(addit)

##Find the average values

markswritten<-studentresult %>%
  group_by(Name) %>%
  summarise(Written_marks = mean(Mark_Written)) %>%
  arrange(Written_marks)

######################Alternative

markswritten2<-aggregate(data=studentresult,Mark_Written~Name,mean)


namesAvgmarkplot<-ggplot(data=markswritten, aes(x= Name, y=Written_marks)) + geom_bar(stat="identity",aes(fill=Name), width = 0.25)
namesAvgmarkplot
namesAvgmarkplot+ scale_fill_manual(values=c("Hercule Poirot"="steelblue", "Joe O'Neil"="firebrick", "Mary Healy"="darkgreen"))
namesAvgmarkplot+ scale_fill_brewer(palette='Set2')

namesAvgmarkplot+ 
  scale_fill_manual(values=c("Hercule Poirot"="darkgrey", "Joe O'Neil"="darkgrey", "Mary Healy"="red"))


#####################Repeat for Oral

marksoral<-aggregate(data=studentresult, Mark_Oral~Name,mean)
ggplot(data=marksoral, aes(x= Name, y=Mark_Oral, fill=Name)) + geom_bar(stat="identity") + scale_fill_brewer(palette='Set2')
ggplot(data=marksoral, aes(x= Name, y=Mark_Oral)) + geom_bar(stat="identity", fill='blue') 




#############################################################
#############################################################
####################Exercises################################
#############################################################


###1.	What are the total marks (oral plus written divided by two) for each student for each subject?



######2.	What subject obtained the best results on average?




###3.	Did any students do better on their written compared with their oral (or vice versa)?






