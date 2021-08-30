Mover dog;
Obstacle bar;
Obstacle bar1;
Obstacle bar2;
Obstacle bar3;
int score;

void setup() {
    size(1000,400);
    dog = new Mover();
    bar = new Obstacle();
    dog.sprite = loadImage("stand.jpg");
    bar.selectBar();
    score=0;
}
void draw() {
    background(255);
    dog.update();
    dog.display();
    score+=1;
    updateObstacles();
    checkCollision();
}

void updateObstacles(){
    
    bar.update(); 
    if(bar.location.x<=-80){
        bar.selectBar();
    }  
    bar.display();
}

void checkCollision(){
    if(((dog.location.x<bar.location.x+70)&&(dog.location.x+138>bar.location.x+15))&&
    ((dog.location.y<bar.location.y+70)&&(dog.location.y+106>bar.location.y+15))){
        if(bar.active){
            score-=800;
            println(""+score/10);
            bar.active=false;
        }
    }
}

class Obstacle{
    PVector location= new PVector(1000,300);
    float speed = 5;
    float acc = 1;
    PImage bgImg;
    PImage img;
    boolean active;
    
    void selectBar(){
        int r=int(random(2));
        switch (r){
            case 0: img=loadImage("bar0.png"); break;
            case 1: img=loadImage("bar1.jpg"); break;
        }
        location.x=1000;
        active=true;
    }
    void update() {
        //speed+=acc;
       location.x -= speed;
    }
    
    void display() {
        image(img,location.x,location.y,80,80); 
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