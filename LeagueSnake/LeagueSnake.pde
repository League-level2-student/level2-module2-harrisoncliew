//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

//Add x and y member variables. They will hold the corner location of each segment of the snake.
int cornerX;
int cornerY;

// Add a constructor with parameters to initialize each variable.
public Segment(int cornerX, int cornerY) {
     this.cornerX  = cornerX;
     this.cornerY = cornerY;
   }


}

//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*
Segment head;
int foodX;
int foodY;
int direction = UP;
int foodPieces = 0;
ArrayList<Segment> tail = new ArrayList<Segment>();

//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
size(500,500);
  head = new Segment(50,50);
  frameRate(15);
  dropFood();
}

void dropFood() {
  //Set the food in a new random location
  foodX = ((int)random(50)*10);
  foodY = ((int)random(50)*10);
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(0,0,0);
  drawFood();
  move();
  drawSnake();
  eat();
}

void drawFood() {
  //Draw the food
  fill(#B630FA);
  rect( foodX, foodY,10,10);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  fill(#FFFFFF);
  rect(head.cornerX, head.cornerY, 10,10);
  manageTail();
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail
  
  for(int i=0; i<tail.size(); i++){
    
    rect(tail.get(i).cornerX, tail.get(i).cornerY, 10 ,10);
  

}
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  checkTailCollision();
  drawTail();
  Segment tailpart = new Segment(head.cornerX,head.cornerY);
  tail.add(tailpart);
  tail.remove(0);
  
  
  
  
  
  
  
  
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for(int i=0; i<tail.size(); i++){
  if(head.cornerX==tail.get(i).cornerX && head.cornerY==tail.get(i).cornerY){
  foodPieces = 1;
  tail = new ArrayList<Segment>();
  Segment head2 = new Segment(head.cornerX, head.cornerY);
  tail.add(head2);
  
  }
  }
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if(key==CODED) {
    if(keyCode == UP && direction!= DOWN) {
      direction = UP;
    }
    else if(keyCode == DOWN && direction!=UP) {
      direction = DOWN;
    }
    else if (keyCode == RIGHT && direction!= LEFT) {
      direction = RIGHT;
    }
    else if(keyCode ==LEFT && direction != RIGHT) {
      direction = LEFT;
    }
  }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.
  
    
  switch(direction) {
  case UP:
    // move head up here
    head.cornerY-=10;
    break;
  case DOWN:
    // move head down here
    head.cornerY+=10;
    break;
  case LEFT:
   // figure it out 
   head.cornerX-=10;
    break;
  case RIGHT:
    // mystery code goes here 
    head.cornerX+=10;
    break;
  }
  checkBoundaries();
  
}

void checkBoundaries() {
 //If the snake leaves the frame, make it reappear on the other side
 if(head.cornerX<0) {
   head.cornerX=500;
 }
 else if(head.cornerX>500) {
   head.cornerX=0;
 }
 else if(head.cornerY<0) {
   head.cornerY=500;
 }
 else if(head.cornerY>500) {
  head.cornerY=0;
 }
 

}

void eat() {
  //When the snake eats the food, its tail should grow and more food appear
  if(head.cornerX==foodX && head.cornerY==foodY) {
    foodPieces++;
    dropFood();
    Segment tailpart2 = new Segment(head.cornerX, head.cornerY);
    tail.add(tailpart2);
  }

}
