import geomerative.*;
static float bpm = 110;
static float beatInc = 0.5;
static int threshold = 100;
static int offset = -50;
static int binCount = 144;
static float defaultMass = 20;
static float defaultVMult = 0.9;
static float fillMass = 2;
static float fillVMult = 0;
static float fftThreshold = 1.6;
static float fftPow = 2.3;
static float fftAmp = 2;
static float volumeGain = -8;
static String songName = "../Music/riptide.mp3";

IColor defaultFill = new IColor(255,255,255,255);
IColor defaultStroke = new IColor(255,255,255,255);

PSegPool segs = new PSegPool();
void render() {
	segs.update();

	if (timer.beat) println(segs.ar.size());
	if (timer.beat && currBeat == 3) {
		for (int i = 0 ; i < 1 ; i ++) {
			//mobs.add(new Flower(0,0,0, de*0.1, random(-PI,PI),random(-PI,PI),random(-PI,PI), random(7,15), random(0.1,0.5)));
			//mobs.add(new Fern(0,0,0, de*0.1, random(-PI,PI),random(-PI,PI),random(-PI,PI), random(12,15), random(0.1,0.3)));
		}
	}
	if (beatQ && currBeat % 10 >= 6) {
		for (int i = 0 ; i < mobs.size() ; i ++) {
			Plant mob = (Plant)mobs.get(i);
			mob.kill();
		}
	}
	if (frameCount % 5 == 0 && currBeat % 10 < 6) {
		for (int i = 0 ; i < mobs.size() ; i ++) {
			Plant mob = (Plant) mobs.get(i);
			mob.spawn();
		}
	}
	if (frameCount % 10 == 0) {
		for (int i = 0 ; i < segs.arm ; i ++) {
			PSeg mob = segs.ar.get(i);
			t = (float)frameCount/30;
			temp = (float)i/segs.arm;
			r = noise(mob.level*0.05,100+t,temp*5);
			g = noise(mob.level*0.05,1000+t,temp*5);
			b = noise(mob.level*0.05,3000+t,temp*5);
			r2 = noise(mob.level*0.05,3500+t,temp*5);
			g2 = noise(mob.level*0.05,100+t,temp*5);
			b2 = noise(mob.level*0.05,6000+t,temp*5);
			// r = temp;
			// g = (1-temp);
			// b = noise(temp,i*0.01);
			mob.setIndex((float)i/segs.arm*binCount);
			mob.fillStyle.set(r*255,g*155,b*155,255, r*2,g*2,b*0.5,0);
			mob.strokeStyle.set(r2*255,g2*255,b2*255,255, r2*2,g2*2,b2*0.5,0);

			aAmp = noise(i*0.01,t)*0.001/(16-mob.level);
			wAmp = noise(i*0.01,t)*0.7/(16-mob.level);
			mob.ang.pm.set(random(-aAmp,aAmp),random(-aAmp,aAmp),random(-aAmp,aAmp));
			mob.w.pm.set(random(wAmp),0,0);
		}
	}
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);
	strokeWeight(4);
	strokeCap(ROUND);
	strokeJoin(ROUND);

	cam.av.reset(0,-0.002,0);
	mobs.add(new Tree(0,de,0, de*0.15, 0,0,-PI/2, 12,2,0.4));
}