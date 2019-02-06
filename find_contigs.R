#!/usr/bin/Rscript

#This script identifies contigs that have homology to novel viruses based on nucleotide BLAST search.

#Import libraries
library(methods)
suppressPackageStartupMessages(library("tidyverse"))
suppressPackageStartupMessages(library("magrittr"))

#Set up argument parser and QC-------------------------------------------------
args <- commandArgs()

#print(args)
annotation <- args[6]
output <-args[7]

if(is.na(annotation)) 
{
  stop("Contig annotation file is not defined")
}

if(is.na(output)) 
{
  stop("Output file not defined")
}

#Read Data---------------------------------------------------------------------

#Testing
# annotation <- "/media/THING2/louis/09_SearchingExternalDatasets/Datasets/PositiveSamples/sunbeam_output/annotation/summary/testsample.tsv"
# output <- "/media/THING2/louis/09_SearchingExternalDatasets/Datasets/PositiveSamples/sunbeam_output/annotation/summary/test_positive_contig_list.txt"

annotation_df <- read.delim(annotation)

annotation_df %>%
  drop_na(novel_virus) %>%
  group_by(sample, novel_virus) %$%
  .[order(.$length, decreasing = TRUE),] %>%
  dplyr::select(c(sample,contig,novel_virus)) %>%
  write_delim(., path = output, 
                 delim = " ")



