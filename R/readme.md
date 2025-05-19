# User guidelines

## Getting started
It is recomended to run the ```R.proj``` file (an R project file) before to ensure that the working directory will automatically be set appropriately.

## Using PLET data
#### Get data
Go to [https://www.dassh.ac.uk/lifeforms/](https://www.dassh.ac.uk/lifeforms/) and download your data.
<br>
Store the data in 
```../data/lifeform.csv```

#### Run analysis
Run PH1-FW5_indicator_script_v2.Rmd on ```..data/lifeform.csv``` and view the results in ```../output```.

## Using EDITO data lake


#### Get EDITO data
Extract and format data from EDITO data lake. As an example, a pipeline doing this for of EurOBIS dataset 4687 is provided. 
<br>
Run ```get_data.R``` to extract and format this data, it will be stored in ```../data/PH1_edito_test.csv```.

<br>
This pipeline performs several reusable steps: 

- Search the occurrence parquet: <br>
	performs a STAC search and returns the latest version of the occurrence parquets.

```
source("search_data_lake/_search_STAC.R")
file occ = search_STAC()
```

- open the parquet: <br>
	This establishes the connection with the S3 bucket using S3FileSystem.
```
source("search_data_lake/_open_parquet.R")
dataset = open_my_parquet(my_parquet)
```

- Filter the parquet
```
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

#### Required data format
Once you have the occurrence data, it needs to be formatted in monthly aggregated lifeform groups. 
If you intend to write your own pipeline or bring your own data, this section will explain you how your data format should look like.

CSV file:
- "Period": YYYY-MM (e.g. 2021-01)
- "lifeform": str name of lifeform (eg. diatom)
- "abundance": abundance data (using '.' as decimal), monthly averaged. 
- "num_samples": int, number of samples used in monthly aggregation.

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

## Supporting files

#### Supporting scripts
Contains R files holding a set of functions necessary for running the indicator script.
It is recommended not to modify the files in this folder unless the user is experienced with writing functions in R.

#### Search data lake
Scripts to search the EDITO data lake.

#### lifeform lookup tables
Lookup tables used for grouping EDITO data to lifeform groups.


## Credits
- The PLET too is developed by Matthew Holland and the original version is maintained on his [GitHub](https://github.com/hollam2/PH1_PLET_tool).

	**Citation**
	If you use this software, please cite it as:<br>
	*Holland, M. M. (2022). *PH1_PLET_tool* (Version 2.0). https://github.com/hollam2/PH1_PLET_tool*

- The modifications and extension for deployment in EDITO are developed by Willem Boone as part of the DTO-Bioflow project (See [GitHub](https://github.com/willem0boone/EDITO_PH1)).

- The DTO-Bioflow project is funded by the European Union under the Horizon Europe Programme, [Grant Agreement No. 101112823](https://cordis.europa.eu/project/id/101112823/results).



