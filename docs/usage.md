---
layout: default
title: Project structure
---

## Table of Contents
- [Main page](index.md)
- [Native tool and data](PLET.md)
- [Onboarding in EDITO](EDITO.md)
- [Project structure](project_structure.md)
- [How to use](usage.md)

# User Guidelines


It is recommended to run the ```R.proj``` file (an R project file) before to ensure that the working directory will automatically be set appropriately.

----------------

## Using PLET Data

### Get Data
Go to [https://www.dassh.ac.uk/lifeforms/](https://www.dassh.ac.uk/lifeforms/) and download your data.  
Store the data in:

```
/data/lifeform.csv
```

### Run Analysis
Run 
```PH1-FW5_indicator_script_v2.Rmd``` on ```/data/lifeform.csv``` and view the results in ```/output```.

----------------

## Using data from EDITO

This includes several steps:
- Step 1: Query the occurrence data parquet
- Step 2: Make monthly aggregates
- Step 3: Run PH1 analysis

### Step 1: Query the occurrence data parquet
Extract and format data from the EDITO data lake.  
As an example, a pipeline for the EurOBIS dataset (ID: 4687) is provided.

Run ```get_data.R``` to extract and format this data. It will be stored in:

```
../data/PH1_edito_test.csv
```

This pipeline performs several reusable steps:

- **Search the occurrence parquet**  
  Performs a STAC search and returns the latest version of the occurrence parquets.

```r
source("search_data_lake/_search_STAC.R")
occ <- search_STAC()
```

- **Open the parquet**  
  This establishes the connection with the S3 bucket using `S3FileSystem`.

```r
source("search_data_lake/_open_parquet.R")
dataset <- open_my_parquet(my_parquet)
```

- **Filter the parquet**

```r
source("search_data_lake/_filter_parquet.R")
filter_params <- list(
  #longitude = c(0, 1),
  #latitude = c(50, 51),
  datasetid = 4687,
  parameter = "WaterAbund (#/ml)",
  eventtype = "sample"
)
my_selection <- filter_parquet(dataset, filter_params)
```

Several additional filtering steps:

- **filter on Trip Action** 

```r
desired_trip_actions = read_csv("lookup_tables/allTripActions_exp.csv", 
                                show_col_types = FALSE)

my_selection <- filter_parquet(dataset, filter_params) %>%
  mutate(
    TripActionID = stringr::str_extract(event_id, "TripActionID\\d+"),
    TripActionID = as.integer(stringr::str_remove(TripActionID, "TripActionID"))
  ) %>%
  filter(TripActionID %in% desired_trip_actions$Tripaction)
```

- **filter on OSPAR region** 

```
#' see https://odims.ospar.org/en/submissions/ospar_comp_au_2023_01/
#' for OSPAR region id's and source files.
#' The function "load_ospar_region" is sources from /utils/ospar_regions.R
#' and loads the JSON file hosted at that webiste. It is Used to verify whether 
#' your data is in a specific OSPAR region.
MY_REGION <- "SCHPM1"

# Load region polygon
my_region <- load_ospar_region(MY_REGION)

# Convert to sf and filter out missing coords
my_selection_sf <- my_selection %>%
  filter(!is.na(longitude), !is.na(latitude)) %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = 4326)

# Perform spatial join to keep only records inside the region
my_selection_inside <- st_join(my_selection_sf, my_region, join = st_within, left = FALSE)
```

### Step 2: Make monthly aggregates

Once you have the occurrence data, it needs to be formatted into **monthly aggregated lifeform groups**.  
If you intend to write your own pipeline or bring your own data, this section explains the expected format.

CSV file:

- `"Period"`: YYYY-MM (e.g. 2021-01)
- `"lifeform"`: Name of the lifeform (e.g. *diatom*)
- `"abundance"`: Abundance data (decimal point as `.`), monthly averaged
- `"num_samples"`: Number of samples used in monthly aggregation

Example records (note that the .txt file should not have a heading row).

| Period  		| lifeform		| abundance		| num_samples		|
| -------------   	|-------------	    	|-------------	  	|-------------	  	|
| 2017-05	  	| cilliate		| 0.4818		| 4			|
| 2017-06	  	| cilliate		| 4.2124		| 4			|
| 2017-07		| cilliate		| 3.5438		| 4			|
| ...			| ...			| ...			| ...			|
| 2017-05	  	| diatom		| 9659.75519878221	| 4			|
| 2017-06	  	| diatom		| 31736.4549733857	| 4			|
| 2017-07		| diatom		| 8265.58566611672	| 4			|


Example raw
```
"period","lifeform","abundance","num_samples"
"2017-05","cilliate",0.4818,4
"2017-06","cilliate",4.2124,4
"2017-07","cilliate",3.5438,4
...
"2017-05","diatom",9659.75519878221,4
"2017-06","diatom",31736.4549733857,4
"2017-07","diatom",8265.58566611672,4
```

### Step 3: Run PH1 analysis
Run ```PH1_edito.R``` on ```data/PH1_edito_test``` and view results in ```../output_edito/```

----------------

## Supporting files
There are several files with supporting scripts, you do not need to run them. Do not modify unless you are sure what you are doing!

#### Supporting scripts
Contains R files holding a set of functions necessary for running the indicator script.
It is recommended not to modify the files in this folder unless the user is experienced with writing functions in R.

#### Search data lake
Scripts to search the EDITO data lake.

#### lookup tables
Lookup tables used for grouping EDITO data to lifeform groups.


## Credits
- DUC Leaders
	Rune Lagaisse (VLIZ)
	Willem Boone (VLIZ)
	Felipe Artigas (CNRS ULCO)
	Ankita Vaswani (Hereon)

- The PLET tool is developed by Matthew Holland and the original version is maintained on his [GitHub](https://github.com/hollam2/PH1_PLET_tool).

	**Citation**
	If you use this software, please cite it as:<br>
	*Holland, M. M. (2022). PH1_PLET_tool (Version 2.0). https://github.com/hollam2/PH1_PLET_tool*

- The modifications and extension for deployment in EDITO are developed by Willem Boone as part of the DTO-Bioflow project (See [GitHub](https://github.com/willem0boone/EDITO_PH1)).

- The DTO-Bioflow project is funded by the European Union under the Horizon Europe Programme, [Grant Agreement No. 101112823](https://cordis.europa.eu/project/id/101112823/results).


