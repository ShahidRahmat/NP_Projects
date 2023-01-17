import random

#SCORING SYSTEM
def check_monument(row, column):
    max_row = (len(city) -1)
    max_col = (len(city[0]) -1)
    if (row == 0 or row == max_row) and (column == 0 or column == max_col):
        score = 2
    else:
        score = 1
    return score

def check_monlist(mon_scores):
    mon_list = []
    two_count = 0
    for i in mon_scores:
        if i ==2:
            two_count += 1
    if two_count >= 3:
        for i in mon_scores:
            mon_list.append(4)
    else:
        mon_list = mon_scores
    return mon_list

def check_factory(factories):
    fac_count = []
    if factories > 4:
        score = 16 + (factories - 4)
        for i in range(4):
            fac_count.append(4)
        for l in range(factories - 4):
            fac_count.append(1)
    elif factories <= 4:
        score = factories ** 2
        for i in range(factories):
            fac_count.append(factories)
    return [score, fac_count]

def check_beach(box):
    #Gets the score for the beach
    furthest = (len(city[0]) - 1)
    if (box == 0) or (box == furthest):
        points = 3
    else:
        points = 1
    return points

def check_house(line, box):
    #Gets the score for the house
    house_score = 0
    house_list = []
    if line != (len(city)-1):
        house_list.append(city[line+1][box])
    if line != 0:
        house_list.append(city[line-1][box])
    if box != (len(city[0])-1):
        house_list.append(city[line][box+1])
    if box != 0:
        house_list.append(city[line][box-1])
    for i in house_list:
        if i == "HSE":
            house_score += 1
        elif i == "SHP":
            house_score += 1
        elif i == "BCH":
            house_score += 2
        else:
            house_score += 0
    if 'FAC' in house_list:
        house_score = 1
    return house_score

def check_shop(line, box):
    # Gets the score for the shop
    shop_atm = {"SHP": 0, "BCH": 0, "HSE": 0, "HWY": 0, "FAC": 0, "   ": 0,"MON":0}
    type_count = 0
    house_score = 0
    if line != (len(city)-1):
        shop_atm[(city[line+1][box])] += 1
    if line != 0:
        shop_atm[(city[line-1][box])] += 1
    if box != (len(city[0])-1):
        shop_atm[(city[line][box+1])] += 1
    if box != 0:
        shop_atm[(city[line][box-1])] += 1
    for key in shop_atm.keys():
        if key != "   ":
            if shop_atm[key] > 0:
                type_count += 1
    return type_count

def check_highway(line):
    # Gets the score for the highway
    hwy_count = []
    count = 0
    score = 0
    for i in range(len(city[line])):
        if city[line][i] == 'HWY':
            count += 1
        else:
            hwy_count.append(count)
            count = 0
    hwy_count.append(count)
    for l in hwy_count:
        if l != 0:
            score += (l ** 2)
    return [score, hwy_count]

def check_scores():
    # Gets the scores for the city
    hwy_score = []
    shp_score = []
    hse_score = []
    bch_score = []
    mon_score = []
    factory_count = 0
    total_score = 0
    for line in range(len(city)):
        highway_score = check_highway(line)
        hwy_count = highway_score[1]
        for a in hwy_count:
            for b in range(a):
                hwy_score.append(a)
        total_score += highway_score[0]
        for box in range(len(city[line])):
            building = city[line][box]
            if building == 'FAC':
                factory_count += 1
            if building == 'BCH':
                score = check_beach(box)
                bch_score.append(score)
                total_score += score
            if building == 'SHP':
                score = check_shop(line, box)
                shp_score.append(score)
                total_score += score
            if building == 'HSE':
                score = check_house(line, box)
                hse_score.append(score)
                total_score += score
            if building == "MON":
                score = check_monument(line,box)
                mon_score.append(score)
    mon_list = check_monlist(mon_score)
    factory_countscores = check_factory(factory_count)
    fac_score = factory_countscores[0]
    fac_list = factory_countscores[1]
    total_score += fac_score
    for i in mon_list:
        total_score += i
    return [total_score, shp_score, bch_score, hse_score, hwy_score, fac_list, mon_list]

def check_boxes():
    #Checks the city to get the number of spaces available
    boxescount = 0
    for line in range(len(city)):
        for box in range(len(city[line])):
            if ' ' not in city[line][box]:
                boxescount += 1
    return boxescount

def addScore(name, score, scores):
    #Adds the score to the leaderboard
    for i in range(len(scores)):
        currentscore = int(scores[i][1])
        if currentscore < score:
            position = i
            posleft = 10 - position
            try:
                for l in range(posleft):
                    a = (10 - l) - 1
                    scores[a] = scores[a - 1]
                scores[position] = [name, score]
                SaveScores(scores)
                print(f"Congrats! You made the leaderboard at position {(i + 1)} with a score of {score}")
                print()
                break
            except:
                pass

def searchScore(score, scores):
    #Searches the leaderboard to check if the score is high enough
    added_score = False
    for i in range(len(scores)):
        currentscore = int(scores[i][1])
        if currentscore < score:
            name = str(input("Please enter a name: "))
            addScore(name, score, scores)
            added_score = True
            break
    return added_score

# Saving
def SaveGame():
    #Save the game to a file
    file = open("SimpCityGame.txt", "w")
    file.seek(0)
    file.truncate()
    file.write(str(city)+"\n")
    file.write(str(buildings))

def OpenGame():
    #Opens the game from a save file
    try:
        file = open("SimpCityGame.txt", "r")
        for line in file:
            line = line.strip("\n")
            if ":" not in line:
                gamemap = eval(line)
            elif ":" in line:
                buildings = eval(line)        
    except:
        print("You do not have a saved city.\nA new city has been loaded for you.")
        gamemap = [['   ', '   ', '   ', '   '], ['   ', '   ', '   ', '   '], ['   ', '   ', '   ', '   '], ['   ', '   ', '   ', '   ']]
        buildings = {"SHP": 8, "BCH": 8, "HSE": 8, "HWY": 8, "FAC": 8, "MON":8}
    return [gamemap, buildings]

def SaveScores(scores):
    #Saves the leaderboard to a file
    file = open("SCG_Scores.txt", "w")
    file.seek(0)
    file.truncate()
    for position in scores:
        for score in position:
            file.write(str(score) + "\n")
        file.write("Next pos" + "\n")
    return scores

def OpenScores():
    #Gets a leaderboard from the file
    try:
        file = open("SCG_Scores.txt", "r")
        scores = []
        position = []
        for line in file:
            line = line.strip("\n")
            if line != "Next pos":
                position.append(line)
            else:
                scores.append(position)
                position = []
    except:
        new_scores = [["Nil", 0],["Nil", 0],["Nil", 0],["Nil", 0],["Nil", 0],["Nil", 0],["Nil", 0],["Nil", 0],["Nil", 0],["Nil", 0]]
        scores = SaveScores(new_scores)
    return scores

#PRINTING

def print_buildings():
    #Prints the buildings available
    print(f"{'Building':<20}{'Remaining':<15}")
    print(f"{('-' * 8):<20}{('-' * 9):<15}")
    for key in buildings.keys():
        print("{:<20}{:<15}".format(key, buildings[key]))

def print_city():
    #Prints the city
    alphabets = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
    count = 1
    print("  ", end = "")
    for i in range(len(city[0])):
        print("{:>6}".format(alphabets[i].upper()), end = "")
    print()
    print("    " + ("+-----" * (len(city[0])) + "+"))
    for r in range(len(city)):
        print("{:<4}".format(count), end="")
        for c in range(len(city[0])):
            print("| {} ".format(city[r][c]), end='')
        count += 1
        print("|")
        print("    " + ("+-----" * (len(city[0]))) + "+")

def print_scores(scores):
    #Prints the leaderboard
    line = ("-" * 3)
    print(line * 3, "HIGH SCORES", line * 3)
    print("{:<4}{:<22}{:<5}".format("Pos", "Player", "Score"))
    for i in range(len(scores)):
        print("{:<4}{:<22}{:<5}".format((i + 1), scores[i][0], scores[i][1]))
    print()

def print_current_scores():
    #Prints the current score
    scorecheck = check_scores()
    print_building_list = ["SHP", "BCH", "HSE", "HWY", "FAC","MON"]
    tot_score = 0
    for i in range(len(print_building_list)):
        if len(scorecheck[(i + 1)]) > 0:
            score = 0
            string = ""
            string += (str(print_building_list[i]) + ": ")
            for l in scorecheck[(i + 1)]:
                string += (str(l) + " + ")
                score += l
            string = string.rstrip(" + ")
            string += (" = " + str(score))
            print(string)
            tot_score += score
        else:
            pass
    print(f"Total Score: {tot_score}") 

#GETTING AND CHECKING OPTIONS
def explain_game():
  print("\nFor this game, your objective is to fill up the city.\nYou can set your own grid size, or you can start off with a default 4x4 grid.\
\nAfter the first turn, you may only print on places with buildings adjacent to it.\nAt the end of the game, if your score is high enough, \
you will be added onto our leaderboard.\nThere are six building types available:\nHWY: \
Highway\nBCH: Beach\nSHP: Shop\nHSE: House\nFAC: Factory\nMON: Monument\nIf at any point you need to leave, you can save the game and come back at a later time. \nHave fun!\n")
  
def check_choice(plot):
    #Checks if the choice for the grid is valid
    rowlist = []
    for i in range(len(city)):
        rowlist.append(str(i+1))
    alphabets = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
    heightlist = []
    for l in range(len(city[0])):
        heightlist.append(alphabets[(l)])
    choicelength = (1 + len(str(len(city))))
    message = ""
    choice_width = ""
    choice_height = 0
    row = plot.strip(plot[0])
    choice = [plot[0], row]
    if ((1 < len(choice) <= choicelength) and ((choice[0].lower()) in heightlist) and (choice[1] in rowlist)):
        width = choice[0]
        choice_height = ((int(row)) - 1)
        choice_width = (alphabets.index((str(choice[0])).lower()))
        if city[choice_height][choice_width] == "   ":
            proceed = True
        else:
            proceed = False
            message = "There is already a building there"
    else:
        message = "Invalid input"
        proceed = False
    return [proceed, message, choice_width, choice_height]

def choose_type(buildings):
    #Gets a random building
    building_types = []
    for key in buildings.keys():
        if buildings[key] > 0:
            for i in range(int(buildings[key])):
                building_types.append(key)
    type_no = random.randint(1, len(building_types))
    b1 = building_types[(type_no) - 1]
    type_no2 = random.randint(1, len(building_types))
    b2 =  building_types[(type_no2) - 1]
    b_type = [b1,b2]
    return b_type

def remove_building(types):
    #Removes 1 count for the building type if chosen
    buildings[(buildinglist[0])] -= 1
    buildings[(buildinglist[1])] -= 1

def makeBuildings(city):
    boxes = len(city) * len(city[0])
    if (boxes%2) != 0:
        boxes += 0.5
    buildings = {"SHP": 8, "BCH": 8, "HSE": 8, "HWY": 8, "FAC": 8, "MON":8}
    for key in buildings.keys():
        buildings[key] = int(boxes/2)
    return buildings

def makeCity():
    #Customises city size
    city = []
    numRow = 0
    numCol = 0
    while True:
        try:
            numRow = int(input("Enter the number of rows: "))
            numCol = int(input("Enter the number of columns: "))
        except:
            print("Invalid input.")
        if ((0<numRow) and (numCol > 0)):
            if (numRow == 1) and (numCol == 1):
                print("Only one of the values can be 1.")
            else:
                if (numCol <= 26):
                    break
                elif (numCol > 26):
                    print("You can only have a maximum of 26 columns.")
        else:
            print("None of the values can be 0.")
    for i in range(numRow):
        row = []
        for l in range(numCol):
            row.append('   ')
        city.append(row)
    return city
#CHECKING SURROUNDINGS
def check_building(check_height, check_width):
    #Checks if there is a building beside it
    surroundings = []
    proceed = False
    rownum = len(city)
    colnum = len(city[0])
    if check_height != (rownum-1):
        surroundings.append(city[check_height+1][check_width])
    if check_height != 0:
        surroundings.append(city[check_height-1][check_width])
    if check_width != (colnum-1):
        surroundings.append(city[check_height][check_width+1])
    if check_width != 0:
        surroundings.append(city[check_height][check_width-1])
    for i in surroundings:
        if i != '   ':
            proceed = True
            break
        
    return proceed

#PLAYING THE GAME

# Main Menu
while True:
    print("Welcome, mayor of Simp City!")
    print("-" * 28)
    print("{:<3} {:<25}".format('1.','Start new game'))
    print("{:<3} {:<25}".format('2.', 'Load saved game'))
    print("{:<3} {:<25}".format('3.','Show high scores'))
    print("{:<3} {:<25}".format('4.', 'Exit Game'))
    print("{:<3} {:<25}".format('5.', 'See Instructions'))
    print('{:<3} {:<25}'.format('6.','Make your own city'))
    #Prints the main menu
    main_option = input("Enter an option: ")
    if (main_option in ['1', '2', '3', '4','5','6']):
        #Checks that the input is valid
        main_option = int(main_option)
        if main_option == 1:
            city = [['   ', '   ', '   ', '   '], ['   ', '   ', '   ', '   '], ['   ', '   ', '   ', '   '], ['   ', '   ', '   ', '   ']]
            buildings = {"SHP": 8, "BCH": 8, "HSE": 8, "HWY": 8, "FAC": 8, "MON":8}
            turn_count = 0
        if main_option == 2:
            city = OpenGame()[0]
            buildings = OpenGame()[1]
            turn_count = check_boxes()
        if main_option == 3:
            print_scores(OpenScores())
            continue
        if main_option == 4:
            print("You have exited the game.")
            break
        if main_option == 5:
            explain_game()
            continue
        if main_option == 6:
            turn_count = 0
            city = makeCity()
            buildings = makeBuildings(city)
            print("Note: Your score will not be eligible for our leaderboard if it is not a 4x4 grid.")
    else:
        print("Invalid input")
        continue
    #PLAYING THE GAME
    while True:
        if turn_count > ((len(city) * len(city[0]))-1):
            #Ends the game when all  boxes are filled
            print_city()
            if ((len(city) == 4) and (len(city[0]) == 4)):
                if searchScore(check_scores()[0], OpenScores()):
                    print_current_scores()
                    print_scores(OpenScores())
                else:
                    print_current_scores()
                    print("You have finished the game.")
            else:
                print("Your grid was not a 4x4 grid and hence will not be saved to our leaderboard.")
                print_current_scores()
                print("You have finished the game.")
            break
        else:
            #Runs the game
            print(f"Turn {(turn_count + 1)}")
            print_city()
            buildinglist = choose_type(buildings)
            print("1. Build a {}".format(buildinglist[0]))
            print("2. Build a {}".format(buildinglist[1]))
            print("3. See remaining buildings.")
            print("4. See current score.")
            print("\n5. Save Game")
            print("0. Exit to main menu")
            next_option = input("Enter an option: ")
            if (next_option in ['1', '2', '3', '4', '5', '0']):
                next_option = int(next_option)
                if (next_option == 1) or (next_option == 2):
                    choice = input("Where would you like to build: ")
                    if check_choice(choice)[0]:
                        choice_height = check_choice(choice)[3]
                        choice_width = check_choice(choice)[2]
                        if turn_count == 0:
                            city[choice_height][choice_width] = buildinglist[(next_option -1)]
                            remove_building(buildinglist)
                            turn_count += 1
                        elif turn_count > 0:
                            if check_building(choice_height, choice_width):
                                city[choice_height][choice_width] = buildinglist[(next_option - 1)]
                                remove_building(buildinglist)
                                turn_count += 1
                            else:
                                print("There is no adjacent building.")
                    else:
                        print(check_choice(choice)[1])
                if (next_option == 3):
                    print_buildings()
                if (next_option == 4):
                    print_current_scores()
                if (next_option == 5):
                    print("Your game has been saved.")
                    SaveGame()
                if (next_option == 0):
                    print("You have exited to the main menu.")
                    break
                print()
            else:
                print("Not a valid input.")
                print()
