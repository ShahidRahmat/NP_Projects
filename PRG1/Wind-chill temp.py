#Side Quest 4.2

temp = float(input("Enter the outside temperature in Fahrenheit: "))
wind_speed = float(input("Enter the wind speed (miles/hr): "))

if temp >= -58 and temp <= 41 and wind_speed >2:
    wind_chill = 35.74 + (0.6215 * temp) - (35.75 * (wind_speed ** 0.16)) + (0.4275 * temp * (wind_speed ** 0.16))
    wind_chill = round(wind_chill, 2)
    print("The wind-chill index is ", wind_chill)
else:
    print("Incorrect Input")
