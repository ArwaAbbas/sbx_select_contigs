# sbx_select_contigs
This is an extension to the [Sunbeam metagenomics pipeline](https://github.com/sunbeam-labs/sunbeam) to extract, then coassemble (using CAP3), contigs with homology to sequences within a given BLAST database.

## Install

If using Sunbeam 3.0 or greater (as of Dec 2019):

    sunbeam extend https://github.com/ArwaAbbas/sbx_select_contigs
    
Otherwise, clone the extension into your Sunbeam extensions dir:

    conda activate sunbeam
    git clone https://github.com/ArwaAbbas/sbx_select_contigs $SUNBEAM_DIR/extensions/sbx_select_contigs

## Initialization

In Sunbeam >=3.0, to add the `sbx_select_contigs` options to your config file:

    sunbeam config update -i sunbeam_config.yml

Or, just add them manually (works with any version of Sunbeam):

    cat $SUNBEAM_DIR/extensions/sbx_select_contigs/config.yml >> sunbeam_config.yml
    
You need at least one BLAST database for this extension to work. The relevant sections of your `sunbeam_confif.yml` might look something like this:

    ...
    
    blastdbs:
      root_fp: '/home/me/my_awesome_project'
      nucleotide:
         my_awesome_organism: 'my_awesome_organism_genomes.fasta'
         
    ...
    
    sbx_select_contigs:
      threads: 4
      dbname: 'my_awesome_organism'
  
## Running

Run as usual, specifying `select_all` as the target rule, and adding `--use-conda` so that Snakemake handles all the extension's dependencies for you:

     sunbeam run --configfile sunbeam_config.yml --use_conda select_all
