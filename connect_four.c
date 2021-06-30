#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>
#include <stdlib.h>

//There are four possible ways to win:
//XXXX => The distance between each X is 1
//X
//X
//X
//X => The distance between each X is 8
//X
// X
//  X
//   X => The distance between each X is 9
//   X
//  X
// X
//X => The distance between each X is 7

//0  1  2  3  4  5  6  7
//8  9 10 11 12 13 14 15
//16 17 18 19 20 21 22 23
//24 25 26 27 28 29 30 31
//32 33 34 35 36 37 38 39
//40 41 42 43 44 45 46 47
//48 49 50 51 52 53 54 55

struct Grid {
      char data;
      int position;
      struct Grid * next;
      struct Grid * up;
      struct Grid * down;
      struct Grid * left;
      struct Grid * right;
      struct Grid * upLeft;
      struct Grid * upRight;
      struct Grid * downLeft;
      struct Grid * downRight;
};

struct Move {
      char data;
      struct Move * next;
};

//Update the tracker
void updateTracker(struct Move * tracker, char location){
    if (tracker->data==' '){
        tracker->data=location;
    }
    else {
        struct Move * newNode = (struct Move *)malloc(sizeof(struct Move));
        struct Move * temp = tracker;

        while (temp->next != NULL){
            temp=temp->next;
        }
        newNode->data=location;
        newNode->next=NULL;
        temp->next=newNode;
    }
}

void printTracker(struct Move * tracker){
    struct Move * temp = tracker;
    printf("\n");
    while (temp->next!=NULL){
        printf("->");
        printf("%c",temp->data);
        temp=temp->next;
    }
    printf("->");
    printf("%c",temp->data);
    printf("\n");
    printf("Select your move by typing A - G \n");
}

//Function to simply traverse the linked list and print out the board
void printBoard(struct Grid head){
    struct Grid * temp;
    int counter = 0;
    printf ("\n");
    for (int i=0; i<=55; i++){
        if (i==0){
            printf ("%c",head.data);
            printf (" ");
            temp = head.next;
        }
        else {
            printf ("%c",temp->data);
            printf (" ");
            temp = temp->next;
        }
        counter++;
        //Every 8 nodes creates a line, after that we need to move to a new line
        if (counter == 8){
            printf ("\n");
            counter = 0;
        }
    }
    printf ("\n");
}

//Function to make each node aware of it's neighbors
void relinkBoard(struct Grid head){
    struct Grid * row1;
    struct Grid * row2;
    struct Grid * row3;
    struct Grid * row4;
    struct Grid * row5;
    struct Grid * row6;
    struct Grid * row7;

    struct Grid * temp1;
    struct Grid * temp2;
    struct Grid * temp3;
    struct Grid * temp4;
    struct Grid * temp5;
    struct Grid * temp6;
    struct Grid * temp7;

    //Defining what the rows are
    row1 = &head;
    row2 = row1->next->next->next->next->next->next->next->next;
    row3 = row2->next->next->next->next->next->next->next->next;
    row4 = row3->next->next->next->next->next->next->next->next;
    row5 = row4->next->next->next->next->next->next->next->next;
    row6 = row5->next->next->next->next->next->next->next->next;
    row7 = row6->next->next->next->next->next->next->next->next;
    
    //Traversing all of the rows simutaneously

    for (int i =0; i<=7; i++){
        if (i == 0){
            row1->down=row2;
            row1->right=row1->next;
            row1->downRight=row2->next;
            row1->up=NULL;
            row1->left=NULL;
            row1->upLeft=NULL;
            row1->downLeft=NULL;
            row1->upRight=NULL;

            row2->up=row1;
            row2->upRight=row1->next;
            row2->right=row2->next;
            row2->down=row3;
            row2->downRight=row3->next;
            row2->left=NULL;
            row2->upLeft=NULL;
            row2->downLeft=NULL;

            row3->up=row2;
            row3->upRight=row2->next;
            row3->right=row3->next;
            row3->down=row4;
            row3->downRight=row4->next;
            row3->left=NULL;
            row3->upLeft=NULL;
            row3->downLeft=NULL;

            row4->up=row3;
            row4->upRight=row3->next;
            row4->right=row4->next;
            row4->down=row5;
            row4->downRight=row5->next;
            row4->left=NULL;
            row4->upLeft=NULL;
            row4->downLeft=NULL;

            row5->up=row4;
            row5->upRight=row4->next;
            row5->right=row5->next;
            row5->down=row6;
            row5->downRight=row6->next;
            row5->left=NULL;
            row5->upLeft=NULL;
            row5->downLeft=NULL;      

            row6->up=row5;
            row6->upRight=row5->next;
            row6->right=row6->next;
            row6->down=row7;
            row6->downRight=row7->next;
            row6->left=NULL;
            row6->upLeft=NULL;
            row6->downLeft=NULL;        

            row7->up=row6;
            row7->upRight=row6->next;
            row7->right=row7->next;
            row7->down=NULL;
            row7->downLeft=NULL;
            row7->downRight=NULL;
            row7->left=NULL;
            row7->upLeft=NULL;

        }
        else {
            temp1 = row1;
            temp2 = row2;
            temp3 = row3;
            temp4 = row4;
            temp5 = row5;
            temp6 = row6;
            temp7 = row7;

            row1 = row1->next;
            row2 = row2->next;
            row3 = row3->next;
            row4 = row4->next;
            row5 = row5->next;
            row6 = row6->next;
            row7 = row7->next;

            if (i>=1 && i<=6){
                row1->down=row2;
                row1->right=row1->next;
                row1->downRight=row2->next;
                row1->left=temp1;
                row1->downLeft=temp2;
                row1->up=NULL;
                row1->upLeft=NULL;
                row1->upRight=NULL;

                row2->up=row1;
                row2->upRight=row1->next;
                row2->right=row2->next;
                row2->down=row3;
                row2->downRight=row3->next;
                row2->left=temp2;
                row2->downLeft=temp3;
                row2->upLeft=temp1;

                row3->up=row2;
                row3->upRight=row2->next;
                row3->right=row3->next;
                row3->down=row4;
                row3->downRight=row4->next;
                row3->left=temp3;
                row3->downLeft=temp4;
                row3->upLeft=temp2;

                row4->up=row3;
                row4->upRight=row3->next;
                row4->right=row4->next;
                row4->down=row5;
                row4->downRight=row5->next;
                row4->left=temp4;
                row4->downLeft=temp5;
                row4->upLeft=temp3;

                row5->up=row4;
                row5->upRight=row4->next;
                row5->right=row5->next;
                row5->down=row6;
                row5->downRight=row6->next;       
                row5->left=temp5;
                row5->downLeft=temp6;
                row5->upLeft=temp4;     

                row6->up=row5;
                row6->upRight=row5->next;
                row6->right=row6->next;
                row6->down=row7;
                row6->downRight=row7->next;       
                row6->left=temp6;
                row6->downLeft=temp7;
                row6->upLeft=temp5;     

                row7->up=row6;
                row7->upRight=row6->next;
                row7->right=row7->next;
                row7->left=temp7;
                row7->upLeft=temp6;       
                row7->down=NULL;
                row7->downLeft=NULL;
                row7->downRight=NULL;

            }

            else {
                row1->left=temp1;
                row1->down=row2;
                row1->downLeft=temp2;
                row1->upLeft=NULL;
                row1->up=NULL;
                row1->right=NULL;
                row1->upRight=NULL;
                row1->downRight=NULL;

                row2->left=temp2;
                row2->down=row3;
                row2->downLeft=temp3;
                row2->up=row1;
                row2->upLeft=temp1;      
                row2->right=NULL;
                row2->upRight=NULL;
                row2->downRight=NULL;     


                row3->left=temp3;
                row3->down=row4;
                row3->downLeft=temp4;
                row3->up=row2;
                row3->upLeft=temp2;  
                row3->right=NULL;
                row3->upRight=NULL;
                row3->downRight=NULL;      

                row4->left=temp4;
                row4->down=row5;
                row4->downLeft=temp5;
                row4->up=row3;
                row4->upLeft=temp3;  
                row4->right=NULL;
                row4->upRight=NULL;
                row4->downRight=NULL;      
        
                row5->left=temp5;
                row5->down=row6;
                row5->downLeft=temp6;
                row5->up=row4;
                row5->upLeft=temp4;
                row5->right=NULL;
                row5->upRight=NULL;
                row5->downRight=NULL;       

                row6->left=temp6;
                row6->down=row7;
                row6->downLeft=temp7;
                row6->up=row5;
                row6->upLeft=temp5;
                row6->right=NULL;
                row6->upRight=NULL;
                row6->downRight=NULL;      

                row7->left=temp7;
                row7->up=row6;
                row7->upLeft=temp6;
                row7->down=NULL;
                row7->downLeft=NULL;
                row7->downRight=NULL;
                row7->right=NULL;
                row7->upRight=NULL;
            }
        }
    }
}

//Basically create a board with 7 rows and 8 columns, with the first row and column filled with 1-6 and A-G.
//Fill the rest with '.'
struct Grid createBoard(){
    struct Grid head;
    struct Grid * temp;
    head.data=' ';
    head.position=0;
    for (int i = 1; i<=55; i++){
        struct Grid * newNode = (struct Grid *)malloc(sizeof(struct Grid));
        newNode->position=i;
        if (i==1){
            head.next=newNode;
            newNode->data='A';
        }
        else {
            if (i==2){
                newNode->data='B';
            }
            else if (i==3){
                newNode->data='C';
            }
            else if (i==4){
                newNode->data='D';
            }
            else if (i==5){
                newNode->data='E';
            }
            else if (i==6){
                newNode->data='F';
            }
            else if (i==7){
                newNode->data='G';
            }
            else if (i==8){
                newNode->data='6';
            }
            else if (i==16){
                newNode->data='5';
            }
            else if (i==24){
                newNode->data='4';
            }
            else if (i==32){
                newNode->data='3';
            }
            else if (i==40){
                newNode->data='2';
            }
            else if (i==48){
                newNode->data='1';
            }
            else {
                newNode->data='.';
            }
            temp->next=newNode;
        }
        temp=newNode;
    }
    relinkBoard(head);
    return head;
}

//Check how many connected nodes there are
bool diagonal1(struct Grid * node, char token){
    int counter = 0;
    struct Grid * temp;
    temp=node;
    while (temp->upLeft!=NULL && temp->upLeft->data == token){
        counter +=1;
        temp=temp->upLeft;
    }
    temp = node;
    while (temp->downRight!=NULL && temp->downRight->data == token){
        counter +=1;
        temp=temp->downRight;
    }
    return (counter > 2);
}

//Check how many connected nodes there are
bool diagonal2(struct Grid * node, char token){
    int counter = 0;
    struct Grid * temp;
    temp=node;
    while (temp->upRight!=NULL && temp->upRight->data == token){
        counter +=1;
        temp=temp->upRight;
    }
    temp = node;
    while (temp->downLeft!=NULL && temp->downLeft->data == token){
        counter +=1;
        temp=temp->downLeft;
    }
    return (counter > 2);
}

//Check how many connected nodes there are
bool horizontal(struct Grid * node, char token){
    int counter = 0;
    struct Grid * temp;
    temp=node;
    while (temp->left!=NULL && temp->left->data == token){
        counter +=1;
        temp=temp->left;
    }
    temp = node;
    while (temp->right!=NULL && temp->right->data == token){
        counter +=1;
        temp=temp->right;
    }
    return (counter > 2);
}

//Check how many connected nodes there are
bool verticle(struct Grid * node, char token){
    int counter = 0;
    struct Grid * temp;
    temp=node;
    while (temp->up!=NULL && temp->up->data == token){
        counter +=1;
        temp=temp->up;
    }
    temp = node;
    while (temp->down!=NULL && temp->down->data == token){
        counter +=1;
        temp=temp->down;
    }
    return (counter > 2);
}

//Check who's winning
bool checkWin(struct Grid * node, char token){
    return (horizontal(node,token) || verticle(node,token) || diagonal1(node,token) || diagonal2(node,token));
}

//Check if there are 2 nodes aligned horizontally that does not already have 1 side blocked by the opponent
//We also make sure a move is possible on both sides
bool checkWin2(struct Grid * node, char token){
    int counter = 0;
    struct Grid * temp;
    temp=node;
    while (temp->left!=NULL && temp->left->data == token){
        counter +=1;
        temp=temp->left;
        if (counter == 2 && temp->left!=NULL && temp->left->data=='.'){
            if (temp->downLeft == NULL || temp->downLeft->data !='.'){
                if (temp->downRight == NULL || temp->downRight->data !='.'){
                    return true;
                }
            }
        }
    }

    temp = node;
    counter = 0;
    while (temp->right!=NULL && temp->right->data == token){
        counter +=1;
        temp=temp->right;
        if (counter == 2 && temp->right!=NULL && temp->right->data=='.'){
            if (temp->downRight == NULL || temp->downRight->data !='.'){
                if (temp->downLeft == NULL || temp->downLeft->data !='.'){
                    return true;
                }
            }
        }
    }
    return false;
}

bool userMove(struct Grid head, struct Move * tracker, int first, char userToken){
    printf("Select your move by typing A - G \n");
    struct Grid * temp;
    char temp2;
    struct Move * temp3;

    //Input handling
    while (1) {
        char usrMove;
        scanf("%s", &usrMove);
        int calc = (int)(usrMove - '0');

        if (calc == 17 || calc == 49){
            printf("Selecting A \n");
            temp2='A';
            break;
        }
        else if (calc == 18 || calc == 50){
            printf("Selecting B \n");
            temp2='B';
            break;
        }
        else if (calc == 19 || calc == 51){
            printf("Selecting C \n");
            temp2='C';
            break;
        }
        else if (calc == 20 || calc == 52){
            printf("Selecting D \n");
            temp2='D';
            break;
        }
        else if (calc == 21 || calc == 53){
            printf("Selecting E \n");
            temp2='E';
            break;
        }
        else if (calc == 22 || calc == 54){
            printf("Selecting F \n");
            temp2='F';
            break;
        }
        else if (calc == 23 || calc == 55){
            printf("Selecting G \n");
            temp2='G';
            break;
        }

        else if (calc == 38 || calc == 70){
            printTracker(tracker);
        }

        else {
            printf("Invalid selection. Please type any character from A to G to move, or V to view history. \n");
        }
    }

    //Insertion of the move into the board

    if (temp2 == 'A'){
        temp = head.next;
    }
    else if (temp2 == 'B'){
        temp = head.next->next;
    }
    else if (temp2 == 'C'){
        temp = head.next->next->next;
    }
    else if (temp2 == 'D'){
        temp = head.next->next->next->next;
    }
    else if (temp2 == 'E'){
        temp = head.next->next->next->next->next;
    }
    else if (temp2 == 'F'){
        temp = head.next->next->next->next->next->next;
    }
    else{
        temp = head.next->next->next->next->next->next->next;
    }

    if (temp->down->data == 'X' || temp->down->data == 'O'){
        printf ("Invalid Move! Column is already full! \n");
        userMove(head,tracker,first,userToken);
    } else {
        for (int i = 1; i <= 6; i++){
            temp=temp->down;
            if (temp->down==NULL || temp->down->data == 'X' || temp->down->data =='O'){
                break;
            }
        }

        temp->data=userToken;
    }

    //Updating the tracker
    updateTracker(tracker,temp2);
    //Check who's winning after the move here
    if (checkWin(temp,userToken)){
        printBoard(head);
        printf ("\n");
        printf ("======== \n");
        printf ("You won! \n");
        printf ("======== \n");
        printf ("\n");
        printf ("New board generated! Press control + C to quit. \n");
        return true;
    } 
    return false;
}

bool botMove(struct Grid head, struct Move * tracker, int first, int turn, char botToken){
    struct Grid * temp;
    char temp2;
    struct Grid * scanner;
    bool alrMoved = false;
    int counter = 0;

    //Scanning for obvious moves
    scanner = &head;
    for (int i = 1; i<=7; i++){
        scanner=scanner->next;
        struct Grid * scannerHolder = scanner;
        for (int j = 1; j <= 6; j++){
            scanner=scanner->down;
            if (scanner->down==NULL || scanner->down->data == 'X' || scanner->down->data =='O'){
                break;
            }
        }
        if (checkWin(scanner,'X') || checkWin(scanner,'O')){
            scanner->data=botToken;
            alrMoved=true;
            temp=scanner;
            temp2 = ((char)('A') + i);
            break;
        } else{
            scanner = scannerHolder;
        }
    }

    //Check if there are 2 nodes aligned horizontally that does not already have 1 side blocked by the opponent
    //We also make sure a move is possible on both sides
    //While the loop is the same as above, this check is not prioritized
    if (!alrMoved){
        //We do not scan the side edges here, because if we have 
        //         . O 0 . . . . .
        //Making   0 0 0 . . . . . 
        //Is stupid as the opponent can just easily block it.
        //Even if we are on the defense, it is better to put the block further away from the edge.

        scanner = head.next;
        for (int i = 2; i<=6; i++){
            scanner=scanner->next;
            struct Grid * scannerHolder = scanner;
            for (int j = 1; j <= 6; j++){
                scanner=scanner->down;
                if (scanner->down==NULL || scanner->down->data == 'X' || scanner->down->data =='O'){
                    break;
                }
            }
            if (checkWin2(scanner,'X') || checkWin2(scanner,'O')){
                scanner->data=botToken;
                alrMoved=true;
                temp=scanner;
                temp2 = ((char)('A') + i);
                break;
            } else{
                scanner = scannerHolder;
            }
        }
    }

    if (!alrMoved){
        //Insertion of the move into the board
        while(1){
            temp2 = ((char)('A' + rand()%(7)));
            if (temp2 == 'A'){
                temp = head.next;
            }
            else if (temp2 == 'B'){
                temp = head.next->next;
            }
            else if (temp2 == 'C'){
                temp = head.next->next->next;
            }
            else if (temp2 == 'D'){
                temp = head.next->next->next->next;
            }
            else if (temp2 == 'E'){
                temp = head.next->next->next->next->next;
            }
            else if (temp2 == 'F'){
                temp = head.next->next->next->next->next->next;
            }
            else{
                temp = head.next->next->next->next->next->next->next;
            }

            if (temp->down->data != 'X' && temp->down->data != 'O'){
                break;
            }
        }
        
        for (int i = 1; i <= 6; i++){
            temp=temp->down;
            if (temp->down==NULL || temp->down->data == 'X' || temp->down->data =='O'){
                break;
            }
        }
        temp->data=botToken;
    }

    //Updating the tracker
    updateTracker(tracker,temp2);

    //Print Board
    printBoard(head);

    //Check who's winning after the move here
    if (checkWin(temp,botToken)){
        printf ("\n");
        printf ("======== \n");
        printf ("You lost! \n");
        printf ("======== \n");
        printf ("\n");
        printf ("New board generated! Press control + C to quit. \n");
        return true;
    } 
    return false;
}

//Function to choose who goes first.
int firstOrSecond()
{
    printf(
        "[0] First. \n"
        "[1] Second. \n");
    while (1) {
        //Variable storing user input
        char choice;
        scanf("%s", &choice);
        switch ((int)(choice - '0')) {
        case 0:
            printf("\n");
            printf("Very well. You have chosen to go first. \n");
            printf("Press V if you want to see the move history.");
            printf("\n");
            return 0;
        case 1:
            printf("\n");
            printf("Very well. You have chosen to go second. \n");
            printf("Press V if you want to see the move history.");
            printf("\n");
            return 1;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ;
        //If input is not 0 or 1 it will just ask for the correct input until it gets one.
        default:
            printf("\n");
            printf("Invalid selection. Please type either 0 or 1. \n");
            printf("\n");
        }
    }
}

//Main function to start game
int main(){
    //Variable storing who goes first

    printf("\n");
    printf("Welcome to the connect four game. Select whether you want to go first or second. \n");
    printf("Press control + C to quit. \n");
    printf("\n");

    //Getting the answer on who goes first.
    int first = firstOrSecond();
    int turn = 0;
    struct Grid linkedList = createBoard();
    struct Move * tracker = (struct Move *)malloc(sizeof(struct Move));
    tracker->data=' ';
    tracker->next=NULL;
    char userToken;
    char botToken;
    

    while (1){
        //Swapping the execution order of userMove and botMove based on who goes first
        if (first == 0){
            userToken='X';
            botToken='O';
            if (turn == 0){
                //Printing the initial board
                printBoard(linkedList);
            }

            if (turn > 40 || userMove(linkedList, tracker, first, userToken) || botMove(linkedList, tracker, first, turn, botToken)){
                if (turn > 40){
                    printf ("\n");
                    printf ("It's a draw! Resetting board. \n");
                    printf ("\n");
                }
                linkedList = createBoard();
                turn = -2;
                first = 1;
                tracker->data=' ';
                tracker->next=NULL;
            }
        
        }
        else {
            userToken='O';
            botToken='X';
            if (turn > 40 ||  botMove(linkedList, tracker, first, turn, botToken) || userMove(linkedList, tracker, first, userToken)) {
                if (turn > 40){
                    printf ("\n");
                    printf ("It's a draw! Resetting board. \n");
                    printf ("\n");
                }
                linkedList = createBoard();
                turn = -2;
                first = 0;
                tracker->data=' ';
                tracker->next=NULL;
            }
        }
        turn+=2;
    }
}