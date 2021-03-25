library(dplyr)

#loading files
lkdn1 <- read.csv("C:\\Users\\dange\\Desktop\\ml_mini_project\\datasets_csv\\lockdown1.csv", header = FALSE)
lkdn2 <- read.csv("C:\\Users\\dange\\Desktop\\ml_mini_project\\datasets_csv\\lockdown2.csv", header = FALSE)
lkdn3 <- read.csv("C:\\Users\\dange\\Desktop\\ml_mini_project\\datasets_csv\\lockdown3.csv", header = FALSE)
lkdn4a <- read.csv("C:\\Users\\dange\\Desktop\\ml_mini_project\\datasets_csv\\lockdown4_a.csv", header = FALSE)
lkdn4b <- read.csv("C:\\Users\\dange\\Desktop\\ml_mini_project\\datasets_csv\\lockdown4_b.csv", header = FALSE)

#adding header
my_header <- c("time", "tweet_id", "sentiment_score", "location")
colnames(lkdn1) <- my_header
colnames(lkdn2) <- my_header
colnames(lkdn3) <- my_header
colnames(lkdn4a) <- my_header
colnames(lkdn4b) <- my_header

library(tmaptools)

#Geocoding the locations
location_data_lkdn1 <- geocode_OSM(lkdn1$location, details = TRUE, as.data.frame = TRUE, keep.unfound = TRUE)
location_data_lkdn2 <- geocode_OSM(lkdn2$location, details = TRUE, as.data.frame = TRUE, keep.unfound = TRUE)
location_data_lkdn3 <- geocode_OSM(lkdn3$location, details = TRUE, as.data.frame = TRUE, keep.unfound = TRUE)
location_data_lkdn4b <- geocode_OSM(lkdn4b$location, details = TRUE, as.data.frame = TRUE, keep.unfound = TRUE)

#data at 1301-1400 threw a "attribute construct error"
location_data_lkdn4a <- geocode_OSM(lkdn4a$location[1:1300], details = TRUE, as.data.frame = TRUE, keep.unfound = TRUE)
temp <- location_data_lkdn4a
location_data_lkdn4a <- geocode_OSM(lkdn4a$location[1401:7200], details = TRUE, as.data.frame = TRUE, keep.unfound = TRUE)
temp <- rbind(temp, location_data_lkdn4a)

lkdn4a <- rbind(lkdn4a[1:1300,], lkdn4a[1401:7200])

#saving the geocoded data
write.csv(location_data_lkdn1, file="C:\\Users\\dange\\Desktop\\ml_mini_project\\datasets_csv\\lockdown1_locations.csv", fileEncoding = "UTF-8")
write.csv(location_data_lkdn2, file="C:\\Users\\dange\\Desktop\\ml_mini_project\\datasets_csv\\lockdown2_locations.csv", fileEncoding = "UTF-8")
write.csv(location_data_lkdn3, file="C:\\Users\\dange\\Desktop\\ml_mini_project\\datasets_csv\\lockdown3_locations.csv", fileEncoding = "UTF-8")
write.csv(location_data_lkdn4a, file="C:\\Users\\dange\\Desktop\\ml_mini_project\\datasets_csv\\lockdown4a_locations.csv", fileEncoding = "UTF-8")
write.csv(location_data_lkdn4b, file="C:\\Users\\dange\\Desktop\\ml_mini_project\\datasets_csv\\lockdown4b_locations.csv", fileEncoding = "UTF-8")

#merging lockdown 4.0a and 4.0b data
lkdn4 <- rbind(lkdn4a, lkdn4b)
location_data_lkdn4 <- rbind(location_data_lkdn4a, location_data_lkdn4b)

#combining sentiment score and location info
lkdn1_complete <- cbind(lkdn1, location_data_lkdn1$lat, location_data_lkdn1$lon, location_data_lkdn1$place_rank)
lkdn2_complete <- cbind(lkdn2, location_data_lkdn2$lat, location_data_lkdn2$lon, location_data_lkdn2$place_rank)
lkdn3_complete <- cbind(lkdn3, location_data_lkdn3$lat, location_data_lkdn3$lon, location_data_lkdn3$place_rank)
lkdn4_complete <- cbind(lkdn4, location_data_lkdn4$lat, location_data_lkdn4$lon, location_data_lkdn4$place_rank)


#adding headers
my_header <- c(my_header, "latitude", "longitude", "place_rank")
colnames(lkdn1_complete) <- my_header
colnames(lkdn2_complete) <- my_header
colnames(lkdn3_complete) <- my_header
colnames(lkdn4_complete) <- my_header


data_lockdown1 <- lkdn1_complete[!is.na(lkdn1_complete$place_rank),]
data_lockdown2 <- lkdn2_complete[!is.na(lkdn2_complete$place_rank),]
data_lockdown3 <- lkdn3_complete[!is.na(lkdn3_complete$place_rank),]
data_lockdown4 <- lkdn4_complete[!is.na(lkdn4_complete$place_rank),]


#saving files with added headers
write.csv(data_lockdown1, file="C:\\Users\\dange\\Desktop\\ml_mini_project\\datasets_csv\\processed_1\\lockdown1.csv", fileEncoding = "UTF-8" )
write.csv(data_lockdown2, file="C:\\Users\\dange\\Desktop\\ml_mini_project\\datasets_csv\\processed_1\\lockdown2.csv", fileEncoding = "UTF-8" )
write.csv(data_lockdown3, file="C:\\Users\\dange\\Desktop\\ml_mini_project\\datasets_csv\\processed_1\\lockdown3.csv", fileEncoding = "UTF-8" )
write.csv(data_lockdown4, file="C:\\Users\\dange\\Desktop\\ml_mini_project\\datasets_csv\\processed_1\\lockdown4.csv", fileEncoding = "UTF-8" )

#merging all data
lkdn_data <- rbind(data_lockdown1, data_lockdown2, data_lockdown3, data_lockdown4)

#saving the merged data
write.csv(lkdn_data, file="C:\\Users\\dange\\Desktop\\ml_mini_project\\datasets_csv\\processed_1\\lockdown_combined.csv", fileEncoding = "UTF-8")

