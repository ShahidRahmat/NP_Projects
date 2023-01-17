#Programming I

###############################
#          Mission 4.2        #
#   Price of Museum Tickets   #
###############################

#Background
#==========
#Admission to Singapore museums is free for Singapore citizens (SC) and permanent residents (PR). 
#All others will have to pay $15 per entry.

#Write a Python program to calculate the price of tickets for a group of visitors consisting
#of SC, PR and others.
#
#The program is to prompt user for the total number visitors and the number of SCs and PRs
#calculate the total cost of the tickets,
#and display this cost.

#Important Notes
#===============
#1) Comment out ALL input prompts before submitting.
#2) You MUST use the following variables
#   - total_no_visitors
#   - num_SCandPR
#   - total_cost
#   - num_others
#total_no_visitors = int(input("What is the total number of visitors?: "))
#num_SCandPR = int(input("How many singaporeans and Permeanent residents are theres?: "))


#START CODING FROM HERE
#======================

#  Prompt and accept data from user.

#Calculate Ticket Cost
def calculate_cost(total_no_visitors, num_SCandPR):

    if (total_no_visitors - numSCandPR) = 0:        #Check number of other visitors
        total_cost = 0   #calculate total price of tickets
        print("The total price is $", total_cost) #Modify to display total price of tickets
    else:
        total_cost =  (total_no_visitors - numSCandPR) * 15   #calculate total price of tickets
        print("The price to pay is $", total_cost) #Modify to display that Admission is free for all        
    return total_cost #Do not remove this line

    
#Do not remove the next line
calculate_cost(total_no_visitors, num_SCandPR) 

#input 75,50 output 375
#input 75,75 output 0
