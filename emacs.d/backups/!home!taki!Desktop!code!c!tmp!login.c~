// #include "login.h"
#include "../../../../msys64/ucrt64/include/ncursesw/curses.h"
#include "../../../../msys64/ucrt64/include/ncursesw/ncurses.h"
#include <ncurses.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

typedef struct
{

    char username[10000];
    char password[10000];
    char OpenMode; // Changed from array to single char
} User;

User create_user(char *username, char *password, char *OpenMode)
{
    User new_user;
    strcpy(new_user.username, username);
    strcpy(new_user.password, password);
    // Open the file in append mode to add new entries without overwriting existing ones
    FILE *file = fopen("users.txt", OpenMode);
    if (file != NULL)
    {
        // Write the username and password to the file
        fprintf(file, "%s\n%s\n", new_user.username, new_user.password);
        // Close the file
        fclose(file);
    }
    return new_user;
}

User match_usr(char *username, char *password, char *OpenMode)
{
    User matched_user = {"", ""}; // Initialize to empty strings

    // If username or password is empty, return an empty User
    if (username[0] == '\0' || password[0] == '\0')
    {
        return matched_user;
    }

    FILE *file = fopen("users.txt", OpenMode);
    if (file != NULL)
    {
        char line[100];
        while (fgets(line, sizeof(line), file))
        {
            line[strcspn(line, "\n")] = '\0';
            if (strcmp(line, username) == 0)
            {
                if (fgets(line, sizeof(line), file) == NULL)
                {
                    break; // fgets failed, break the loop
                }
                line[strcspn(line, "\n")] = '\0';
                if (strcmp(line, password) == 0)
                {
                    strcpy(matched_user.username, username);
                    strcpy(matched_user.password, password);
                    break;
                }
            }
        }
        fclose(file);
    }
    return matched_user;
}

void remove_Newline(char *str)
{
    int len = strlen(str);
    if (len > 0 && str[len - 1] == '\n')
    {
        str[len - 1] = '\0';
    }
}

User generatePassword(int length)
{

    User pass;
    const char charset[] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#&!$*";
    const int charset_length = sizeof(charset) - 1;
    srand(time(NULL)); // Seed the random number generator
    for (int i = 0; i < length; i++)
    {
        int index = rand() % charset_length;
        pass.password[i] = charset[index];
    }

    return pass;
}
User showPass()
{
    User pass;
    FILE *file = fopen("users.txt", "r");
    if (file != NULL)
    {
        char line[100];
        while (fgets(line, sizeof(line), file) != NULL)
        {
            line[strcspn(line, "\n")] = '\0';
            // Check if the line contains the username
            if (strstr(line, "admin") != NULL)
            {
                // Check if the next line contains the password
                fgets(line, sizeof(line), file);
                strcpy(pass.password, line);
                break;
            }
        }
        // Close the file
        fclose(file);
    }
    return pass;
}

void showSpecificPass(char *userName)
{
    initscr();
    clear();
    cbreak();
    start_color();
    init_pair(1, COLOR_BLACK, COLOR_WHITE);
    init_pair(2, COLOR_RED, COLOR_WHITE);
    init_pair(3, COLOR_YELLOW, COLOR_GREEN);
    init_pair(4, COLOR_BLUE, COLOR_RED);
    init_pair(5, COLOR_WHITE, COLOR_MAGENTA);
    init_pair(6, COLOR_CYAN, COLOR_GREEN);
    int yMax, xMax;
    getmaxyx(stdscr, yMax, xMax);
    refresh();
    int wndw_Line = yMax - 5;
    FILE *file = fopen("input.txt", "r");
    if (file == NULL)
    {
        return;
    }

    WINDOW *win = newwin(yMax - 2, xMax / 2, 2, xMax / 3);
    box(win, 0, 0);
    refresh();
    wrefresh(win);
    char line[100];
    bool flag = FALSE;
    int windw_Line = yMax - 5;
    int page_count = 1;
    mvwprintw(win, yMax - 9, xMax / 5 - 2, "Page: %d", page_count);
    wrefresh(win);
    int i = 6;
    while (fgets(line, sizeof(line), file) != NULL)
    {
        line[strcspn(line, "\n")] = '\0';
        if (strcmp(line, userName) == 0)
        {
            wattron(win, COLOR_PAIR(6) | A_BOLD);
            mvwprintw(win, 1, 15, "  Password Found  ");
            wattroff(win, COLOR_PAIR(6) | A_BOLD);
            wrefresh(win);
            mvwprintw(win, i, 15, "UserName: %s  ", userName);
            wrefresh(win);
            fgets(line, sizeof(line), file);
            line[strcspn(line, "\n")] = '\0';
            mvwprintw(win, i + 2, 15, "Password: %s", line);
            wrefresh(win);
            i += 4;
            flag = TRUE;
            if (i >= wndw_Line - 3)
            {
                page_count++;
                getch();
                wclear(win);
                box(win, 0, 0);
                wrefresh(win);
                i = 6;
                mvwprintw(win, yMax - 8, xMax / 5 - 2, "Page: %d", page_count);
                wrefresh(win);
            }
        }
    }
    if (flag == FALSE)
    {
        clear();
        refresh();
        WINDOW *win2 = newwin(yMax / 4, xMax / 4, yMax / 3, xMax / 2 - 10);
        box(win2, 0, 0);
        mvwprintw(win2, 1, 10, "UserName: %s  ", userName);
        wrefresh(win2);
        wattron(win2, COLOR_PAIR(2) | A_BOLD);
        mvwprintw(win2, 3, 7, "  Password Not Found ! ! ! !");
        wattroff(win2, COLOR_PAIR(2) | A_BOLD);
        wrefresh(win2);
        delwin(win2);
    }
    else
    {
        mvwprintw(win, yMax - 7, xMax / 4 - 15, "End of File Reached!");
        wrefresh(win);
        wattron(win, COLOR_PAIR(3) | A_BOLD | A_REVERSE);
        mvwprintw(win, yMax - 5, xMax / 4 - 15, "  Press Any Key to Exit..  ");
        wattroff(win, COLOR_PAIR(3) | A_BOLD | A_REVERSE);
        wrefresh(win);
    }
    getch();
    clear();
    refresh();
    delwin(win);
    endwin();
}
User savePass()
{
    initscr();
    int yMax, xMax;
    getmaxyx(stdscr, yMax, xMax);
    cbreak();
    curs_set(1);
    clear();
    WINDOW *win = newwin(yMax / 4 + 2, xMax / 2, yMax / 4, xMax / 4);
    box(win, 0, 0);
    refresh();

    wrefresh(win);
    wattron(win, COLOR_PAIR(6) | A_BOLD);
    mvwprintw(win, 1, xMax / 6 + 10, "  Saving Password  ");
    wattroff(win, COLOR_PAIR(6) | A_BOLD);
    wrefresh(win);
    User pass;
    mvwprintw(win, 3, 2, "Enter Username: ");
    wrefresh(win);
    mvwgetstr(win, 3, 18, pass.username);
    mvwprintw(win, 5, 2, "Password: ");
    wrefresh(win);
    mvwgetstr(win, 5, 12, pass.password);
    wrefresh(win);
    FILE *file = fopen("input.txt", "a");
    bool prompt_Success = FALSE;
    if (file != NULL && pass.username[0] != '\0' && pass.password[0] != '\0' && pass.username[0] != '\n' && pass.password[0] != '\n')
    {
        fprintf(file, "%s\n%s\n", pass.username, pass.password);
        fclose(file);
        prompt_Success = TRUE;
    }
    if (prompt_Success == FALSE)
    {
        refresh();

        wattron(win, COLOR_PAIR(2) | A_BOLD);
        mvwprintw(win, yMax / 4 - 5, xMax / 6 + 10, "  Error Saving Password!  ");
        wattroff(win, COLOR_PAIR(2) | A_BOLD);
        wrefresh(win);
        wattron(win, COLOR_PAIR(4) | A_BOLD | A_REVERSE);
        mvwprintw(win, yMax / 4 - 3, xMax / 6 + 4, "  Please Use non-empty Username and Password  ");
        wattroff(win, COLOR_PAIR(4) | A_BOLD | A_REVERSE);
        wattron(win, COLOR_PAIR(3) | A_BOLD | A_REVERSE);
        mvwprintw(win, yMax / 4 - 1, xMax / 6 + 10, "  Press Any Key to Exit...  ");
        wattroff(win, COLOR_PAIR(3) | A_BOLD | A_REVERSE);
        wrefresh(win);

        refresh();
    }
    else
    {

        wattron(win, COLOR_PAIR(3) | A_BOLD);
        mvwprintw(win, yMax / 4 - 5, xMax / 6 + 10, "  Password Saved Successfully!  ");
        wattroff(win, COLOR_PAIR(3) | A_BOLD);
        wrefresh(win);
        wattron(win, COLOR_PAIR(3) | A_BOLD | A_REVERSE);
        mvwprintw(win, yMax / 4 - 3, xMax / 6 + 12, "  Press Any Key to Exit..  ");
        wattroff(win, COLOR_PAIR(3) | A_BOLD | A_REVERSE);
        wrefresh(win);
    }
    getch();
    clear();
    refresh();
    delwin(win); // Delete the wind
    return pass;

    endwin();
}

//***************************************** Count the number of lines in the file to determine the number of users*******************************

void shwPass()
{
    initscr();
    clear();
    cbreak();
    start_color();
    init_pair(1, COLOR_BLACK, COLOR_WHITE);
    init_pair(2, COLOR_RED, COLOR_WHITE);
    init_pair(3, COLOR_YELLOW, COLOR_GREEN);
    init_pair(4, COLOR_BLUE, COLOR_RED);
    init_pair(5, COLOR_WHITE, COLOR_MAGENTA);
    init_pair(6, COLOR_CYAN, COLOR_GREEN);
    int yMax, xMax;
    getmaxyx(stdscr, yMax, xMax);
    refresh();
    int wndw_Line = yMax - 5;
    FILE *file = fopen("input.txt", "r");
    if (file == NULL)
    {
        return;
    }

    WINDOW *win = newwin(yMax - 2, xMax - 5, 1, 1);
    box(win, 0, 0);
    refresh();
    wrefresh(win);
    char line[100];
    int track_count = 1;
    int i = 1;
    int page_count = 1;
    mvwprintw(win, yMax - 8, xMax / 2 - 2, "Page: %d", page_count);
    wrefresh(win);
    while (fgets(line, sizeof(line), file) != NULL)
    {
        wattron(win, COLOR_PAIR(6) | A_BOLD);
        mvwprintw(win, 1, xMax / 2 - 2, "  All Passwords  ");
        wattroff(win, COLOR_PAIR(6) | A_BOLD);
        line[strcspn(line, "\n")] = '\0';
        mvwprintw(win, i + 1, 1, "User %d: %s", track_count, line);
        wrefresh(win);
        if (fgets(line, sizeof(line), file) == NULL)
            break;
        line[strcspn(line, "\n")] = '\0';
        mvwprintw(win, i + 2, 1, "Pass %d: %s", track_count, line);
        wrefresh(win);
        track_count++;

        i += 3;
        if (i >= wndw_Line - 3)
        {
            page_count++;
            getch();
            wclear(win);
            box(win, 0, 0);
            wrefresh(win);
            i = 1;
            mvwprintw(win, yMax - 8, xMax / 2 - 2, "Page: %d", page_count);
            wrefresh(win);
        }
    }
    mvwprintw(win, yMax - 6, xMax / 2 - 2, "End of File Reached!");
    wrefresh(win);
    mvwprintw(win, yMax - 4, xMax / 2 - 2, "Press Any Key to Continue ......");
    wrefresh(win);

    fclose(file);
    getch();
    clear();
    refresh();
    delwin(win);
    endwin();
}

void removePass(char *username, char *password)
{
    initscr();
    clear();
    cbreak();
    start_color();
    init_pair(1, COLOR_BLACK, COLOR_WHITE);
    init_pair(2, COLOR_RED, COLOR_WHITE);
    init_pair(3, COLOR_YELLOW, COLOR_GREEN);
    init_pair(4, COLOR_BLUE, COLOR_RED);
    init_pair(5, COLOR_WHITE, COLOR_MAGENTA);
    init_pair(6, COLOR_CYAN, COLOR_GREEN);
    int yMax, xMax;
    getmaxyx(stdscr, yMax, xMax);
    WINDOW *win = newwin(10, xMax / 3, yMax / 4, xMax / 3);
    box(win, 0, 0);
    refresh();
    wrefresh(win);

    FILE *file = fopen("input.txt", "r");
    FILE *temp = fopen("temp.txt", "w");
    if (file == NULL)
    {
        return;
    }

    bool flag = FALSE;
    char line[100];
    while (fgets(line, sizeof(line), file) != NULL)
    {
        line[strcspn(line, "\n")] = '\0';
        if (strcmp(line, username) == 0)
        {
            fgets(line, sizeof(line), file);
            line[strcspn(line, "\n")] = '\0';
            if (strcmp(line, password) == 0)
            {
                flag = TRUE;
            }
            else
            {
                fprintf(temp, "%s\n%s\n", username, line);
            }
        }
        else
        {
            fprintf(temp, "%s\n", line);
        }
    }

    if (flag)
    {
        wattron(win, COLOR_PAIR(3) | A_BOLD);
        mvwprintw(win, 1, 5, "Password Removed Successfully!");
        wattroff(win, COLOR_PAIR(3) | A_BOLD);
        wrefresh(win);
        mvwprintw(win, 3, 5, "Press Any Key to Back To The Previous Menu");
        wrefresh(win);
    }
    else
    {
        wattron(win, COLOR_PAIR(2) | A_BOLD);
        mvwprintw(win, 1, xMax / 8, "  Password Not Found!  ");
        wattroff(win, COLOR_PAIR(2) | A_BOLD);
        wrefresh(win);
        wattron(win, COLOR_PAIR(4) | A_BOLD);
        mvwprintw(win, 3, 18, "  Press Any Key to Back To The Previous Menu  ");
        wattroff(win, COLOR_PAIR(4) | A_BOLD);
        wrefresh(win);
    }

    fclose(file);
    fclose(temp);
    remove("input.txt");
    rename("temp.txt", "input.txt");
    getch();
    clear();
    refresh();
    delwin(win);
    endwin();
}
