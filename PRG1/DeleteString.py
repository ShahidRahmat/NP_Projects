string = str(input('Enter the original string: '))
sub = str(input('Enter the substring to delete: '))
newstring = string.replace(sub, '', 1)
print(f'The modified string is {newstring}')
