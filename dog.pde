Button st;
int score;
int scoHigh;
boolean GameStart = false;
boolean IsGameOver = false;
Mover dog;
Obstacle[] bars;//（bar）元素数组bars
int speedReset = 5;
int speed = speedReset;

void setup() {
    size(1000,400);
    PImage curImg = loadImage("cursor.png");
    cursor(curImg);//光标
    st = new Button();
    score = 0;//初始分数
    scoHigh = score;
    //——————————————————————————————————————————————————
    dog = new Mover(); //实例化狗    
    //——————————————————————————————————————————————————
    bars = new Obstacle[4]; //实例化数组
    for (int i = 0;i < 4;i++) { //录入
        int locX = 1000 + 400 * i;
        bars[i] = new Obstacle(int(random(0, 4)), locX, true);
    }
    //——————————————————————————————————————————————————
}

void draw() {
    if (!GameStart) {
        startPage();
    } else{    
        background(255);
        if (IsGameOver) {
            dog.display();//游戏结束保持画面静止
            //——————————————————————————————————————————————————
            for (int i = 0;i < 4;i++) { //障碍物跑起来
                bars[i].display();
            }
            //——————————————————————————————————————————————————
            if (keyPressed &&  key ==  ENTER) {//一键复活
                IsGameOver = false;
                score = 0;//重置
                speed = speedReset;
            }
        } else{
            dog.update();
            //——————————————————————————————————————————————————
            for (int i = 0;i < 4;i++) { //障碍物跑起来
                bars[i].update(i);
            }
            //——————————————————————————————————————————————————
            score += 1;//沒死就加分
            speedCtrl(score);
            println(score);
            checkCollision();//碰撞系統
        }   
        scoreSystem();//計分
    }
}

void startPage() {
    background(200);
    st.display(); //按键变色等等
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
    for (int i = 0;i < 4;i++) {
        if (((dog.location.x < bars[i].location.x + 50) && (dog.location.x + 138>bars[i].location.x + 40)) && 
           ((dog.location.y<bars[i].location.y + 50) && (dog.location.y + 106>bars[i].location.y + 40)) &&  bars[i].barActive) {//a的左边超过b的右边&&a的右边超过b的左边&&a的下边在b上边的下边&&a上边在a下边的上边
            IsGameOver = true;
            bars[i].barActive = false;
            break;
        }
    }
    
}

int speedCtrl(int s) {
    if (s % 500 == 0) {//////////////////////////////////
        speed += 1;
    }
    println(speed);
    return speed;
}
