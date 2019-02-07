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
dbname <- args[7]
output <-args[8]

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

cols_select <- c("sample", "contig", "length", dbname)

annotation_df <- read.delim(annotation) %>%
  dplyr::select(one_of(cols_select))

colnames(annotation_df) <- c("sample", "contig", "length", "hit")

annotation_df %>%
  drop_na(hit) %>%
  group_by(sample, hit) %$%
  .[order(.$length, decreasing = TRUE),] %>%
  dplyr::select(c(sample, contig, hit)) %>%
  write_delim(., path = output, 
                 delim = " ")



