/*
9
15-16 pew pew
25 scream yell sounds start
25,33,41, 49,57,65, 

74 "When.."
90 "Dreaming.."
106 "Now..."
118 "Are we still..."

Drop: 138
145, 154,
171 B section
177,

201 Quiet section

215 distored sounds

234 "Time..."
250 "Learned..."
266 "Why..."
278 "Are we"

Drop: 297
305, 313, 321,
330,338,346, yells

362 quiet part, outro
394 song end

*/

void addEvents() {

}

void instantEvents() {
	// Intro, children's voices
	if (beatInRange(1,8.5)) {
		for (Plant plant : par) plant.grow();
		for (int o = 0 ; o < 2 ; o ++) {
			switch ((int)random(3)) {
				case 0:
				mobs.add(new Fern(random(-de,de),-de,0, de*0.15, 0,random(-PI,PI),PI/2, random(12,15), random(0.1,0.4)));
				break;
				case 1:
				mobs.add(new Fern(random(-de,de),de,0, de*0.15, 0,random(-PI,PI),-PI/2, random(12,15), random(0.1,0.9)));
				break;
				case 2:
				mobs.add(new Daisy(random(-de,de),de,0, de*0.15, 0,random(-PI,PI),-PI/2, random(4,6), random(0.1,0.4)));
				break;
			}
		}
		segSetWPM(2,8);
		segSetAngPM(0.03,8);
		segSetFill(125,125,125, 55,55,-100, 3,3,3, 0,0,0);
	} // Chimes
	else if (beatInRange(8.5,24)) {
		if (currBeat == 8.5) {
			for (Plant plant : par) plant.die();
			for (float i = 0 ; i < 6 ; i ++) {
				t = i/6*2*PI;
				Tree mob = new Tree(0,0,0, de*0.2, 0,0,PI/2, random(5,7), random(0.4,0.7),2);
				mob.r.reset(0,de*0.1,0);
				mob.rang.reset(0,0,t);
				mob.rav.reset(0,0,0.01);
				mob.av.reset(0,-0.01,0);
				mobs.add(mob);
			}
		} else if (currBeat == 16.5) {
			for (float i = 0 ; i < 6 ; i ++) {
				t = i/6*2*PI+PI/3;
				Tree mob = new Tree(0,0,0, de*0.3, 0,1,PI/2, random(5,7), random(0.4,0.7),2);
				mob.r.reset(0,de*0.2,0);
				mob.rang.reset(0,0,t);
				mob.rav.reset(0,0,0.01);
				mob.av.reset(0,-0.01,0);
				mobs.add(mob);
			}
			for (Plant plant : par) plant.av.reset(0.03,0.01,0);
		} else if (currBeat > 23) {
			for (Plant plant : par) plant.kill(3);
		}
		
		if (currBeatQ == 0.5) for (Plant plant : par) plant.grow();
		segSetWPM(2,8);
		segSetAngPM(0.03,8);
		r = noise(frameCount*0.03);
		g = noise(frameCount*0.04);
		b = noise(frameCount*0.06);
		segSetFill(166*r,106*g,22*b, 0,0,0, 3*r,3*g,3*b, 3,-3,3);
	} // Yell cry sounds
	else if (beatInRange(24,73)) {
		if (currBeat == 24) {
			for (Plant plant : par) plant.die();
			cam.ang.P.set(0,0,0);
		}
		if (currBeat == 32 || currBeat == 40 || currBeat == 48 || currBeat == 56 || currBeat == 64 || currBeat == 72) {
			for (Plant plant : par) plant.die();
			for (int i = 0 ; i < 100 ; i ++) {
				far.add(random(-de,de),random(-de,de),random(de*0.5,de), random(de*0.5), 0,0,0);
			}
		} else if (currBeat < 72) {
			yellCryRing(random(6,18), randomR(0.005,0.02), 3);
		}
		for (int i = 0 ; i < par.size() ; i ++) par.get(i).grow(3);
		segSetWPM(0.5,8);
		segSetAngPM(0.01,8);
		r = noise(frameCount*0.03);
		g = noise(frameCount*0.04);
		b = noise(frameCount*0.06);
		segSetFill(75*r,125*g,75*b, -55*g,55*b,-55*r, 2,2,2, 0,0,0);
		floatSetFill(125*r,125*g,255*b, -100*g,125*b,-100*r, 2,2,2, 0,0,0);
	} // Lyrics section
	else if (beatInRange(73,136)) {
		if (currBeat == 73.5) {
			for (int i = 0 ; i < par.size() ; i ++) par.get(i).die();
			cam.ang.P.set(0,0,0);
		}
		if (currBeat == 73.5) textMap.get("when").draw(0,0,0);
		if (currBeat == 74.5) textMap.get("I").draw(-0.9,1,0);
		if (currBeat == 75.5) textMap.get("was").draw(0.5,1,0);
		if (currBeat == 76) textMap.get("younger").draw(0,2,0);
		if (currBeat == 77.5) textMap.get("I").draw(-1.1,3,0);
		if (currBeat == 78.5) textMap.get("could").draw(0.6,3,0);

		if (currBeat == 80.5) textMap.get("fall").draw(0,0,0);
		if (currBeat == 81.5) textMap.get("asleep").draw(0,1,0);
		if (currBeat == 82.5) textMap.get("at").draw(-1.2,2,0);
		if (currBeat == 83.5) textMap.get("night").draw(0.7,2,0, 120,150);

		if (currBeat == 89.5) textMap.get("dreaming").draw(0,0,0);
		if (currBeat == 91.5) textMap.get("of").draw(0,1,0);
		if (currBeat == 92.25) textMap.get("cotton").draw(-1.5,2,0);
		if (currBeat == 93.75) textMap.get("candy").draw(1.5,2,0);
		if (currBeat == 95.25) textMap.get("clouds").draw(0,3,0, 20,40);

		if (currBeat == 96.25) textMap.get("and").draw(0,0,0);
		if (currBeat == 97.25) textMap.get("jars").draw(-0.8,1,0);
		if (currBeat == 98.25) textMap.get("of").draw(0.7,1,0);
		if (currBeat == 99.75) textMap.get("fireflies").draw(0,2,0, 120,150);

		if (currBeat == 105.5) textMap.get("now").draw(-0.6,0,0);
		if (currBeat == 107.25) textMap.get("I").draw(0.9,0,0);
		if (currBeat == 107.75) textMap.get("lie").draw(-1.6,1,0);
		if (currBeat == 109) textMap.get("awake").draw(0.8,1,0, 60,90);

		if (currBeat == 111.75) textMap.get("the").draw(-1.85,0,0);
		if (currBeat == 112.5) textMap.get("fantasy").draw(1.1,0,0, 60,90);
		if (currBeat == 114.5) textMap.get("is").draw(0,1,0);
		if (currBeat == 115.5) textMap.get("gone").draw(0,2,0, 40,60);

		if (currBeat == 117) textMap.get("are").draw(-0.9,0,0);
		if (currBeat == 117.5) textMap.get("we").draw(1.1,0,0);
		if (currBeat == 118.5) textMap.get("still").draw(0,1,0);
		if (currBeat == 119.5) textMap.get("young").draw(0,2,0);
		if (currBeat == 121.5) textMap.get("are").draw(-0.9,0,0);
		if (currBeat == 122) textMap.get("we").draw(1.1,0,0);
		if (currBeat == 123) textMap.get("still").draw(0,1,0);
		if (currBeat == 124) textMap.get("young").draw(0,2,0);
		if (currBeat == 126) textMap.get("are").draw(-0.9,0,0);
		if (currBeat == 126.5) textMap.get("we").draw(1.1,0,0);
		if (currBeat == 127.5) textMap.get("still").draw(0,1,0, 90,200);

		if (currBeat == 133) textMap.get("are").draw(-0.9,0,0);
		if (currBeat == 133.5) textMap.get("we").draw(1.1,0,0);
		if (currBeat == 134.5) textMap.get("still").draw(0,1,0);
		if (currBeat == 135.5) textMap.get("young").draw(0,2,0);

		for (int i = 0 ; i < far.arm ; i ++) {
			t = (float)i/far.arm;
			Float mob = far.get(i);
			mob.setIndex(i%binCount);
			mob.p.P.z += sin((float)i/100+(float)frameCount/100)*15;
		}
		r = noise(frameCount*0.03);
		g = noise(frameCount*0.04);
		b = noise(frameCount*0.06);
		floatSetFill(175*r,175*g,255*b, -55*g,125*b,-55*r, 2,2,2, 0,0,0);
	} else if (beatInRange(136,171)) {

	}
	segSetIndex();
}

void keyboardInput() {
	switch(key) {
		case '1':
		setTime(3877,7);
		break;
		case '2':
		setTime(13165,24);
		break;
		case '3':
		setTime(38800,71);
		break;
		case '4':
		setTime(48065,88);
		break;
		case '5':
		setTime(56261,103);
		break;
		case '6':
		setTime(0,0);
		break;
	}
}

void segSetWPM(float amp, int maxLevel) {
	for (int i = 0 ; i < segs.arm ; i ++) {
		PSeg seg = segs.ar.get(i);
		seg.w.pm.set(amp/(maxLevel-seg.level),0,0);
	}
}

void segSetAngPM(float amp, int maxLevel) {
	for (int i = 0 ; i < segs.arm ; i ++) {
		PSeg seg = segs.ar.get(i);
		seg.ang.pm.set(amp/(maxLevel-seg.level),0,0);
	}
}

void segSetIndex() {
	for (int i = 0 ; i < segs.arm ; i ++) segs.ar.get(i).setIndex(i%binCount);
}

void segSetFill(float rc, float gc, float bc, float rcr, float gcr, float bcr, 
	float rm, float gm, float bm, float rmr, float gmr, float bmr) {
	for (int i = 0 ; i < segs.arm ; i ++) {
		PSeg mob = segs.ar.get(i);
		temp = (float)frameCount/30;
		t = (float)i/segs.arm;
		mob.fillStyle.set(rc+rcr*t,gc+gcr*t,bc+bcr*t,75, rm+rmr*t,gm+gmr*t,bm+bmr*t,1);
		mob.strokeStyle.set(rc+rcr*t,gc+gcr*t,bc+bcr*t,255, rm+rmr*t,gm+gmr*t,bm+bmr*t,0);
	}
}

void floatSetFill(float rc, float gc, float bc, float rcr, float gcr, float bcr, 
	float rm, float gm, float bm, float rmr, float gmr, float bmr) {
	for (int i = 0 ; i < far.arm ; i ++) {
		Float mob = far.ar.get(i);
		temp = (float)frameCount/30;
		t = (float)i/far.arm;
		mob.fillStyle.set(rc+rcr*t,gc+gcr*t,bc+bcr*t,75, rm+rmr*t,gm+gmr*t,bm+bmr*t,1);
		mob.strokeStyle.set(rc+rcr*t,gc+gcr*t,bc+bcr*t,255, rm+rmr*t,gm+gmr*t,bm+bmr*t,0);
	}
}