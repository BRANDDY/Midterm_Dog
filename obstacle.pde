void rlocation(int x) {
    int rDis = int(random(300, 600));
    if (x ==  0) {
        bars[x].location.x = bars[3].location.x + rDis;
    } else{
        bars[x].location.x = bars[x - 1].location.x + rDis;
    }
}

class Obstacle{
    PImage img;
    PVector location;
    boolean barActive = true;
    
    void selectImg(int rImg) {
        switch(rImg) {
            case 0 : img = loadImage("bar0.png"); break;
            case 1 : img = loadImage("bar1.jpg"); break;
            case 2 : img = loadImage("bar2.jpg"); break;
            case 3 : img = loadImage("bar3.png"); break;
        }
    }
    
    Obstacle(int rImg, int locX, boolean act) {
        selectImg(rImg);
        location = new PVector(locX,300);
        barActive = act;
    }
    
    void update(int x) {//x为数组位置
        bars[x].location.x = int(location.x);
        display();
        location.x -= speed;
        if (location.x < -40) {
            barActive = true;
            selectImg(int(random(0, 4)));//重新出图案，重新计算位置
            rlocation(x);
            location.x = bars[x].location.x;
        } 
    }
    void display() {
        image(img,location.x,location.y,80,80);
    }
}
