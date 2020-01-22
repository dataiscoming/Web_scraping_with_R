# Web scraping with Rvest

# Library
library(rvest)

# Parameters
URL = "https://awoiaf.westeros.org/index.php/House_Stark"
XPATH = "/html/body/div[4]/div/div[1]/div/div[3]/div[4]/div/table[2]/tbody/tr/td/table/tbody/tr[3]/td/table"

# Extract the data into a dataframe
res <- read_html(URL) %>%
  html_nodes(xpath = XPATH) %>%
  html_table(fill=TRUE) 

# Show the results of the web scraping
View(res[[1]])

# Create a session and navigate from a URL to another
rvest_session <- html_session(URL) %>%
  jump_to("Great_Houses") %>% 
  session_history()

# Old URM, so the URL of "House_stark"
rvest_session$back

# Actual url, so the Url of great "Great_Houses"
rvest_session$url

# Get the status of the page that we check 
status_code <- html_session(URL) %>%
  jump_to("Great_Houses") %>% 
  httr::status_code()

# Reference
# https://www.analyticsvidhya.com/blog/2017/03/beginners-guide-on-web-scraping-in-r-using-rvest-with-hands-on-knowledge/
# https://thinkr.fr/rvest/


