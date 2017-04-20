# wind_direction-if

if(wind_direction >= 0 & wind_direction < 90) {
  upwind <- station_1
  downwind <- station_3
} else if(wind_direction < 180) {
  upwind <- station_2
  downwind <- station_4
} else if(wind_direction < 270) {
  upwind <- station_3
  downwind <- station_1
} else if (wind_direction < 360) {
  upwind <- station_4
  downwind <- station_2
} else stop("Invalid wind_direction!")

flux <- downwind - upwind
