#Caesar Cipher
orig = input("string: ")
shift = int(input("no: "))
textlist = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q','R', 'S', 'T','U', 'V', 'W', 'X', 'Y', 'Z']
def caesarEncrypt(orig, shift):
    encrypted = str("")
    for letter in orig:
        num = textlist.index(letter)
        newnum = num + shift
        if newnum > 25:
            newnum = newnum - 26
        encrypted += (textlist[newnum])
    print(encrypted)
    return encrypted

caesarEncrypt(orig,shift)
