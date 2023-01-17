nameList = ["Tom", "Joe", "Mary", "John", "Bob", "Jane"]
name = input("Enter the name to search: ")
name = name.capitalize()
num = nameList.index(name)
print(f"The name {name} is found in position {(int(num)+1)} in the name list.")
