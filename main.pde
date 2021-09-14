class Mover{
    PImage sprite;
    PVector speed = new PVector(0, -25);
    PVector acc = new PVector(0,1.1);
    PVector location = new PVector(0,260);
    
    void update() {
        if (location.y >=  260) {
            speed.y = 0;
            location.y = 260;
            if (keyPressed ==  true) {
                if (key ==  ' ') {
                    speed = new PVector(0, -25);
                }
            }
        }
        speed.add(acc);
        location.add(speed);
        display();
    }
    
    void changeImg(PImage a,PImage b) {
        PImage img;
        img = a;
        a = b;
        b = img;
    }
    
    void display() {
        int s = frameCount % 30;
        if (location.y < 250) {
            if(speed.y>1.5){
               dog.sprite = loadImage("down.png"); 
            }else{
                dog.sprite = loadImage("jump.png");
            }
        } else{
            if ((s < 15) && ( s >7 )) {
                dog.sprite = loadImage("ran1.png");
            } else if ((s > 22) &&  (s < 30)) {
                dog.sprite = loadImage("run.png");
            } else{
                dog.sprite = loadImage("mid.png");
            }
        }
        image(dog.sprite,location.x,location.y);               
    }
}
