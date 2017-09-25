# geo-merge-id-gene
This R script uses two files from a GEO dataset as inputs, the unzipped series matrix and the unzipped platform annotations files and returns a .csv file with the intitial series matrix columns as well as their respective gene symbols.
Comments in series matrix should start with "!" and in the platform annotation with "#".
The third input arguement is an integer, showing the number of the column that contains the respective gene symbols of the platform.

3 arguements:
1. unzipped series matrix, "!" for comments
2. unzipped platform annotation, "#" for comments
3. integer showing the column of the platform data which contains the gene symbols

Make sure Rscript is in the PATH environment variable.

Example:
Rscript geo-merge-id-gene.R "GSE71351_series_matrix.txt" "GPL10558-50081.txt" 6
