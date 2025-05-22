# PH1_PLET_tool
Status: onboarding the tool in EDITO, testing data pipelines and implementation strategy.

[Project Structure](https://github.com/willem0boone/EDITO_PH1/tree/main?tab=readme-ov-file#project-structure) 
- [Data](https://github.com/willem0boone/EDITO_PH1/tree/main?tab=readme-ov-file#data)
- [Deploy](https://github.com/willem0boone/EDITO_PH1/tree/main?tab=readme-ov-file#deploy)
- [Docs](https://github.com/willem0boone/EDITO_PH1/tree/main?tab=readme-ov-file#docs)
- [R](https://github.com/willem0boone/EDITO_PH1/tree/main?tab=readme-ov-file#r)
[Credits](https://github.com/willem0boone/EDITO_PH1/tree/main?tab=readme-ov-file#credits)

## Project structure

#### R
----------
The actual analysis scripts. See [How to use](usage.md) further instructions.


#### Data
----------
Directory where the source input data is stored. This can be:
- An export from [PLET database](https://www.dassh.ac.uk/lifeforms/) 
```
lifeform.csv
```

- An export from EDITO data lake. 
```
PH1_edito_test.csv
```

#### Output & output_edito
----------
Where the output will be stored, these directories will be created when running the scripts.


####  Deploy
----------
Contains script for installing dependencies. 
<br>
- Using R: 
```
install_dependencies.R
```
- Using shell
```
deploy_edito.sh
```


#### Docs
----------
Markdown documentation pages for [https://willem0boone.github.io/EDITO_PH1/](https://willem0boone.github.io/EDITO_PH1/).


## Credits
- The PLET too is developed by Matthew Holland and the original version is maintained on his [GitHub](https://github.com/hollam2/PH1_PLET_tool).

	**Citation**
	If you use this software, please cite it as:<br>
	*Holland, M. M. (2022). PH1_PLET_tool (Version 2.0). https://github.com/hollam2/PH1_PLET_tool*

- The modifications and extension for deployment in EDITO are developed by Willem Boone as part of the DTO-Bioflow project (See [GitHub](https://github.com/willem0boone/EDITO_PH1)).

- The DTO-Bioflow project is funded by the European Union under the Horizon Europe Programme, [Grant Agreement No. 101112823](https://cordis.europa.eu/project/id/101112823/results).