#!/usr/bin/env Rscript
# geo-merge-id-gene
#This R script uses two files from a GEO dataset as inputs, the unzipped series matrix and the unzipped platform annotations files and returns a .csv file with the intitial series matrix columns as well as their respective gene symbols.
#Comments in series matrix should start with "!" and in the platform annotation with "#".
#The third input arguement is an integer, showing the number of the column that contains the respective gene symbols of the platform.

#3 arguements:
#1. unzipped series matrix, "!" for comments
#2. unzipped platform annotation, "#" for comments
#3. integer showing the column of the platform data which contains the gene symbols

#Make sure Rscript is in the PATH environment variable and you have your input files in the current directory.

#Example:
#Rscript geo-merge-id-gene.R "GSE71351_series_matrix.txt" "GPL10558-50081.txt" 6

args = commandArgs(trailingOnly = TRUE) #allow use of args
if (length(args) != 3) { #check if correct number of args
	stop("Two input files from GEO required; series matrix and platform annotation and an integer showing the column number of gene symbols in the platform annotation", call.=FALSE) #if not exactly three args, throw error
}
series_matrix <- read.csv(args[1], sep = "\t", header = TRUE, comment.char = "!", blank.lines.skip = TRUE) #works by removing comment lines starting with "!", as is the format of the series matrices in GEO
colnames(series_matrix)[1] <- "ID" #to merge with annotations, need same name
annotation <- read.csv(args[2], sep = "\t", header = TRUE, comment.char = "#", blank.lines.skip = TRUE) #removes # comments
gene_symbol_col <- as.integer(args[3]) #as.integer needed
annotation <- annotation[,c(1,gene_symbol_col)] #keep only ID and gene symbols
colnames(annotation)[1] <- "ID" #to merge with series matrix, need same name
gene_series <- merge(series_matrix, annotation) #merge
write.table(gene_series, "gene_series_output.csv", row.names=FALSE, col.names=TRUE, sep=",")
