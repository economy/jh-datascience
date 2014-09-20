rankhospital <- function(state, outcome, num = "best") {
    
    ## Read outcome data
    df <- read.csv("outcome-of-care-measures.csv", colClasses="character", na.strings = "Not Available")
    
    ## Check that state and outcome are valid
    valid_states <- unique(df$State)
    
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
    
    if(state %in% valid_states){
        svar <- state
    }
    else{
        stop("invalid state")
    }

    
    ## Return hospital name in that state with the given rank
    
    sdf <- subset(df, State == svar)
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
    
    return(result)
}
