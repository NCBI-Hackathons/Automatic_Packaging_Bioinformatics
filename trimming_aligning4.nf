#!/usr/bin/env nextflow
/* Testing for NCBI SpEW project, trimming module
* Zhou (Ark) Fang zhf9@pitt.edu
*/
inPath = "/zfs1/ncbi-workshop/AP/nextflow/"
inFiles = "$inPath/*.fastq.gz"
singleEnd = true
adapter1 = "ADATPER_FWD"
adapter2 = "ADATPER_REV"

inFiles

params.in = "/zfs1/ncbi-workshop/AP/RNAseq/*.fastq"
sequences = file(params.in)
/* records = "/zfs1/ncbi-workshop/AP/RNAseq/AlignedReads/"  */

process modules{
script"
        """
        bash module load bowtie2
        bash module load tophat
        bash module load cutadapt
        """
}


process trimming{


input:
file inFiles

output:
file 'trimmed_*' /* into records */

script:
   if (singleEnd==true)
   """
   bash trimming.sh -i inPath -s -a1 adapter1 -a2 adapter2
   """
   else
   """
   bash /zfs1/nci-workshop/AP/nextflow/trimming.sh -i inPath -a1 adapter1 -a2 adapter2
   """
}



process alignment {

        input:
        file '*.fastq.gz'

        output:
        file 'aligned_*' into /* records */

        """
        bash /zfs1/ncbi-workshop/AP/nextflow/align2.sh