Mover dog;
Obstacle bar;
Obstacle bar1;
Obstacle bar2;
Obstacle bar3;
int score;
boolean IsGameOver = false;
boolean GameStart = false;

void setup() {
    size(1000,400);//画布大小
    PImage curImg=loadImage("cursor.png");
    cursor(curImg);//光标
    dog = new Mover();
    bar = new Obstacle();
    dog.sprite = loadImage("stand.jpg");//初始dog图片
    bar.selectBar();//初始bar
    score=0;//初始分数
}
void draw() {
    startPage();
    /*
    background(255);//覆盖画布
    if(IsGameOver){
        bar.display();
        dog.display();//游戏结束保持画面静止
        if (keyPressed&&key==ENTER){//一键复活
            IsGameOver=false;
            score=0;//重置分数
            bar.selectBar();//重置bar
        }
    }else{
        updateObstacles();//重置bar
        dog.update();
        dog.display();
        score+=1;//沒死就加分
        checkCollision();//碰撞系統
    }    
    countScore();//計分*/
}

void updateObstacles(){
    bar.update(); 
    if(bar.location.x<=-80){//当右边消失画面，更新的bar
        bar.selectBar();
    }  
    bar.display();
}

void startPage(){
    background(200);
    textSize(100);
    fill(50);
    text("DOG Guide",250,100);

}

class button{
    PImage img;
    void update(){
        
    }
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
        textSize(64);//每行字都要写
        fill(#98295F);
        text("SCORE:"+str,200,100);
    }
}

void checkCollision(){//碰撞判定
    if(((dog.location.x<bar.location.x+50)&&(dog.location.x+138>bar.location.x+40))&&
    ((dog.location.y<bar.location.y+50)&&(dog.location.y+106>bar.location.y+40))){//a的左边超过b的右边&&a的右边超过b的左边&&a的下边在b上边的下边&&a上边在a下边的上边
        println(""+score/10);
        IsGameOver=true;
    }
}

class Obstacle{
    PVector location= new PVector(1000,300);
    float speed = 5;
    float acc = 1;
    PImage bgImg;//背景图片
    PImage img;
    
    void selectBar(){
        int r=int(random(2));
        switch (r){
            case 0: img=loadImage("bar0.png"); break;
            case 1: img=loadImage("bar1.jpg"); break;
        }
        location.x=1000;
    }
    void update() {
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