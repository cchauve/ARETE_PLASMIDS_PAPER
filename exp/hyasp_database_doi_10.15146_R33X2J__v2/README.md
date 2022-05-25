# ARETE Plamids Comparison Paper: HyAsP database

This directory contains the list of GenBank accession numbers for the plasmid database used by HyAsP.

This database is described in the paper <a href="https://doi.org/10.1128/MRA.01325-18">A Curated, Comprehensive Database of Plasmid Sequences</a> (Microbiology Resource Announcements, 2019).

The data were downloaded on 2022-05-03 from <a href="https://datadryad.org/stash/dataset/doi:10.15146/R33X2J">Dryad: Plasmids database</a>.

Once the data were downloaded, the list of accession numbers was generated as follows:
```
unzip doi_10.15146_R33X2J__v2.zip
grep ">" All_plasmids.fna | sed 's/>//g' > doi_10.15146_R33X2J__v2_id.txt
```

2022-05-24.
First attenmpt failed, see slurm-34421263.out