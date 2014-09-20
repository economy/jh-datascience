corr <- function(directory, threshold = 0) {
    
    ## Return a numeric vector of correlations
    
    ## Old WD for setting and unsetting
    olddir <- getwd()
    setwd(paste(olddir,"/",directory,sep=""))
    
    ## File list
    files <- list.files(pattern="*.csv")
    
    cors <- vector(mode="numeric")
    
    for (i in files){
        
        ## Read data frame
        frame <- read.csv(i, header=T)
        
        ## Limit to complete cases
        ok <- complete.cases(frame)
        frame <- frame[ok,]
        
        if (length(frame$sulfate) > threshold){
            
            unit <- cor(frame$sulfate, frame$nitrate)
            cors <- c(cors,unit)
            
        }
        
    }
    
    ## WD back to old
    setwd(olddir)
    
    return(cors)
}