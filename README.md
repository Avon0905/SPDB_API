# SPDB_API

## Introduction

The R script for integration and reuse of [SPDB](https://scproteomicsdb.com/) within relevant R tools.

## Usage
1. Clone the source code.
```
git clone https://github.com/Avon0905/SPDB_API.git
```

2. Running R script in R environment.
```
Rscript spdb_api.R

spdb.list() # Get the list of all available datasets

datainfo = spdb.list(technologies = "CITE-seq", species = "Homo sapiens", tissues = "blood") # Get the list of available datasets meeting some filter criteria

spdb.save(datalist = datainfo[1:5,"ID"], savedir) # Download interested datasets from websever

data = spdb.load(dataID = datainfo[2,"ID"]) # Load one interested dataset from websever into R environment
```

## Questions

If you have any questions or problems, please feel free to open a new issue [here](https://github.com/Avon0905/SPDB_API/issues). We will fix the new issue ASAP. 