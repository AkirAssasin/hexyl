/* @pjs font='fonts/font.ttf' */ 

var myfont = loadFont("fonts/font.ttf");

color pc = color(0);
int width = window.innerWidth - 30;
int height = window.innerHeight - 30;
int px = width/2;
int py = height/2;
int ppx = width/2;
int ppy = height/2;
int[] lA;
int[] gA;
int power = 3;
int cost;
int ts;
int cts;
int cs = 9;
int ms = 9;
int fader = 0;
boolean[] cA;
boolean help = false;

ArrayList pcles;

Number.prototype.between = function (min, max) {
    return this > min && this < max;
}; 

void setup() {
    size(width,height); 
    textFont(myfont,60);
    lA = new int[20];
    gA = new int[19];
    cA = new boolean[7];
    pcles = new ArrayList();
    if (width < height) {
        ts = width/10;
        cts = 141;
    } else {
        ts = height/10;
        cts = 78.5;
    }
}  

void mouseClicked() {
    if (dist(mouseX,mouseY,width - ts/1.5,height - ts/1.5) <= ts/2) {
        switch(help) {
            case true:
                help = false;
                break;
            case false:
                help = true;
                break;
        }
    } else {
        for(i = 0; i < lA.length - 1; i++) {
            if (lA[i] == 5 && random(1) > 0.7) {
                lA[i] = 0;
            }
            if (lA[i] >= 1 && lA[i] <= 4) {
                lA[i] += 1;
            }
        }
        
        if (lA[cs] == 0) {
            lA[cs] = 1;
        }
        
        if (power > 0 && cost <= power) {
            px = ppx;
            py = ppy;
        }
        
        for(i = 0; i < 5; i++) {
            int a = round(random(lA.length - 1));
            if (lA[a] == 0) {
                lA[a] = 1;
                if (random(1) > 0.9 && a != cs) {
                    gA[a] = round(random(1,7));
                }
            }
        }
    
        if (cost > 0 && cost <= power) {
            power -= cost;
        }
    
        if (power < 3) {power += 1;}
    }
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
      
    
    
    
    stroke(red(pc),green(pc),blue(pc),100);
    strokeWeight(width/200);
    line(px,py,ppx,ppy);
    hexa(px,py - width/180,width/100,width/90,19);
    // PLayer piece ^
    
    for (int i=pcles.size()-1; i>=0; i--) {
        Particle p = (Pcle) pcles.get(i);
        p.update();
        if (p.a <= 0) {pcles.remove(i);}
    }
    
    fill(255);
    textAlign(CENTER);
    if (help) {
        textSize(ts/2);
        text("Remove the darkness by collecting color crystals!",width/2,ts);
    } else {
        textSize(ts);
        text("hexyl",width/2,ts);
    }
    
    if (px == ppx && py == ppy) {cost = 0;}
    if (dist(px,py,ppx,ppy) < 150*(ts/cts) && dist(px,py,ppx,ppy) > 1) {cost = 1;}
    if (dist(px,py,ppx,ppy) >= 150*(ts/cts) && dist(px,py,ppx,ppy) < 200*(ts/cts)) {cost = 2;}
    if (dist(px,py,ppx,ppy) >= 200*(ts/cts)) {cost = 3;}
    
    if (power >= 1) {
        fill(255);
        stroke(255);
        if (cost >= (power)) {
            fill(0);
            stroke(255);
        }
        ellipse(width/2 - height/15,height - height/20,height/20,height/20);
    }
    
    if (power >= 2) {
        fill(255);
        stroke(255);
        if (cost >= (power - 1)) {
            fill(0);
            stroke(255);
        }
        ellipse(width/2,height - height/20,height/20,height/20);
    }
    
    if (power == 3) {
        fill(255);
        stroke(255);
        if (cost >= (power - 2)) {
            fill(0);
            stroke(255);
        }
        ellipse(width/2 + height/15,height - height/20,height/20,height/20);
    }
    
    if (help) {
        fill(255);
        stroke(255);
        ellipse(width - ts/1.5,height - ts/1.5, ts, ts);
        fill(0);
        textSize(ts);
        text("?",width - ts/1.5,height - ts/2.7);
        textSize(ts/4);
        fill(255);
        text("You have " + power + " energy remaining. This jump will cost " + cost + " energy. Energy regenerates by 1 every turn.",width/2,height - height/10);
        if (gA[ms] > 0) {
            text("Quick! Get that crystal before it fades!",width/2,ts + (ts/2));
        } else {
            switch(lA[cs]) {
                case 1:
                    fill(255,255,0);
                    text("Careful! The floor under you is decaying!",width/2,ts + (ts/2));
                    break;
                case 2:
                    fill(255,0,0);
                    text("Careful! The floor under you will disappear next turn!",width/2,ts + (ts/2));
                    break;
            }
        }
    }
    if (!help) {
        fill(255);
        textSize(ts);
        text("?",width - ts/1.5,height - ts/2.7);
    }
    
    if (fader >= 2) {fader -= 2;}
    fill(255,0,0,fader);
    stroke(0,0);
    rect(0,0,width,height);
}

void hexa(x,y,r,h,i) {
    if (dist(mouseX,mouseY,x,y) < (r/4)*3 && lA[i] < 3 && i < 19) {
        ppx = x;
        ppy = y;
        ms = i;
    }
    if (px == x && py == y) {
        cs = i;
        if (gA[i] > 0) {
            switch(gA[i]) {
                case 1:
                    pc = color((red(pc) + 255)/2,(green(pc) + 0)/2,(blue(pc) + 0)/2);
                    break;
                case 2:
                    pc = color((red(pc) + 255)/2,(green(pc) + 127)/2,(blue(pc) + 0)/2);
                    break;
                case 3:
                    pc = color((red(pc) + 255)/2,(green(pc) + 255)/2,(blue(pc) + 0)/2);
                    break;
                case 4:
                    pc = color((red(pc) + 0)/2,(green(pc) + 255)/2,(blue(pc) + 0)/2);
                    break;
                case 5:
                    pc = color((red(pc) + 0)/2,(green(pc) + 0)/2,(blue(pc) + 255)/2);
                    break;
                case 6:
                    pc = color((red(pc) + 75)/2,(green(pc) + 0)/2,(blue(pc) + 130)/2);
                    break;
                case 7:
                    pc = color((red(pc) + 143)/2,(green(pc) + 0)/2,(blue(pc) + 255)/2);
                    break;
            }        
            cA[gA[i] - 1] = true;
            gA[i] = 0;
        }
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
            gA[i] = 0;
            break;
    }
    if (i >= 19) {
        fill(pc);
        stroke(pc);
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
        if ((red(pc) + 50) <= 255 && (green(pc) + 50) <= 255 && (blue(pc) + 50) <= 255) {
            fill(pc + color(50));
            stroke(pc + color(50));
        } else {
            fill(pc);
            stroke(pc);
        }
    }
    if (ppx == x && ppy == y) {
        stroke(pc);
    }
    if (i <= 18 && gA[i] > 0) {
        pcles.add(new Pcle(x,y,gA[i]));
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
    fader = 255;
    for(i = 0; i < lA.length; i++) {
        lA[i] = 0;
    }
    for(i = 0; i < gA.length; i++) {
        gA[i] = 0;
    }
    cs = 9;
    pc = color(0);
    power = 3;
    ppx = width/2;
    ppy = height/2;
    px = width/2;
    py = height/2;
}

class Pcle {
  float x;
  float y;
  float vx;
  float a = 255;
  float t;
 
  Pcle(ox,oy,ot) {
    x = ox;
    y = oy;
    t = ot;
  }
  
  void update() {
    vx += random(-0.5,0.5);
    x += vx;
    y -= 2;
    a -= 10;
    stroke(0,0);
    switch(t) {
        case 1:
            fill(255,0,0,a);
            break;
        case 2:
            fill(255,127,0,a);
            break;
        case 3:
            fill(255,255,0,a);
            break;
        case 4:
            fill(0,255,0,a);
            break;
        case 5:
            fill(0,0,255,a);
            break;
        case 6:
            fill(75,0,130,a);
            break;
        case 7:
            fill(143,0,255,a);
            break;
        
    }
    rect(x-width/200,y-width/200,width/100,width/100,width/1000);
  }
}