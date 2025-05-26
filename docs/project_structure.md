---
layout: default
title: Project structure
---

## Table of Contents
- [Main page](index.md)
- [Native tool and data](PLET.md)
- [Onboarding in EDITO](EDITO.md)
- [project structure](project_structure.md)
- [How to use](usage.md)

## <img src="https://upload.wikimedia.org/wikipedia/commons/9/91/Octicons-mark-github.svg" alt="Git" width="100"/> Project code structure

The GitHub repo contains several directories. Each one is explained in the section below.
- R
- Data
- Deploy 
- Docs
- Output (generates while running the code)

![Diagram](https://docs.google.com/drawings/d/e/2PACX-1vSw8gP0827gjqY11ifvna1NS9Htj1C7dqARLy0KQzLt7azQUFn4BX5gIZ5LwP0jwhmg8EqPGJN_d79c/pub?w=960&h=720)

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