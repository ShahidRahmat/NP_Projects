seconds = int(input("Enter the number of seconds: "))
orig_s = seconds
hours = seconds // 3600
seconds = seconds - (hours * 3600)
minutes = seconds // 60
seconds = seconds - (minutes * 60)
print(orig_s," seconds is ",hours," hour(s), ",minutes," minutes and ",seconds," seconds.")
