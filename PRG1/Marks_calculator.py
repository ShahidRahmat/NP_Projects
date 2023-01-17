
#Exercise 3
'''
Prompt for common test marks
Get common test marks
Prompt for assignment test marks
get assignment test marks
Prompt for continuous assessment marks
get continuous assessment marks
calculate final = common test * 0.3 + assignment * 0.3 + continuous * 0.4
print final marks

'''
student = input("Enter your student number(No letters): ")
common = int(input("Enter your common test marks: "))
assignment = int(input("Enter your assignment marks: "))
continuous = int(input("Enter your continuous assessment marks: "))
final = 0.3*common+0.3*assignment+0.4*continuous
print('{:12s}{:13s}{:12s}{:12s}{:12s}'.format('Student No', 'Common Test', 'Assignment', 'CA', 'Final'))
print('{:12s}{:<13d}{:<12d}{:<12.2f}{:<12.2f}'.format(student, common, assignment, continuous, final))


