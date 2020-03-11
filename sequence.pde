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
	for (int i = 0 ; i < par.size() ; i ++) par.get(i).grow(3);
	if (beatInRange(1,8.75)) {
		switch ((int)random(2)) {
			case 0:
			mobs.add(new Fern(0,0,0, de*0.1, random(-PI,PI),random(-PI,PI),random(-PI,PI), random(6,9), random(0.1,0.3)));
			break;
			case 1:
			mobs.add(new Rose(0,0,0, de*0.1, random(-PI,PI),random(-PI,PI),random(-PI,PI), random(6,9), random(0.1,0.3)));
			break;
		}
	} else if (beatInRange(8.75,25)) {
		if (currBeatQ == 0.25) {
			mobs.add(new Fern(0,0,0, de*0.1, random(-PI,PI),random(-PI,PI),random(-PI,PI), random(12,15), random(0.1,0.3)));
			mobs.add(new Daisy(0,0,0, de*0.1, random(-PI,PI),random(-PI,PI),random(-PI,PI), random(12,15), random(0.1,0.3)));
			for (int i = 0 ; i < min(3,par.size()) ; i ++) {
				par.get(i).die();
			}
			for (PSeg seg : segs.ar) seg.effect(0, 0,2,0.1);
		}
	} else if (currBeat < 74) {

	} else if (currBeat < 90) {

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