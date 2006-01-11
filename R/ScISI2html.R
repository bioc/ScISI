ScISI2html <- function(urlVect, linkName, filename, title, othernames, table.head,
                       table.center = TRUE, compSize = NULL){

    if (!is.null(compSize)){
        for (i in 1:length(linkName)){
            linkName[i] = paste(linkName[i], "-", compSize[i], "Proteins",  sep = " ")
        }
    }
    outfile <- file(filename, "w")
    type <- "text/css"
    cat("<html>", "<head>", "<TITLE>Protein Complex Co-membership</TITLE>",
        "</head>", "<body bgcolor=#FFFFFF >", "<H1 ALIGN=CENTER > Protein Complex Co-Membership</H1>",
        ## CSS to allow reasonable spacing for multiple links per cell
        paste("<style type=", type,">",sep = ""), "p{ margin-top: 1px; margin-bottom: 1px; padding-left: 10px; text-indent: -10px }",
        "</style>", file = outfile, sep = "\n")
    if (!missing(title))
      cat("<CENTER><H1 ALIGN=\"CENTER\">", title, " </H1></CENTER>\n",
          file = outfile, sep = "\n")
    if (table.center)
      cat("<CENTER> \n", file = outfile)
    cat("<TABLE BORDER=4>", file = outfile, sep = "\n")
    if (!missing(table.head)) {
        headout <- paste("<TH>", table.head, "</TH>")
        cat("<TR>", headout, "</TR>", file = outfile, sep = "\n")
    }
    
    ##Here is where the url should go:
    
    for ( i in 1:length(urlVect)){
        cat("<TR>", "<TD>", "<a href =", urlVect[i], ">", linkName[i], "</a>", "</TD>", "</TR>","\n",  file=outfile, sep = " ")
    }
    
    cat("</TABLE>", file = outfile)
    if (table.center)
      cat("</CENTER> \n", file = outfile)
    cat("</body>", "</html>", sep = "\n", file = outfile)
    close(outfile)
}
