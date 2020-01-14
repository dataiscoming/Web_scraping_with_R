# Web scraping with RSelenium

# library
library(RSelenium)
system("java -version")

# Parameters
URL_1 = "https://awoiaf.westeros.org/index.php/House_Stark"
XPATH_1 = "/html/body/div[4]/div/div[1]/div/div[3]/div[4]/div/table[2]/tbody/tr/td/table/tbody/tr[3]/td/table"
URL_2 = "https://www.google.com/search?q=ned+stark&source=lnms&tbm=isch&sa=X&ved=2ahUKEwig8vLF8fjmAhXbAWMBHbbzCVIQ_AUoAXoECBIQAw&biw=1920&bih=966"

# Connect to a selenium server thanks to the rsDriver function
RD <-RSelenium::rsDriver(port=4445L,
                         browser = "firefox",
                         version="latest")
remDr <- RD[["client"]]

# Other way to connect to the server : connect to a local selenium server
# run in cmd : java -jar -Dwebdriver.gecko.driver=D:\ART\2020\week_3_Web_scraping_with_R\#1_Input\geckodriver-v0.26.0-win64\geckodriver.exe selenium-server-standalone-3.141.59.jar -port 4444
# ctrl + c to stop the server with the CMD
remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port = 4444L, 
  browserName = "firefox",
  version = "latest",
  platform="WINDOWS"
)
remDr$open()
remDr$getStatus()

# Docker 
# let's see

# Go to URL
remDr$navigate(URL_1)

# Visualize that URL in R
remDr$screenshot(display = TRUE)

# Moving through URL
remDr$goBack()
remDr$goForward()

# Check What URL we are using 
remDr$getCurrentUrl()

# XPATH, ID, CLASS, CSS Selectors to select the elements we want to scrap
webElem <- remDr$findElement(using = "xpath", value = XPATH_1)
webElem$highlightElement()

# Get the table we want and manage it in a better way to export
WS <- webElem$getElementText()
WS <- unlist(strsplit(WS[[1]], "\n"))

df <- data.frame()
for(i in seq(from=2, to=17, by=2)){
  t <- data.frame("Type"=WS[i],"Name"=WS[i+1])
  df <- rbind(df,t)
}

# Second exmaple with Rselenium
remDr$navigate(URL_2)
remDr$screenshot(display = TRUE)

# Navigate to the bottom of the page 
for(i in 1:10){
  webElem <- remDr$findElement("css", "body")
  webElem$sendKeysToElement(list(key = "end"))
}

# Find every images
webElem <- remDr$findElement(using = "tag name", value = 'img')
webElem <- remDr$findElements(using="xpath",value="//img")
webElem$highlightElement()

# Get the attribute src from every images in order to download the images
res <- sapply(webElem, function(x){x$getElementAttribute("src")})

# Terminate the selenium server and free the port
RD[["server"]]$stop()
remDr$closeServer()

# Reference 
# https://towardsdatascience.com/web-scraping-google-sheets-with-rselenium-9001eda399b0
# https://docs.ropensci.org/wdman/
# https://github.com/ropensci/RSelenium
# https://rdrr.io/cran/RSelenium/man/rsDriver.html
# https://ropensci.org/tutorials/rselenium_tutorial/
# https://cran.r-project.org/web/packages/RSelenium/vignettes/basics.html
# http://thatdatatho.com/2019/01/22/tutorial-web-scraping-rselenium/
# https://stackoverflow.com/questions/38049819/scraping-table-with-r-using-rselenium
# https://github.com/mozilla/geckodriver/releases/tag/v0.26.0
