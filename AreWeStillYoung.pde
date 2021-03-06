import ddf.minim.analysis.*;
import ddf.minim.*;

Minim mim;
AudioPlayer song;
ddf.minim.analysis.FFT fft;
float[] af = new float[binCount];
float max;
float avg;

// Events initialize and store all of their own mobs
ArrayList<Event> events = new ArrayList<Event>();

// Used to store global animation entities
ArrayList<Entity> mobs = new ArrayList<Entity>();

Camera cam;
static int de;
static PVector front;
static PVector back;


BeatTimer timer;
float currTime;
float currBeat;
float currBeatQ;
float currBeatF;
static float fpb;
static int fphb, fpqb;
int currFrame;

static float cos60 = cos(PI/3);

char keyR;
char keyP;
boolean beatQ = false;

float temp, x,y,z, x2,y2,z2, w,d, tick, r,g,b,a, r2,g2,b2,a2, i,j,k,o,t, amp,wAmp,aAmp,vAmp,fAmp,sAmp;

void setup() {
  size(1100,1100,P3D);
  de = (int)((width*0.5+height*0.5)*1.2);
  front = new PVector(de*2,de,de*0.2);
  back = new PVector(-de*2,-de,-de*2);

  cam = new Camera(width/2,height*0.5,-de*1.2, 0,0,0);

  textSize(de/10);
  rectMode(CENTER);
  textAlign(CENTER);

  RG.init(this);
  textMap.put("when", new TextHolder("When"));
  textMap.put("I", new TextHolder("I"));
  textMap.put("was", new TextHolder("was"));
  textMap.put("younger", new TextHolder("younger"));
  textMap.put("could", new TextHolder("could"));
  textMap.put("fall", new TextHolder("Fall"));
  textMap.put("asleep", new TextHolder("asleep"));
  textMap.put("at", new TextHolder("at"));
  textMap.put("night", new TextHolder("night"));
  textMap.put("dreaming", new TextHolder("Dreaming"));
  textMap.put("of", new TextHolder("of"));
  textMap.put("cotton", new TextHolder("cotton"));
  textMap.put("candy", new TextHolder("candy"));
  textMap.put("clouds", new TextHolder("Clouds"));
  textMap.put("and", new TextHolder("and"));
  textMap.put("jars", new TextHolder("jars"));
  textMap.put("fireflies", new TextHolder("fireflies"));
  textMap.put("now", new TextHolder("Now"));
  textMap.put("lie", new TextHolder("lie"));
  textMap.put("awake", new TextHolder("awake"));
  textMap.put("the", new TextHolder("The"));
  textMap.put("fantasy", new TextHolder("fantasy"));
  textMap.put("is", new TextHolder("is"));
  textMap.put("gone", new TextHolder("gone"));
  textMap.put("are", new TextHolder("Are"));
  textMap.put("we", new TextHolder("we"));
  textMap.put("still", new TextHolder("still"));
  textMap.put("young", new TextHolder("young?"));
  textMap.put("time", new TextHolder("Time"));
  textMap.put("runs", new TextHolder("runs"));
  textMap.put("me", new TextHolder("me"));
  textMap.put("over", new TextHolder("over"));
  textMap.put("I've", new TextHolder("I've"));
  textMap.put("grown", new TextHolder("grown"));
  textMap.put("some", new TextHolder("some"));
  textMap.put("thicker", new TextHolder("thicker"));
  textMap.put("skin", new TextHolder("skin"));
  textMap.put("learned", new TextHolder("Learned"));
  textMap.put("to", new TextHolder("to"));
  textMap.put("be", new TextHolder("be"));
  textMap.put("skeptical", new TextHolder("skeptical"));
  textMap.put("Of", new TextHolder("of"));
  textMap.put("those", new TextHolder("Those"));
  textMap.put("with", new TextHolder("with"));
  textMap.put("good", new TextHolder("good"));
  textMap.put("intentions", new TextHolder("intentions"));
  textMap.put("why", new TextHolder("Why"));
  textMap.put("it", new TextHolder("it"));
  textMap.put("hard", new TextHolder("hard"));
  textMap.put("love", new TextHolder("love"));
  textMap.put("without", new TextHolder("Without"));
  textMap.put("hurting", new TextHolder("hurting"));
  textMap.put("anyone", new TextHolder("anyone"));

  mim = new Minim(this);
  song = mim.loadFile(songName, 1024);
  fft = new FFT(song.bufferSize(), song.sampleRate());

  timer = new BeatTimer(threshold,offset,bpm);
  fpb = 3600/bpm;
  fphb = (int)(fpb*0.5);
  fpqb = (int)(fpb*0.25);
  
  song.loop();
  song.setGain(volumeGain);

  setSketch();
  addEvents();
}

void draw() {
  if (timer.beat) println(song.position() + "," + (int)(currBeat));
  background(33,11,55);
  cam.render();
  update();

  render();

  for (Entity mob : mobs) {
    if (mob.draw) mob.render();
  }

  fill(255);
  //drawBorders();
  //drawWidthBox(de);
  //drawPitches();
  // push();
  // translate(0,de*0.75,0);
  // text(currBeat + " " + (int)frameRate,0,0);
  // pop();
}

void update() {
  calcFFT();

  currTime = song.position();

  beatQ = timer.beat;
  if (timer.beat) {
    currFrame = 0;
    currBeat += 0.25;
    currBeatF = currBeat - currBeat%1;
  }
  currFrame ++;
  if (currFrame == fpqb || currFrame == fphb || currFrame == fpqb*3) {
    currBeat += 0.25;
    beatQ = true;
  }
  if (beatQ) currBeatQ = currBeat % 1;

  cam.update();
  timer.update();

  updateEvents();

  for (Entity mob : mobs) {
    mob.update();
  }
  for (int i = 0 ; i < mobs.size() ; i ++) {
    if (mobs.get(i).finished) mobs.remove(i);
  }
}

void updateEvents() {
  for (int i = 0 ; i < events.size() ; i ++) {
    Event event = events.get(i);
    if (currBeat >= event.time && currBeat < event.timeEnd) {
      if (!event.spawned) {
        event.spawned = true;
        event.spawn();
      }
      event.update();
      event.render();
      if (currBeat == event.timeEnding && !event.ending) {
        event.ending = true;
        event.ending();
      }
    } else if (currBeat >= event.timeEnd) {
        if (!event.spawned) {
          event.spawned = true;
          event.spawn();
        }
        if (!event.finished) event.end();
        event.finished = true;
    }
  }
}

void calcFFT() {
  fft.forward(song.mix);

  avg = 0;
  max = 0;
  float temp;
  for (int i = 0 ; i < af.length ; i ++) {
    temp = 0;
    for (int k = i ; k < fft.specSize() ; k += i + 1) {
      temp += fft.getBand(k);
    }
    temp /= af.length / (i + 1);
    temp = pow(temp,fftPow);
    avg += temp;
    af[i] = temp;
  }
  avg /= af.length;

  for (int i = 0 ; i < af.length ; i ++) {
    if (af[i] < avg*fftThreshold) {
      af[i] /= fftAmp;
    } else {
      af[i] += (af[i] - avg * fftThreshold) /fftAmp;
    }
    if (af[i] > max) max = af[i];
  }
}

void mousePressed() {
  float temp = ((float)mouseX / width) * song.length();
  float tempBeat = ((temp+timer.offset)/60000.0*bpm);
  tempBeat = tempBeat - tempBeat%0.5;
  println(tempBeat);
  for (Event event : events) {
    if (tempBeat <= event.time) {
      event.spawned = false;
      event.finished = false;
    }
    if (currBeat >= event.time && currBeat < event.timeEnd) {
      if (tempBeat < event.time || tempBeat >= event.timeEnd) event.end();
    }
  }
  song.cue((int)temp);
  currBeat = tempBeat;
}

void setTime(float time) {
  float beat = ((time-timer.offset)/60000.0*bpm);
  beat = beat - beat%0.5;
  setTime(time, beat);
}

void setTime(float time, float beat) {
  for (Event event : events) {
    if (beat <= event.time) {
      event.spawned = false;
      event.finished = false;
    }
    if (currBeat >= event.time && currBeat < event.timeEnd) {
      if (beat < event.time || beat >= event.timeEnd) event.end();
    }
  }
  song.cue((int)time);
  currBeat = beat;
  timer.resetBooleans();
}

void keyPressed() {
  if (key == 'e') {
    if (!cam.lock) {
      cam.lock = true;
      cam.ang.P.set(cam.dang.x, cam.dang.y, cam.dang.z);
    } else {
      cam.lock = false;
    }
    println("Cam lock: " + cam.lock);
  } else {
    println("KEY: " + key + " " + (int)currTime + " " + currBeat + " " + (int)frameRate + cam.ang.p.x + ","+cam.ang.p.y + "," + cam.ang.p.z);
    keyP = key;
    keyboardInput();
  }
}

void drawPitches() {
  push();
  fill(255);
  translate(0,height,0);
  for (int i = 0 ; i < binCount ; i ++) {
    float w = width/(float)binCount;
    translate(w, 0,0);
    rect(0,0,w,af[i]*10);
  }
  pop();
}

void drawBorders() {
  noFill();
  stroke(255);
  push();
  translate(0,0,-de);
  rect(0,0,de*2,de*2);
  pop();
  line(de,de,de,de,de,-de);
  line(de,-de,de,de,-de,-de);
  line(-de,de,de,-de,de,-de);
  line(-de,-de,de,-de,-de,-de);
}

void drawWidthBox(float w) {
  push();
  textSize(w/10);
  push();
  translate(0,0,0);
  text("0,0,0",0,0);
  pop();

  push();
  translate(w,w,w);
  text("1,1,1",0,0);
  pop();

  push();
  translate(-w,w,w);
  text("-1,1,1",0,0);
  pop();

  push();
  translate(-w,-w,w);
  text("-1,-1,1",0,0);
  pop();

  push();
  translate(w,-w,w);
  text("1,-1,-1",0,0);
  pop();

  push();
  translate(w,w,-w);
  text("1,1,-1",0,0);
  pop();

  push();
  translate(-w,w,-w);
  text("-1,1,-1",0,0);
  pop();

  push();
  translate(-w,-w,-w);
  text("-1,-1,-1",0,0);
  pop();

  push();
  translate(w,-w,-w);
  text("1,-1,-1",0,0);
  pop();
  pop();
}