gender = str(input("Enter gender [M/F]: "))
age = int(input("Enter age: "))
traffic_a = input("Have you been in an accident before?[Y/N]")

if gender == 'M':
    if age < 25:
        premium = 1.8 * 800
    elif age >= 25 and age <= 34:
        premium = 800 * 1.5
    elif age >= 35 and age <= 44:
        premium = 800 * 1.2
    elif age >= 45 and age <= 54:
        premium = 800 * 1.0
    elif age >= 55 and age <= 64:
        premium = 800 * 1.4
    elif age >64:
        premium = 800 * 1.7
elif gender == 'F':
    if age < 25:
        premium = 1.4 * 800
    elif age >= 25 and age <= 34:
        premium = 800 * 1.3
    elif age >= 35 and age <= 44:
        premium = 800 * 1.1
    elif age >= 45 and age <= 54:
        premium = 800 * 0.9
    elif age >= 55 and age <= 64:
        premium = 800 * 1.2
    elif age >64:
        premium = 800 * 1.4

if traffic_a == 'Y':
    premium = premium + 300

print("Your annual premium is: $", premium)
   
