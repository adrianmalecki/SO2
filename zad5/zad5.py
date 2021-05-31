import random

the_board = {1: ' ', 2: ' ', 3: ' ',
             4: ' ', 5: ' ', 6: ' ',
             7: ' ', 8: ' ', 9: ' '}


def print_board(board):
    print(board[1] + '|' + board[2] + '|' + board[3])
    print('-+-+-')
    print(board[4] + '|' + board[5] + '|' + board[6])
    print('-+-+-')
    print(board[7] + '|' + board[8] + '|' + board[9])


def choose_sign():
    choice = 0
    while choice == 0:
        print('\'O\' czy \'X\'')
        choice = input('Twój wybór: ')
        if choice in ('o', 'O'):
            player = 'O'
            computer = 'X'
            return player, computer
        elif choice in ('x', 'X'):
            player = 'X'
            computer = 'O'
            return player, computer
        else:
            choice = 0


def is_moves_left():
    for i in range(1, 10):
        if the_board[i] == ' ':
            return True
    return False


def minimax(depth, is_max, player, computer):
    if is_winner(computer):
        return 10
    elif is_winner(player):
        return -10

    if not is_moves_left():
        return 0

    if is_max:
        best = -1000
        for i in range(1, 10):
            if the_board[i] == ' ':
                the_board[i] = computer
                best = max(best, minimax(depth + 1, not is_max, player, computer))
                the_board[i] = ' '
        return best
    else:
        best = 1000

        for i in range(1, 10):
            if the_board[i] == ' ':
                the_board[i] = player
                best = min(best, minimax(depth + 1, not is_max, player, computer))
                the_board[i] = ' '
        return best


def best_move(player, computer):
    best_val = -1000
    best_move = -1

    for i in range(1, 10):
        if the_board[i] == ' ':
            the_board[i] = computer
            move_val = minimax(0, False, player, computer)
            the_board[i] = ' '
            if move_val > best_val:
                best_move = i
                best_val = move_val
    return best_move


def computer_move(player, computer):
    turn = computer
    move = best_move(player, computer)
    the_board[move] = turn
    return turn


def player_move(player):
    move = -1
    while move == -1:
        try:
            move = int(input('Wybierz pole: '))
        except ValueError:
            print('Wybierz liczbe')

        turn = player

        if 1 <= move <= 9:
            if the_board[move] == ' ':
                the_board[move] = turn
            else:
                move = -1
                print("Wybierz inne miejsce")
        else:
            move = -1
            print("Wybierz inne miejsce")
    return turn


def is_winner(mark):
    if the_board[1] == the_board[2] == the_board[3] == mark:
        return True
    if the_board[4] == the_board[5] == the_board[6] == mark:
        return True
    if the_board[7] == the_board[8] == the_board[9] == mark:
        return True
    if the_board[1] == the_board[4] == the_board[7] == mark:
        return True
    if the_board[2] == the_board[5] == the_board[8] == mark:
        return True
    if the_board[3] == the_board[6] == the_board[9] == mark:
        return True
    if the_board[1] == the_board[5] == the_board[9] == mark:
        return True
    if the_board[3] == the_board[5] == the_board[7] == mark:
        return True
    return False


def main():
    number_of_moves = 0
    player, computer = choose_sign()
    print_board(the_board)
    who = random.randint(0, 1)
    if who == 0:
        print('Zaczyna komputer')
        turn = computer
    if who == 1:
        print('Zaczynasz')
        turn = player

    while number_of_moves <= 8:
        if turn == computer:
            computer_move(player, computer)

            number_of_moves += 1
            turn = player
            if is_winner(computer):
                print('Przegrywasz')
                break

            if is_winner(player):
                print('Wygrywasz')
                break

            if is_winner(player) is False and is_winner(computer) is False and number_of_moves == 8:
                print('Remis')
                break
            print_board(the_board)
            print('------------------')

        if turn == player:
            player_move(player)
            number_of_moves += 1
            turn = computer
            if is_winner(computer):
                print('Przegrywasz')
                break
            if is_winner(player):
                print('Wygrywasz')
                break

            if is_winner(player) is False and is_winner(computer) is False and number_of_moves == 8:
                print('Remis')
                break
            print_board(the_board)
            print('------------------')
    print('Koniec gry')


if __name__ == '__main__':
    main()
