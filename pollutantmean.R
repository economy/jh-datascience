pollutantmean <- function(directory, pollutant, id = 1:332){
    ## Get WD
    dir <- getwd()
    
    ## Pad id values with leading zeroes for filename convention
    ids <- sprintf("%03d", as.numeric(id)) 
    
    ## File list by monitor id
    files <- paste(dir, "/", directory, "/", ids, ".csv", sep="")
    
    ## Iterate
    msr <- vector(mode="numeric")
    
    for (i in files){
        df <- read.csv(i, header=T)
        
        ## cat pollutant measurements to vector
        msr <- c(msr,df[[pollutant]]) 
    }
    
    ## Return mean
    mnpoll <- mean(msr,na.rm=T)
    return(mnpoll)
    
}
