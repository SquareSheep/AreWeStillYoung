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
	if (currBeat == 8.5) for (Plant plant : par) plant.die();
	if (beatInRange(1,8.5)) {
		for (Plant plant : par) plant.grow(3);
		switch ((int)random(2)) {
			case 0:
			mobs.add(new Fern(random(-de,de),-de,0, de*0.1, 0,random(-PI,PI),PI/2, random(15,18), random(0.1,0.4)));
			break;
			case 1:
			mobs.add(new Fern(random(-de,de),de,0, de*0.1, 0,random(-PI,PI),-PI/2, random(15,18), random(0.1,0.4)));
			break;
		}
	} else if (beatInRange(8.5,25)) {
		if (currBeatQ == 0.5) {
			println(currBeat);
			
			mobs.add(new Tree(random(-de,de),de,0, de*0.2, 0,0,-PI/2, random(6,8), random(0.4,0.7),2));
			for (Plant plant : par) plant.grow(1);
		} else if (currBeatQ == 0) {
			for (int i = 0 ; i < segs.arm ; i ++) {
				println(i);
				PSeg seg = segs.ar.get(i);
				t = (float)frameCount/30;
				aAmp = 0.004/(8-seg.level);
				wAmp = 2/(8-seg.level);
				seg.ang.pm.set(random(-aAmp,aAmp),random(-aAmp,aAmp),random(-aAmp,aAmp));
				seg.w.pm.set(random(wAmp),0,0);
				seg.setIndex(i%binCount);
			}
		}
	} else if (beatInRange(25,74)) {
		//for (int i = 0 ; i < par.size() ; i ++) par.get(i).grow(6);
		//mobs.add(new Daisy(random(-de,de),-de,0, de*0.1, 0,random(-PI,PI),PI/2, random(15,18), random(0.1,0.4)));
	}
}

void keyboardInput() {
	switch(key) {
		case '1':
		setTime(0,0);
		break;
		case '2':
		setTime(0,0);
		break;
		case '3':
		setTime(0,0);
		break;
		case '4':
		setTime(0,0);
		break;
		case '5':
		setTime(0,0);
		break;
		case '6':
		setTime(0,0);
		break;
	}
}