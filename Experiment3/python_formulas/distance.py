# Speed of light in meters per second
speed_of_light = 299792458  # m/s

# Input: TDOA in seconds (negative or positive)
tdoa = float(input("Enter TDOA in seconds: "))

# Calculate distance
distance = (abs(tdoa) * speed_of_light) / 2

print(f"The distance is: {distance} meters")

