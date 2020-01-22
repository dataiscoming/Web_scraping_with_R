# Web scraping with Rcrawler

# library
library(Rcrawler)

# Parameters
URL = "https://awoiaf.westeros.org/index.php/House_Stark"
XPATH = "/html/body/div[4]/div/div[1]/div/div[3]/div[4]/div/table[2]/tbody/tr/td/table/tbody/tr[3]/td/table"

# Scraping 
res<-ContentScraper(Url = URL, XpathPatterns =c(XPATH), ManyPerPattern = TRUE) 

res <- unlist(strsplit(res[[1]], "\n"))

# references
# https://rpubs.com/kassila/rcrawler-web-scraper-and-crawler
# https://github.com/salimk/Rcrawler