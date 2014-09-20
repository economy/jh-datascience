best <- function(state, outcome){
    ## Read outcome data
    df <- read.csv("outcome-of-care-measures.csv", colClasses="character", na.strings = "Not Available")
    
    ## Check that state and outcome inputs are valid
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
    
    ## Return lowest death rate hospital name
    
    sdf <- subset(df, State == svar)
    hospitals <- sdf$Hospital.Name[as.numeric(sdf[[ovar]]) == min(as.numeric(sdf[[ovar]]), na.rm=T)]
    hospitals <- hospitals[!is.na(hospitals)]
    
    if(length(hospitals) > 1){
        srted <- sort(hospitals)
        result <- srted[1]
    }
    else{
        result <- hospitals
    }
    
    return(result)
}