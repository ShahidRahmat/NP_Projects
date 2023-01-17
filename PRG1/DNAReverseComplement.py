#Programming I

#Programming I

#####################################
#      Mission 3.1                  #
#     DNA Reverse Complement        #
#####################################

#Background
#==========
#String Manipulation techniques are often applied in the field of DNA sequence analysis.
#In a double-stranded DNA, if the sequence of one of the strands is given from top to bottom,
#the sequence of other strand from bottom to top (reverse complement) can be found.

#The corresponding complement of each base that can occur in a DNA strand is as follows:
#A=T, C=G, G=C, T=A

#Therefore, if given a 7-base long DNA sequence ‘ACCGTCG’, the corresponding complement
#sequence is ‘TGGCAGC’. The reverse would be ‘CGACGGT’, which gives the sequence of the other
#DNA strand.

#Write a program that prompts for input of the sequence (7 base long) of a DNA strand in a
#double-stranded DNA,and displays the sequence of the other DNA strand.


#Important Notes
#===============
#1) Comment out ALL input prompts before submitting.
#2) You MUST (at least) use the following variables:
#   - dna1 (for given dna sequence)
#   - dna2 (for other dna sequence)
dna1 = str(input("Enter the DNA Sequence: "))

#START CODING FROM HERE
#======================

#The possible bases in a DNA sequence and their complements
base = 'ACGT'
complement = 'TGCA'
#Hint: There is no need to edit/remove the previous 2 lines.

#Prompt for input of one DNA sequence (variable name: dna1)

#Do not edit/remove the next line
def calculate_DNAReverseComplement(dna1):
    dna1 = dna1.replace('A', 't').replace('T', 'a').replace('C', 'g').replace('G', 'c')
    dnatemp = dna1.upper()
    print(dnatemp)
    dnaarray = []
    dna2 = ''
    for letter in dnatemp:
        dnaarray.append(letter)
    dnaarray.reverse()
    for letter2 in dnaarray:
        dna2 += letter2
    print(dna2)
    #Code to obtain dna2 from dna1
    #Modify to display the dna2



#Do not remove this line
calculate_DNAReverseComplement(dna1)




