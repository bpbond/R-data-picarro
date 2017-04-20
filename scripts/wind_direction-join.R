# wind_direction-join

# Data in external `station_file` file:
# station      position
# station_1    0
# station_2    90
# station_3    180
# station_4    270

all_my_data %>%
  # round to nearest 90 degrees
  mutate(upwind_position = floor(wind_direction / 90) * 90) %>%  
  # look up correct stations to use
  left_join(station_file) %>%
  left_join(station_data, by = c("station", "timestamp"))

