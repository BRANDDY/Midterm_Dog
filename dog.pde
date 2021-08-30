import java.util.Random;

Mover dog;
Obstacle bar;
Obstacle bar1;
Obstacle bar2;
Obstacle bar3;

void setup() {
    size(1000,400);
    dog = new Mover();
    bar = new Obstacle();
    dog.sprite = loadImage("stand.jpg");
    bar.selectBar();
}
void draw() {
    background(255);
    dog.update();
    dog.display();
    updateObstacles();
    checkCollision();
}

void updateObstacles(){
    
    bar.update(); 
    if(bar.location.x<=0){
        bar.selectBar();
    }  
    bar.display();
}

void checkCollision(){
    if(((dog.location.x<bar.location.x+80)||(dog.location.x+138>bar.location.x))&&
    ((dog.location.y>bar.location.y+80)||(dog.location.y+106<bar.location.y))){
        
    }else{
        println("right");
    }
}


class Mover{
    PImage sprite;
    PVector speed=new PVector(0,-25);
    PVector acc=new PVector(0,1);
    PVector location=new PVector(0,260);

    void update() {
        if (location.y >=  260) {
            speed.y = 0;
            location.y = 260;
            if (keyPressed ==  true) {
                if (key ==  ' ') {
                    speed = new PVector(0, - 25);
                }
            }
        }
        speed.add(acc);
        location.add(speed);
    }
    void display() {
        image (sprite,location.x,location.y);
    }
}

class Obstacle{
    PVector location= new PVector(1000,300);
    float speed = 5;
    float acc = 1;
    PImage bgImg;
    PImage img;
    
    void selectBar(){
        Random r=new Random();
        int bar=r.nextInt(2);
        switch (bar){
            case 0: img=loadImage("bar0.png");
            println(""+bar);
             break;
            case 1: img=loadImage("bar1.jpg");
            println(""+bar);
            break;
        }
        location.x=1000;
    }
    void update() {
        //speed+=acc;
       location.x -= speed;
    }
    
    void display() {
        image(img,location.x,location.y,80,80); 
    }
}

