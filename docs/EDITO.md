---
layout: default
title: Onboarding in EDITO
---

## Table of Contents
- [Main page](index.md)
- [Native tool and data](PLET.md)
- [Onboarding in EDITO](EDITO.md)
- [project structure](project_structure.md)
- [How to use](usage.md)

<img src="https://www.edito.eu/wp-content/uploads/2023/08/schema-1024x937.jpg" alt="Edito" width="500"/>

# PH1/FW5 indicator script in EDITO 
As part of [DTO-Bioflow](https://dto-bioflow.eu/) [DUC 3](https://dto-bioflow.eu/use-cases/duc-3-assessing-pelagic-biodiversity-and-human-impact), the original [PH1/FW5 indicator script](https://github.com/hollam2/PH1_PLET_tool) has been made available in EDITO. 
<br>
<br>
Furthermore, a demo pipeline shows how to search and harvest data from EDITO data lake. The data is preprocessed into monthly aggregated lifeform groups and analyzed using an modified version of the PH1/FW5 indicator script.

Go to [project structure](project_structure.md) to find the scripts and to [How to use](usage.md) to learn how to run this script.

# Importing PLET data in EDITO

There are 2 options:
- Use the database endpoint
- Harvest PLET package, a client to handle the database endpoint

## 1. Database endpoint
The PLET does not have a fully supported API, but it is possible to request data using this endpoint:
<br>
```
dassh.ac.uk/plet/cgi-bin/get_form.py
```
Information and examples how to query this endpoint can be found on [https://www.dassh.ac.uk/lifeforms/docs/automation_guidance.txt](https://www.dassh.ac.uk/lifeforms/docs/automation_guidance.txt)

An example of such an request:

| **Parameter**      | **Value**                                                                                                               |
|--------------------|-------------------------------------------------------------------------------------------------------------------------|
| Date               | `startdate=2000-01-01&enddate=2025-05-15`                                                                               |
| Spatial extent     | `wkt=POLYGON%20((-180%20-90,-180%2090,180%2090,180%20-90,-180%20-90))` → this means global extent                       |
| Dataset            | `abundance dataset=BE Flanders Marine Institute (VLIZ) - LW_VLIZ_zoo`                                                   |


```
https://www.dassh.ac.uk/plet/cgi-bin/get_form.py?startdate=2000-01-01&enddate=2025-05-15&wkt=POLYGON%20((-180%20-90,-180%2090,180%2090,180%20-90,-180%20-90))&abundance_dataset=BE%20Flanders%20Marine%20Institute%20(VLIZ)%20-%20LW_VLIZ_zoo&format=csv
```

## 2. Harvest PLET package
The package facilitates the request forming and handling. Extending the Database endpoint, this package handles following aspects:
- listing available datasets 
- forming & evaluating the request url
- some request result in long respons time, the package allow tweaking timeouts & retry config.

Read the docs on [https://harvest-plet.readthedocs.io/en/latest/](https://harvest-plet.readthedocs.io/en/latest/)\
GitHub source code: [https://github.com/willem0boone/harvest_plet/tree/main](https://github.com/willem0boone/harvest_plet/tree/main)


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