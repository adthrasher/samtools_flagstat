#!/bin/bash
set -e -x
main() {
    echo "Name of bam_file: '$bam_file'"
    # Downloads file from project to virtual machine workspace
    dx download "$bam_file"
    # Creating output directory for FastQC
    mkdir ~/flagstat-out
    # Runs Flagstat on BAM file
    samtools flagstat "$bam_file_name" >  ~/flagstat-out/flagstat.txt
    
    # Uploads the respective HTML and Zip file
    flagstat_txt=$(dx upload ~/flagstat-out/flagstat.txt --brief)
    
    # Adds and formats appropriate output variables for your app
    dx-jobutil-add-output flagstat_txt "$flagstat_txt" --class=file
    
}
