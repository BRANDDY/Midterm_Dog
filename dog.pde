Mover dog;
Obstacle bar;
Obstacle bar1;
Obstacle bar2;
Obstacle bar3;
int score;
boolean IsGameOver = false;

void setup() {
    size(1000,400);//画布大小
    dog = new Mover();
    bar = new Obstacle();
    dog.sprite = loadImage("stand.jpg");//初始dog图片
    bar.selectBar();//初始bar
    score=0;//初始分数
}
void draw() {
    if(IsGameOver){
        background(255);//覆盖画布
        bar.display();
        dog.display();//游戏结束保持画面静止
        if (keyPressed&&key==ENTER){//一键复活
            IsGameOver=false;
            score=0;//重置分数
            bar.selectBar();//重置bar
        }
    }else{
        background(255);
        updateObstacles();
        dog.update();
        dog.display();
        score+=1;//沒死就加分
        checkCollision();//碰撞系統
    }    
    countScore();//計分
}

void updateObstacles(){
    bar.update(); 
    if(bar.location.x<=-80){
        bar.selectBar();
    }  
    bar.display();
}

void countScore(){
    String str=String.format("% 10d",score/10);
    if(!IsGameOver){
        textSize(64);
        fill(#98295F);
        text("SCORE:"+str,200,100);
    }else{
        textSize(100);//字体大小
        fill(#98295F);//颜色
        text("GAME OVER",200,200);//内容和位置
        textSize(64);//每行字都要寫
        fill(#98295F);
        text("SCORE:"+str,200,100);
    }
}

void checkCollision(){
    if(((dog.location.x<bar.location.x+70)&&(dog.location.x+138>bar.location.x+20))&&
    ((dog.location.y<bar.location.y+70)&&(dog.location.y+106>bar.location.y+20))){//a的左邊超過b的右邊&&a的右邊超過b的左邊&&a的下邊在b上邊的下邊&&a上邊在a下邊的上邊
        if(bar.active){
            //score-=800;
            println(""+score/10);
            bar.active=false;//bar停止活動
            IsGameOver=true;
        }
    }
}

class Obstacle{
    PVector location= new PVector(1000,300);
    float speed = 5;
    float acc = 1;
    PImage bgImg;//背景圖片
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
    PVector acc=new PVector(0,1.1);
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