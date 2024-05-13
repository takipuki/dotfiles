
#include "./login.c"
// #include "login.h"
#include <ncurses.h>
#include <stdio.h>
#include <string.h>

WINDOW *winX;
WINDOW *winY;
WINDOW *winZ;

int main()
{

    initscr();
    // noecho();
    cbreak();
    curs_set(0);
    keypad(stdscr, TRUE);
    start_color();
    init_pair(1, COLOR_BLACK, COLOR_WHITE);
    init_pair(2, COLOR_RED, COLOR_WHITE);
    init_pair(3, COLOR_YELLOW, COLOR_GREEN);
    init_pair(4, COLOR_BLUE, COLOR_RED);
    init_pair(5, COLOR_WHITE, COLOR_MAGENTA);
    init_pair(6, COLOR_CYAN, COLOR_GREEN);
    init_pair(7, COLOR_WHITE, COLOR_BLACK);

    int yMax, xMax;
    getmaxyx(stdscr, yMax, xMax);

    char *usrCredentials[] = {"Create an Account", "Login", "Exit"};
    // Refresh the new window

    bool chck_login = FALSE;
    int ch = 0;
    int highlight = 1;
    int choice = 1;
    bool repeat = TRUE;
    while (repeat)
    {
        WINDOW *win1 = newwin(10, xMax / 2, 10, xMax / 4);
        box(win1, 0, 0);
        refresh();
        keypad(win1, TRUE);
        wrefresh(win1);
        while (1)
        {

            for (int i = 1; i < 4; i++)
            {
                if (i == highlight)
                {
                    wattron(win1, A_REVERSE);
                }
                mvwprintw(win1, i, 1, "%d.%s", i, usrCredentials[i - 1]); // highlight the selected option
                wattroff(win1, A_REVERSE);
            }

            wrefresh(win1);

            ch = getch(); // Get user input

            switch (ch)
            {
            case KEY_UP:
                highlight--;
                if (highlight == 0)
                {
                    highlight = 3;
                }
                break;
            case KEY_DOWN:
                highlight++;
                if (highlight == 4)
                {
                    highlight = 1;
                }
                break;
            case 10: // Enter key
                break;
            }
            // check if the user has selected an option
            if (highlight == 1 && ch == 10)
            {
                chck_login == FALSE;
                curs_set(1); // Show the cursor (for user input
                char username[50];
                char password[50];
                WINDOW *win2 = newwin(20, xMax / 2, 10, xMax / 3); // Create a new window
                box(win2, 0, 0);

                clear();
                refresh();
                wattron(win2, COLOR_PAIR(1));
                mvwprintw(win2, 1, xMax / 6, "You are in %s Page", usrCredentials[highlight - 1]);
                wattroff(win2, COLOR_PAIR(1));
                wrefresh(win2);
                delwin(win2);
                // clear();
                refresh();

                //  New window for User Name prompt
                WINDOW *win3 = newwin(5, xMax / 4, 14, xMax / 3 + 4); // Create a new window
                box(win3, 0, 0);
                wrefresh(win3);
                mvwprintw(win3, 1, 1, "Enter your username: ");
                wrefresh(win3);
                mvwgetstr(win3, 2, 1, username); // Get user input for username
                remove_Newline(username);        // Remove the newline character from the username
                wrefresh(win3);
                delwin(win3);

                // create new window for password prompt
                WINDOW *win4 = newwin(5, xMax / 4, 20, xMax / 3 + 4);
                box(win4, 0, 0);
                wrefresh(win4);
                mvwprintw(win4, 1, 1, "Enter your password: ");
                wrefresh(win4);
                mvwgetstr(win4, 2, 1, password); // Get user input for password
                remove_Newline(password);
                delwin(win4);
                // Check If User didnot enter username or password
                if (username[0] == '\0' || password[0] == '\0' || username[0] == '\n' || password[0] == '\n')
                {
                    clear();
                    refresh();
                    winX = newwin(10, xMax / 2, 10, xMax / 4);
                    box(winX, 0, 0);
                    wattron(winX, COLOR_PAIR(2));
                    mvwprintw(winX, 5, xMax / 5 - 10, "  Halarputro Valid Username Password de !  ");
                    wattroff(winX, COLOR_PAIR(2));
                    wrefresh(winX);
                    getch();
                    delwin(winX);
                    break;
                }
                else
                {
                    // create a new user
                    User user = create_user(username, password, "w");
                    clear();
                    refresh();

                    // Print the username and password in the output window
                    WINDOW *win5 = newwin(10, xMax / 2, 10, xMax / 4);
                    box(win5, 0, 0);
                    refresh();
                    wrefresh(win5);
                    curs_set(0);
                    wattron(win5, COLOR_PAIR(1));
                    mvwprintw(win5, 1, 10, " Account Created Successfully! ");
                    wattroff(win5, COLOR_PAIR(1));
                    mvwprintw(win5, 3, 16, "Your Username: %s", user.username);
                    mvwprintw(win5, 5, 16, "Your Password: %s", user.password);
                    wrefresh(win5);
                    getch();
                    delwin(win5);
                    clear();
                    wrefresh(win1); // Refresh the win1 window to make it visible again

                    break;
                }
            }
            else if (highlight == 2 && ch == 10)
            {
                curs_set(1); // Show the cursor
                char username[50];
                char password[50];
                clear();
                WINDOW *win2 = newwin(20, xMax / 2, 10, xMax / 3); // Create a new window
                box(win2, 0, 0);

                refresh();
                wattron(win2, A_REVERSE); // Highlight the selected option
                mvwprintw(win2, 1, xMax / 6, " You are in %s Page ", usrCredentials[highlight - 1]);
                wattroff(win2, A_REVERSE); // Turn off highlighting
                wrefresh(win2);

                // New window for User Name prompt
                WINDOW *win3 = newwin(5, xMax / 4, 14, xMax / 3 + 4); // Create a new window
                box(win3, 0, 0);
                wrefresh(win3);
                mvwprintw(win3, 1, 1, "Enter your username: ");
                wrefresh(win3);
                mvwgetstr(win3, 2, 1, username); // Get user input for username
                remove_Newline(username);        // Remove the newline character from the username
                wrefresh(win3);
                delwin(win3);

                // New window for Password prompt
                WINDOW *win4 = newwin(5, xMax / 4, 20, xMax / 3 + 4); // Create a new window
                box(win4, 0, 0);
                mvwprintw(win4, 1, 1, "Enter your password: ");
                wrefresh(win4);
                mvwgetstr(win4, 2, 1, password); // user  password
                wrefresh(win4);
                delwin(win4);
                remove_Newline(password); // Remove the newline character from the password
                User user = match_usr(username, password, "r");
                clear(); // clear the screen
                refresh();

                // CHECK IF THE USER IS VALID OR NOT
                WINDOW *win5 = newwin(10, xMax / 2, 10, xMax / 4); // New win
                box(win5, 0, 0);
                refresh();
                if (strcmp(user.username, username) == 0 && strcmp(user.password, password) == 0 && user.username[0] != '\0' && user.password[0] != '\0')
                {
                    chck_login = TRUE;
                }
                else
                {

                    wattron(win5, COLOR_PAIR(2) | A_REVERSE);
                    mvwprintw(win5, 1, 15, "Login Failed!");
                    wattroff(win5, COLOR_PAIR(2) | A_REVERSE);
                    wrefresh(win5);
                    mvwprintw(win5, 3, 15, "Invalid Username or Password.");
                    wrefresh(win5);
                    mvwprintw(win5, 5, 15, "Please try again.");
                    wrefresh(win5);
                    chck_login = FALSE;
                    delwin(win5);
                    getch();
                    clear();
                    refresh();
                }

                delwin(win2);
                break;
            }
            else if (highlight == 3 && ch == 10)
            {
                clear();
                WINDOW *win2 = newwin(20, xMax / 2, 10, xMax / 3); //  new window
                box(win2, 0, 0);
                refresh();
                start_color();
                init_pair(1, COLOR_GREEN, COLOR_BLACK);
                wattron(win2, COLOR_PAIR(1));
                mvwprintw(win2, 10, xMax / 6, "You have Exited Successfully!");
                wattroff(win2, COLOR_PAIR(1));
                wrefresh(win2);
                delwin(win2);
                getch();
                repeat = FALSE;
                chck_login = FALSE;
                break;
            }

        } // second while end
          // ************************************************************ CHECK LOGIN ****************************************************************
        if (chck_login == TRUE && highlight == 2)

        {
            char *options[] = {"1.Generate Passowrd  ", "2.Show Passowrd  ", "3.Save Password  ", "4.Remove Passowrd", "5.Exit  "};

            while (1)
            {

                curs_set(0);
                WINDOW *win6 = newwin(20, xMax / 2 - 10, 10, xMax / 4);
                box(win6, 0, 0);
                refresh();
                wrefresh(win6);

                wattron(win6, COLOR_PAIR(5));
                mvwprintw(win6, 1, xMax / 6, "  Login Successful!  ");
                wattroff(win6, COLOR_PAIR(5));
                wrefresh(win6);

                for (int i = 1; i < 6; i++)
                {
                    if (i == choice)
                    {
                        wattron(win6, A_REVERSE);
                    }
                    mvwprintw(win6, i + 3, 1, "%s", options[i - 1]);
                    wattroff(win6, A_REVERSE);
                }
                wrefresh(win6);
                int inpt = getch();

                switch (inpt)
                {
                case KEY_UP:
                    choice--;
                    if (choice == 0)
                    {
                        choice = 5;
                    }

                    break;

                case KEY_DOWN:
                    choice++;
                    if (choice == 6)
                    {
                        choice = 1;
                    }
                    break;
                case 10:
                    break;
                default:
                    break;
                }

                delwin(win6);
                ///******************************** GENERATE PASSWORD ********************************
                if (choice == 1 && inpt == 10)
                {

                    curs_set(1);
                    winX = newwin(10, xMax / 2, 10, xMax / 4);
                    box(winX, 0, 0);
                    clear();
                    refresh();
                    wrefresh(winX);
                    mvwprintw(winX, 1, 1, "  Enter Password Length:  ");
                    wrefresh(winX);
                    char passLength[10];
                    mvwgetstr(winX, 2, 1, passLength);
                    int length = atoi(passLength); // Convert string to integer
                    User pass = generatePassword(length);
                    mvwprintw(winX, 3, 1, "  Generated Password:%s ", pass.password);
                    // noecho();
                    wrefresh(winX);
                    mvwprintw(winX, 5, 1, "  Press any key to continue...  ");
                    wrefresh(winX);
                    getch();
                    clear();
                    delwin(winX);
                }
                //----------------------------------------------------------------Show Password---------------------------------------------------
                else if (choice == 2 && inpt == 10)
                {
                    bool repeat_ShowPass = TRUE;
                    while (repeat_ShowPass)
                    {
                        clear();
                        refresh();
                        winX = newwin(10, xMax / 2, 10, xMax / 4); // For not reassiging the window i got a stupid "Segmentation fault" error
                        box(winX, 0, 0);
                        wrefresh(winX);
                        char *shw_Pass_Options[100] = {"1.Show Specific Password", "2.Show All Password", "3.Back to pervious menu"};
                        int chose_Pass_Option = 1;
                        bool repeat_Pass_Chose = TRUE;
                        while (repeat_Pass_Chose)
                        {
                            winX = newwin(10, xMax / 2, 10, xMax / 4);
                            box(winX, 0, 0);
                            refresh();
                            wrefresh(winX);
                            for (int i = 1; i < 4; i++)
                            {
                                if (i == chose_Pass_Option)
                                {
                                    wattron(winX, A_REVERSE);
                                }
                                mvwprintw(winX, i + 3, 1, "%s", shw_Pass_Options[i - 1]);
                                wattroff(winX, A_REVERSE);
                            }
                            wrefresh(winX);
                            int inpt = getch();
                            switch (inpt)
                            {
                            case KEY_UP:
                                chose_Pass_Option--;
                                if (chose_Pass_Option == 0)
                                {
                                    chose_Pass_Option = 3;
                                }
                                break;
                            case KEY_DOWN:
                                chose_Pass_Option++;
                                if (chose_Pass_Option > 3)
                                {
                                    chose_Pass_Option = 1;
                                }
                                break;
                            case 10:
                                break;
                            default:
                                break;
                            }
                            //*******************************************Show Specific Password********************************************
                            if (chose_Pass_Option == 1 && inpt == 10)
                            {
                                curs_set(1);
                                winY = newwin(10, xMax / 2, 10, xMax / 4);
                                box(winY, 0, 0);
                                refresh();
                                wrefresh(winY);
                                mvwprintw(winY, 1, 1, "  Enter the website name:  ");
                                wrefresh(winY);
                                char website[50];
                                mvwgetstr(winY, 2, 1, website);

                                if (website[0] == '\n' || website[0] == '\0')
                                {
                                    mvwprintw(winY, 3, 1, "  Please enter a valid website name. ");
                                    wrefresh(winY);
                                    getch();
                                }
                                else
                                {

                                    showSpecificPass(website);
                                }

                                repeat_Pass_Chose = FALSE;
                                delwin(winY);
                            }
                            else if (chose_Pass_Option == 2 && inpt == 10)

                            {

                                shwPass();
                                repeat_Pass_Chose = FALSE;
                            }
                            else if (chose_Pass_Option == 3 && inpt == 10)
                            {
                                clear();
                                refresh();
                                repeat_ShowPass = FALSE;
                                break;
                            }
                        }
                    }
                }
                //******************************************************************Save Password********************************************************
                else if (choice == 3 && inpt == 10)
                {
                    clear();
                    refresh();
                    savePass();
                }
                //******************************************************Remove Password********************************************************
                else if (choice == 4 && inpt == 10)
                {
                    curs_set(1);
                    clear();
                    refresh();
                    winY = newwin(10, xMax / 2, 10, xMax / 4);
                    box(winY, 0, 0);
                    refresh();
                    wrefresh(winY);
                    mvwprintw(winY, 1, 1, "Enter the website name:");
                    wrefresh(winY);
                    char *website = (char *)malloc(50 * sizeof(char));
                    mvwgetstr(winY, 2, 1, website);
                    remove_Newline(website);
                    mvwprintw(winY, 3, 1, "Enter the Password:");
                    wrefresh(winY);
                    char *pass = (char *)malloc(50 * sizeof(char));
                    mvwgetstr(winY, 4, 1, pass);
                    remove_Newline(pass);
                    removePass(website, pass);
                    // getch();

                    delwin(winY);
                    // freeing memory
                    free(website);
                    free(pass);
                }

                //----------------------------------------------------------------Back to previous menu -------------------------------------------
                else if (choice == 5 && inpt == 10)
                {
                    clear();
                    refresh();
                    break;
                    chck_login = FALSE;
                }

            } // 3rd while end

        } // First while end

        clear();
        refresh();
        delwin(win1); // Delete the window
    }
    endwin();
    return 0;
}