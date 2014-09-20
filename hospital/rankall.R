rankall <- function(outcome, num = "best") {

    
    ## Read outcome data
    df <- read.csv("outcome-of-care-measures.csv", colClasses="character", na.strings = "Not Available")
    
    ## Check that state and outcome are valid
    states <- unique(df$State)
    states <- sort(states)
    
    if(outcome == "heart attack"){
        ovar <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    }
    else if(outcome == "heart failure"){
        ovar <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    }
    else if(outcome == "pneumonia"){
        ovar <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    }
    else{
        stop("invalid outcome")
    }
    
    ## For each state, find the hospital of the given rank
    bys <- data.frame(hospital=NA,state=NA)
    #rownames(bys) <- bys$st
    
    i <- 1
    for(s in states){
        sdf <- subset(df, State == s)
        hbr <- data.frame(hp = sdf$Hospital.Name, rate = as.numeric(sdf[[ovar]]), stringsAsFactors = F)
        
        ordered <- hbr[with(hbr, order(hbr$rate,hbr$hp)),]
        ordered$rank <- seq(length(ordered$hp))
        ordered <- ordered[!is.na(ordered$rate),]
        
        if(num == "best"){
            r <- 1
        }
        else if(num =="worst"){
            r <- max(ordered$rank)
        }
        else{
            r <- num
        }
        
        result <- ordered$hp[ordered$rank == r]
        if(length(result) == 0){
            result <- NA
        }
        
        bys <- rbind(bys,c(result,s))
    }
    
    ## Return a data frame with the hospital names, state abbreviation
    
    bys <- bys[-(1:1),]
    return(bys)
}

