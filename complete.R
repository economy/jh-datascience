complete <- function(directory, id = 1:332) {
    
    ## Get WD
    dir <- getwd()
    
    ## Instantiate data frame
    df <- data.frame(id,nobs=0)
    
    ## Iterate to get nobs
    for (i in id) {
        ## Pad id values with leading zeroes for filename convention
        ids <- sprintf("%03d", as.numeric(i)) 
        
        ## File list by monitor id
        file <- paste(dir, "/", directory, "/", ids, ".csv", sep="")
        
        ## Read file
        frame <- read.csv(file, header=T)
        
        ## Append complete cases to df
        df$nobs[df$id==i] <- sum(complete.cases(frame))
    }
    
    return(df)
}