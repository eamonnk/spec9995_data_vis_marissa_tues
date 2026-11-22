# Importing packages 
#if not installed 
#install.packages("dplyr")


library(dplyr)
library(ggplot2)

# to get help use ?
?library

#simple assignments
x<-2
y=4

#multiple assignments
a<-b<-7


 #Data types 
class(x)
 is.numeric(a)
 is.character(b)


#  #Data types  Characters
 xchar<- 'data'

# Length
 nchar(xchar)


#Factors
ychar=factor(c("data1","data2","data1"))
levels(ychar)


# #dates
 date1<-as.Date("2020-09-09")


# #creating a vector using c
 vector1<-c(1,2,3,4,5,5)

 # #creating a vector using :   (sequence of numbers)
 vector2<-1:6
vector3<-seq(0, 10, by=2)

 # #length of a vector
 length(vector1)

# #Vector operations
vector1*3
vector1+vector2  
#length of this addition should be 6 as well, test it!
length(vector1+vector2 )


# #Comparing vectors to values
vector1<5
any(vector1<5)
all(vector1<5)


# #using nchar with vectors
vector3<-c("a","bb","ccc","dd","eeee")
nchar(vector3)


### Accessing elements and slicing
###different to python CAREFUL!!!!
vector3[1]
vector3[2:3]
vector3[c(2,5)]
vector3[-3]


# #Factor vectors
g<-c("January","February","February","April","June","June","June")
g
gfactor<-as.factor(g)
levels(gfactor)


x<-1:10
y<-4:13
comments<-c("good", "basic", "Excellent","good", "basic","good", "basic","Excellent","good","Excellent")
mydf<-data.frame(x,y,comments)
mydf
# #naming our columns
mydf<-data.frame(First=x,Second=y,Opinion=comments)
mydf


## #Accessing one column
mydf$Opinion 
mydf[2]
# #Accessing one row
mydf[3,]
 # #accessing one element
mydf[1,3]


# read.table creates a data.frame with the data.

mydata2<-read.csv2("http://www.jaredlander.com/data/Tomato%20First.csv",header=TRUE,sep=',')
head(mydata2)
 
adult<-read.table('https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data',header=FALSE,sep=',',strip.white = TRUE)


#Renaming columns
colnames(adult) <- c("age","workclass","fnlwgt","education","education_num","marital_status","occupation","relationship","race","gender","capital_gain","capital_loss","hours_per_week","native_country","income_bracket")
head(adult)


head(adult)
tail(adult)


ncol(adult)
nrow(adult)
dim(adult)


names(adult) 



str(adult)


adult[adult$native_country == '?',]


#More than one condition
adult[adult$occupation == '?' & adult$gender=='Female',]

any(is.na(adult$occupation))


any(is.na(adult$gender))


#Setting values based on a condition
adult$fnlwgt[adult$marital_status == 'Divorced'] <-  2000
head(adult)

data.frame(adult$occupation,adult$education)

#Sort values
newadult <- adult[order(-adult$education_num),]
newadult

#Is there any missing value in the gender column?
any(is.na(adult$gender))

# generate a summary table for a column
summarygender<-table(adult$gender)
summarygender

summarygender[1]
summarygender[2]


## view mean age per gender 
aggregate(adult$age~adult$gender,adult,mean)

## view sum ages per gender 
aggregate(adult$age~adult$gender,adult,sum)

## view median age per gender 
aggregate(adult$age~adult$gender,adult,median)

#Extra info
#?aggregate


library(palmerpenguins)
penguins %>% head()    ## instead of head(penguins)



penguins %>% filter(species == "Gentoo") %>% head()

penguins %>% filter(is.na(sex))

penguins %>% filter(bill_length_mm > 50) %>% head()


penguins %>% filter(!is.na(bill_length_mm)) %>% head()


#Extract a number of columns

penguins %>% select(species, island, sex) %>% head()


#Sort rows

penguins %>% arrange(bill_length_mm) %>% head()


penguins %>% arrange(desc(bill_length_mm)) %>% head()


penguins %>% count(species)
penguins %>% count(species, island)



penguins %>% group_by(species) %>% summarise(n())


#penguins %>% filter(species == "Adelie")
#penguins %>% filter(species == "Adelie") %>% select(island, sex)
penguins %>% filter(species == "Adelie") %>% select(island, sex) %>% count(island, sex)


#Adding columns
penguins %>% select(species, island, flipper_length_mm) %>% mutate(flipper_length_cm = flipper_length_mm / 10) %>% head()


penguins %>% select(species, island, flipper_length_mm) %>%
mutate(flipper_length_cm = flipper_length_mm / 10, 
flipper_length_in = flipper_length_mm / 25.4) %>% head()


diamonds %>% head()

ggplot(diamonds, aes(cut)) +
  geom_bar(fill = "#0073C2FF")


diamonds %>% group_by(cut) %>% summarise(caratmean=mean(carat)) %>% 
ggplot(aes(x=cut, y =caratmean))+geom_col(fill='green')


diamonds %>% group_by(cut) %>% summarise(caratmean=mean(carat)) %>% 
ggplot(aes(x=cut, y =caratmean))+ geom_bar(stat="identity",fill='green')
 

ycarat=diamonds %>% group_by(cut) %>% summarise(caratmean=mean(carat))

ggplot(ycarat,aes(x=cut, y =caratmean))+geom_col(fill='yellow')


ycarat=diamonds %>% group_by(cut) %>% summarise(caratmean=mean(carat))

ggplot(ycarat,aes(x=cut, y =caratmean))+geom_bar(stat="identity",fill='yellow')

 ggplot( mydata2,aes(x =Tomato, y = Price )) +
geom_col()
 

#refining the graph flipping to horiz bars, adding colour based on variable
#also using tidyverse

mydata2 %>% ggplot( aes(x =Tomato, y = Price, fill = Source )) +
  geom_bar(stat='identity') +
  coord_flip()+
  labs(x = "the x label is Tomato", y = "the y label is Price") 


##Scatter plot

ggplot(data =mydata2,aes(x =Tomato,y = Price,color = Source )) +
    labs(x = "the x label is Tomato",y = "the y label is Overall ") +
    scale_fill_brewer(palette = "Set3") +
    geom_point()   +
    coord_flip()


#Traditional format
ggplot(penguins, aes(bill_length_mm, bill_depth_mm, color = species)) + 
geom_point()

#Tidyverse format
#penguins %>% ggplot(aes(bill_length_mm, bill_depth_mm, color = species)) + geom_point()


mydata2 %>% ggplot( aes(x =Source, y = Overall, fill = Source )) +  geom_bar(stat='identity') +
coord_flip()

#Exercise 2
ggplot(mydata2, aes(Sweet, Acid, color = Source)) + 
geom_point()



