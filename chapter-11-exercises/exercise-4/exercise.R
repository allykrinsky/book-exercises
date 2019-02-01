# Exercise 4: practicing with dplyr

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
install.packages("nycflights13")
library("nycflights13")
library("dplyr")
View(flights)

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
nrow(flights)
ncol(flights)
colnames(flights)


# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
delayed <- mutate(flights, arr_delay)
delayed

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
delay <- arrange(delayed)
delay

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
flights %>% 
  mutate(arr_delay) %>% 
  arrange()

# Make a histogram of the amount of time gained using the `hist()` function
hist(flights$dep_delay)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
flights <-flights %>% 
  mutate(tot_delay = dep_delay + arr_delay) %>% 
  na.omit
  
mean(flights$tot_delay)  
# on average the flights gained time

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created

to_seatac <- flights %>% 
  filter(dest == "SEA") %>% 
  select(origin, dest, tot_delay)
  
View(to_seatac)

# On average, did flights to SeaTac gain or loose time?
mean(to_seatac$tot_delay)
#gained

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!

jfk_to_seatac <- flights %>% 
  filter(origin == "JFK") %>% 
  filter(dest == "SEA") %>% 
  summarize(
    avg = mean(air_time),
    min = min(air_time),
    max = max(air_time)
  )
jfk_to_seatac

 

