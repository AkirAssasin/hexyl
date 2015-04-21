/* @pjs font='fonts/font.ttf' */ 

var myfont = loadFont("fonts/font.ttf");

int width = window.innerWidth - 30;
int height = window.innerHeight - 30;
int px = width/2;
int py = height/2;
int ppx = width/2;
int ppy = height/2;
int[] lA;
int power = 3;
int cost;
int ts;
int cs = 9;

Number.prototype.between = function (min, max) {
    return this > min && this < max;
}; 

void setup() {
    size(width,height); 
    textFont(myfont,60);
    lA = new int[20];
    if (width < height) {
        ts = width/10;
    } else {
        ts = height/10;
    }
}  

void mousePressed() {
    px = ppx;
    py = ppy;
    if (cost == 0 && power < 3) {power += 1;}
    if (cost > 0) {
        power -= cost;
    }

    if (cost == 0 && lA[cs] == 0) {
        lA[cs] = 1;
    }
    for(i = 0; i < lA.length - 3; i++) {
        if (lA[i] == 5) {
            lA[i] = 0;
        }
        if (lA[i] >= 1 && lA[i] <= 4) {
            lA[i] += 1;
        }
    }
    for(i = 0; i < 5; i++) {
        if (lA[i] == 0) {
            lA[round(random(lA.length - 3))] = 1;
        }
    }
    if (power <= 0) {restartGame();}
}

void draw() {
    // Expand For Board Drawing
    background(0);
      /*
                    [a]
               [b]      [c]
           [d]      [e]      [f]
               [g]      [h]
           [i]      [j]      [k]
               [l]      [m]
           [n]      [o]      [p]
               [q]      [r]
                    [s]
      */
  
      // a
      hexa(width/2,height/2 - ((width/30)/4)*12 - width/50,width/30,width/100,0);
      
      // b
      hexa(width/2 - width/15,height/2 - ((width/30)/4)*10 - width/100,width/30,width/100,1);
      
      // c
      hexa(width/2 + width/15,height/2 - ((width/30)/4)*10 - width/100,width/30,width/100,2);
      
      // d
      hexa(width/2 - (width/15)*2,height/2 - ((width/30)/4)*6 - width/100,width/30,width/100,3);
      
      // e
      hexa(width/2,height/2 - ((width/30)/4)*6 - width/100,width/30,width/100,4);
      
      // f
      hexa(width/2 + (width/15)*2,height/2 - ((width/30)/4)*6 - width/100,width/30,width/100,5);
      
      // g
      hexa(width/2 - width/15,height/2 - ((width/30)/4)*2.5 - width/100,width/30,width/100,6);
      
      // h
      hexa(width/2 + width/15,height/2 - ((width/30)/4)*2.5 - width/100,width/30,width/100,7);
      
      // i
      hexa(width/2 - (width/15)*2,height/2,width/30,width/100,8);
      
      // j
      hexa(width/2,height/2,width/30,width/100,9);
      
      // k
      hexa(width/2 + (width/15)*2,height/2,width/30,width/100,10);
      
      // l
      hexa(width/2 - width/15,height/2 + ((width/30)/4)*2.5 + width/100,width/30,width/100,11);
      
      // m
      hexa(width/2 + width/15,height/2 + ((width/30)/4)*2.5 + width/100,width/30,width/100,12);
      
      // n
      hexa(width/2 - (width/15)*2,height/2 + ((width/30)/4)*6 + width/100,width/30,width/100,13);
      
      // o
      hexa(width/2,height/2 + ((width/30)/4)*6 + width/100,width/30,width/100,14);
      
      // p
      hexa(width/2 + (width/15)*2,height/2 + ((width/30)/4)*6 + width/100,width/30,width/100,15);
      
      // q
      hexa(width/2 - width/15,height/2 + ((width/30)/4)*10 + width/100,width/30,width/100,16);
      
      // r
      hexa(width/2 + width/15,height/2 + ((width/30)/4)*10 + width/100,width/30,width/100,17);
      
      // s
      hexa(width/2,height/2 + ((width/30)/4)*12 + width/50,width/30,width/100,18);
      
    
    hexa(px,py - width/180,width/100,width/90,19);
    stroke(0,255,0);
    fill(255,0);
    strokeWeight(width/200);
    bezier(px,py,(px+ppx)/2,(py+ppy)/3,(px+ppx)/2,(py+ppy)/3,ppx,ppy);
    // PLayer piece ^
    
    fill(255);
    textAlign(CENTER);
    textSize(ts);
    text("hexyl",width/2,ts);
    textAlign(LEFT);
    text(power,0,height);
    if (px == ppx && py == ppy) {cost = 0;}
    if (dist(px,py,ppx,ppy) < 150 && dist(px,py,ppx,ppy) > 1) {cost = 1;}
    if (dist(px,py,ppx,ppy) >= 150 && dist(px,py,ppx,ppy) < 200) {cost = 2;}
    if (dist(px,py,ppx,ppy) >= 200) {cost = 3;}
    textSize(ts/2);
    if (px == ppx && py == ppy) {
        if (power < 3) {text("+1",0 + ts,height - ts);}
    } else {
        text("-" + cost,0 + (ts/4)*3,height - (ts/4)*3);
    }
}

void hexa(x,y,r,h,i) {
    if (dist(mouseX,mouseY,x,y) < (r/4)*3 && lA[i] < 3) {
        ppx = x;
        ppy = y;
    }
    if (px == x && py == y) {
        cs = i;
    }
    switch(lA[i]) {
        case 0:
            fill(150);
            stroke(150);
            break;
        case 1:
            fill(150,150);
            stroke(150,150);
            break;
        case 2:
            fill(150,50);
            stroke(150,50);
            break;
        case 3:
        case 4:
        case 5:
            fill(150,0);
            stroke(150,0);
            break;
    }
    if (i >= 19) {
        fill(0,150,0);
        stroke(0,150,0);
    }

    beginShape();
        vertex(x + r, y);
        vertex(x + r, y + h);
        vertex(x + (r/2), y + (r/4)*3 + h);
        vertex(x - (r/2), y + (r/4)*3 + h);
        vertex(x - r, y + h);
        vertex(x - r, y);
        vertex(x - (r/2), y - (r/4)*3);
        vertex(x + (r/2), y - (r/4)*3);
        vertex(x + r, y);
    endShape();
    switch(lA[i]) {
        case 0:
            fill(255);
            stroke(255);
            break;
        case 1:
            fill(255,150);
            stroke(255,150);
            break;
        case 2:
            fill(255,50);
            stroke(255,50);
            break;
        case 3:
        case 4:
        case 5:
            fill(255,0);
            stroke(255,0);
            break;
    }
    if (i >= 19) {
        fill(0,255,0);
        stroke(0,255,0);
    }
    
    beginShape();
        vertex(x + r, y);
        vertex(x + (r/2), y + (r/4)*3);
        vertex(x - (r/2), y + (r/4)*3);
        vertex(x - r, y);
        vertex(x - (r/2), y - (r/4)*3);
        vertex(x + (r/2), y - (r/4)*3);
        vertex(x + r, y);
    endShape();
    
    if (px == x && py == y && lA[i] > 2) {
        restartGame();
    }
}

void restartGame() {
    for(i = 0; i < lA.length; i++) {
        lA[i] = 0;
    }
    cs = 9;
    power = 3;
    ppx = width/2;
    ppy = height/2;
    px = width/2;
    py = height/2;
}
