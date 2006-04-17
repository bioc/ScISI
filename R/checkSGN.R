checkSGN <- function(ISI){
    yA <- as.list(YEASTALIAS)
    need2Check <- rownames(ISI)[which(rownames(ISI)%in%names(yA)==FALSE)]
    need2Check
}
