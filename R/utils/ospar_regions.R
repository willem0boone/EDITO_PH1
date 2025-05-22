library(sf)
library(httr)
library(jsonlite)

#' Check if a point lies within an OSPAR region
#'
#' This function downloads the OSPAR marine region GeoJSON, selects a region by ID (e.g., `"SNS"`),
#' and checks whether a given latitude/longitude point falls within the specified region's geometry.
#'
#' @param lat A numeric value representing the latitude of the point.
#' @param lon A numeric value representing the longitude of the point.
#' @param region_id A character string representing the OSPAR region ID to test against (e.g., `"SNS"`).
#'
#' @return A logical value (`TRUE` or `FALSE`) indicating whether the point is inside the region.
#' @export
#'
#' @examples
#' point_in_ospar_region(lat = 54.7, lon = -1.1, region_id = "SNS")
#' # Returns TRUE if the point is within the Southern North Sea region
point_in_ospar_region <- function(lat, lon, region_id = "SNS") {
  # Download and parse the GeoJSON
  geojson_url <- "https://odims.ospar.org/geoserver/odims/wfs?service=WFS&version=2.0.0&request=GetFeature&typeName=ospar_comp_au_2023_01_001&outputFormat=json"
  
  # Read GeoJSON into an sf object
  sf_data <- sf::st_read(geojson_url, quiet = TRUE)
  
  # Filter for the desired region ID
  region <- sf_data[sf_data$ID == region_id, ]
  
  if (nrow(region) == 0) {
    stop(paste("Region ID", region_id, "not found in GeoJSON."))
  }
  
  # Create an sf point for the given lat/lon
  point <- sf::st_sfc(sf::st_point(c(lon, lat)), crs = 4326) # (lon, lat) order!
  
  # Check if point is within the region polygon
  inside <- sf::st_within(point, region, sparse = FALSE)[1, 1]
  
  return(inside)
}


#' Load OSPAR Region Geometry by ID
#'
#' This function downloads and extracts a specific marine region geometry 
#' from the OSPAR GeoJSON WFS service using a provided region ID.
#'
#' The returned geometry is useful for spatial filtering or visualization
#' of marine data based on OSPAR maritime boundaries.
#'
#' @param region_id A character string specifying the region ID to extract 
#'        (e.g., `"SNS"`, `"SCHPM1"`). Default is `"SNS"`.
#'
#' @return An `sf` object representing the geometry of the selected region.
#'         If the region is not found, the function stops with an error.
#'
#' @examples
#' # Load the Southern North Sea (SNS) region
#' sns_region <- load_ospar_region("SNS")
#'
#' # Load another region
#' schpm_region <- load_ospar_region("SCHPM1")
#'
#' @export
load_ospar_region <- function(region_id = "SNS") {
  geojson_url <- "https://odims.ospar.org/geoserver/odims/wfs?service=WFS&version=2.0.0&request=GetFeature&typeName=ospar_comp_au_2023_01_001&outputFormat=json"
  
  sf_data <- sf::st_read(geojson_url, quiet = TRUE)
  region <- sf_data[sf_data$ID == region_id, ]
  
  if (nrow(region) == 0) {
    stop(paste("Region ID", region_id, "not found in GeoJSON."))
  }
  
  return(region)
}


