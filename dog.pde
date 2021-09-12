Mover dog;
Obstacle bar;
Button st;
int score;
int scoHigh;
boolean IsGameOver = false;
boolean GameStart = false;

void setup() {
    size(1000,400);//画布大小
    PImage curImg = loadImage("cursor.png");
    cursor(curImg);//光标
    //Obstacle[] barrier=new Obstacle[4];
    dog = new Mover();
    bar = new Obstacle();
    st = new Button();    
    //dog.sprite = loadImage("stand.jpg");//初始dog图片
    //setObstacles();//////////////////////////////////////
    bar.selectBar();//初始bar
    score = 0;//初始分数
    scoHigh = score;
}
void draw() {
    //int s=second(1);不行、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、
    if (!GameStart) {
        startPage();
    } else{    
        background(255);//覆盖画布
        
        if (IsGameOver) {
            bar.display();
            dog.display();//游戏结束保持画面静止
            if (keyPressed &&  key ==  ENTER) {//一键复活
                IsGameOver = false;
                score = 0;//重置分数
                bar.selectBar();//重置bar
            }
        } else{
            updateObstacles();//重置bar
            dog.update();
            dog.display();
            score += 1;//沒死就加分
            checkCollision();//碰撞系統
        }   
        scoreSystem();//計分*/
    }
}

void startPage() {
    background(200);
    st.display();
    textSize(100);
    fill(50);
    PFont font;
    font = loadFont("Algerian-48.vlw");
    textFont(font,100);
    text("FEEDING GUIDE",160,120);
    textSize(60);
    fill(50);
    text("START",425,265);
}

class Button{
    PImage img;
    PVector location = new PVector(300,200);
    
    void display() {
        if (mouseX < (location.x + 412) &&  mouseX>location.x &&  mouseY<(location.y + 96) &&  mouseY>location.y) {
            img = loadImage("buttonOn.jpg");
            image(img,location.x,location.y);//鼠标经过范围
            if (mousePressed) {
                GameStart = true;//开始游戏的判断，true时激活游戏画面
            }
        } else{
            img = loadImage("button.png");
            image(img,location.x,location.y);
        }
    }
}

void scoreSystem() {
    textSize(64);
    fill(#98295F);
    text("SCORE: " + String.format("%05d",score / 10),90,100); //补零
    textSize(30);
    fill(50);
    text("The Highest",800,60);
    if (score > scoHigh) {
        scoHigh = score;
    }
    textSize(30);
    fill(50);
    text(String.format("% 10d",scoHigh / 10),800,100);
    
    if (IsGameOver) {
        textSize(100);//字体大小
        fill(#98295F);//颜色
        text("GAME OVER",200,250);//内容和位置
    }
}

void checkCollision() {//碰撞判定
    if (((dog.location.x < bar.location.x + 50) && (dog.location.x + 138>bar.location.x + 40)) && 
       ((dog.location.y<bar.location.y + 50) && (dog.location.y + 106>bar.location.y + 40))) {//a的左边超过b的右边&&a的右边超过b的左边&&a的下边在b上边的下边&&a上边在a下边的上边
        println("" + score / 10);
        IsGameOver = true;
    }
}

/*void setObstacles(){
for (int i=0;i<4;i++){
int rImg=int(random(4));
switch(rImg){
case 0 : barrier[0].img = loadImage("bar0.png"); break;
case 1 : barrier[1].img = loadImage("bar1.jpg"); break;
case 2 : barrier[2].img = loadImage("bar2.jpg"); break;
case 3 : barrier[3].img = loadImage("bar3.png"); break;
}
if (i=0){
barrier[0].location.x=1000;
}
else{
int rLoc=int (random(200,500));
barrier[i].location.x+=rLoc;
}
    }
}*/

void updateObstacles() {
    bar.update(); 
    if (bar.location.x <= -80) {//当右边消失画面，更新的bar
        bar.selectBar();
    }  
    bar.display();
}

class Obstacle{
    PVector location = new PVector(1000,300);
    float speed = 5;
    float acc = 1;
    PImage bgImg;//背景图片
    PImage img;
    
    void selectBar() {
        int r = int(random(2));
        switch(r) {
            case 0 : img = loadImage("bar0.png"); break;
            case 1 : img = loadImage("bar1.jpg"); break;
        }
        location.x = 1000;
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
    }
    
    void changeImg(PImage a,PImage b) {
        PImage img;
        img = a;
        a = b;
        b = img;
    }
    
    void display() {
        int s = frameCount % 20;
        if (location.y < 250) {
            if(speed.y>1.5){
               dog.sprite = loadImage("down.png"); 
            }else{
                dog.sprite = loadImage("jump.png");
            }
        } else{
            if (s < 8 &&  s > 2) {
                dog.sprite = loadImage("ran1.png");
                println("1");
            } else if (s > 12 &&  s < 18) {
                dog.sprite = loadImage("run.png");
            } else{
                dog.sprite = loadImage("mid.png");
            }
        }
        image(dog.sprite,location.x,location.y);               
    }
}