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

void instantEvents() {
	// Children's voices
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
		segSetFill(175,175,175, 125,-125,125);
	} // Bass chimes
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
		segSetFill(166,106,22, 75,55,15);
	} // Yell cry ring 1
	else if (beatInRange(24,73)) {
		if (currBeat == 24) {
			for (Plant plant : par) plant.die();
			cam.ang.P.set(0,0,0);
		}
		if (currBeat == 32 || currBeat == 40 || currBeat == 48 || currBeat == 56 || currBeat == 64 || currBeat == 72) {
			for (Plant plant : par) {
				plant.die();
				plant.rv.reset(0,0,random(20,30));
			}
			for (int i = 0 ; i < 100 ; i ++) {
				far.add(random(-de,de),random(-de,de),random(-de,de), random(de*0.02,de*0.1), 0,0,0).pv.reset(random(-10,10),random(-10,10),random(-10,10));
			}
		} else if (currBeat < 72) {
			yellCryRing(random(6,18), randomR(0.005,0.02), 3);
		}
		for (int i = 0 ; i < par.size() ; i ++) par.get(i).grow(3);
		segSetWPM(0.5,8);
		segSetAngPM(0.01,8);
		segSetFill(100,175,100, -100,155,-100);
		floatSetFill(125,125,255, -100,125,-100);
	} // Lyrics 1
	else if (beatInRange(73,136)) {
		if (currBeat == 73.5) {
			for (int i = 0 ; i < par.size() ; i ++) par.get(i).die();
			cam.ang.P.set(0,0,0);
		}
		if (currBeat == 103.5 || currBeat == 135.75) {
			for (int i = 0 ; i < far.arm ; i ++) far.ar.get(i).lifeSpan = 0;
		} else if (currBeat < 135) {
			Float mob = far.add(random(-de,de),random(-de,de),random(-de,0), random(de*0.03,de*0.06), 0,0,0);
			mob.pv.reset(random(-3,3),random(-3,3),random(-3,3));
			mob.lifeSpan = 600;
		}

		if (currBeat == 73.5) textMap.get("when").draw(0,0,0, 77);
		if (currBeat == 74.5) textMap.get("I").draw(-0.9,1,0, 77);
		if (currBeat == 75.5) textMap.get("was").draw(0.5,1,0, 77);
		if (currBeat == 76) textMap.get("younger").draw(0,2,0, 77);

		if (currBeat == 77.5) textMap.get("I").draw(-1.1,1,0, 80);
		if (currBeat == 78.5) textMap.get("could").draw(0.6,1,0, 80);

		if (currBeat == 80.5) textMap.get("fall").draw(0,0,0, 89);
		if (currBeat == 81.5) textMap.get("asleep").draw(0,1,0, 89);
		if (currBeat == 82.5) textMap.get("at").draw(-1.2,2,0, 89);
		if (currBeat == 83.5) textMap.get("night").draw(0.7,2,0, 89);

		if (currBeat == 89.5) textMap.get("dreaming").draw(0,0,0, 94.75);
		if (currBeat == 91.5) textMap.get("of").draw(0,1,0, 94.75);
		if (currBeat == 92.25) textMap.get("cotton").draw(-1.5,2,0, 94.75);
		if (currBeat == 93.75) textMap.get("candy").draw(1.5,2,0, 94.75);

		if (currBeat == 95.5) textMap.get("clouds").draw(-1.1,0,0, 105);
		if (currBeat == 96.5) textMap.get("and").draw(1.4,0,0, 105);
		if (currBeat == 97.5) textMap.get("jars").draw(-0.8,1,0, 105);
		if (currBeat == 98.5) textMap.get("of").draw(0.7,1,0, 105);
		if (currBeat == 100) textMap.get("fireflies").draw(0,2,0, 105);

		if (currBeat == 105.5) textMap.get("now").draw(-0.6,0,0, 111.25);
		if (currBeat == 107.25) textMap.get("I").draw(0.9,0,0, 111.25);
		if (currBeat == 107.75) textMap.get("lie").draw(-1.6,1,0, 111.25);
		if (currBeat == 109) textMap.get("awake").draw(0.8,1,0, 111.25);

		if (currBeat == 111.75) textMap.get("the").draw(-1.85,0,0, 116.5);
		if (currBeat == 112.5) textMap.get("fantasy").draw(1.1,0,0, 116.5);
		if (currBeat == 114.5) textMap.get("is").draw(0,1,0, 116.5);
		if (currBeat == 115.5) textMap.get("gone").draw(0,2,0, 116.5);

		if (currBeat == 117) textMap.get("are").draw(-0.9,0,0, 121);
		if (currBeat == 117.5) textMap.get("we").draw(1.1,0,0, 121);
		if (currBeat == 118.5) textMap.get("still").draw(0,1,0, 121);
		if (currBeat == 119.5) textMap.get("young").draw(0,2,0, 121);

		if (currBeat == 121.5) textMap.get("are").draw(-0.9,0,0, 125.5);
		if (currBeat == 122) textMap.get("we").draw(1.1,0,0, 125.5);
		if (currBeat == 123) textMap.get("still").draw(0,1,0, 125.5);
		if (currBeat == 124) textMap.get("young").draw(0,2,0, 125.5);

		if (currBeat == 126) textMap.get("are").draw(-0.9,0,0, 132.5);
		if (currBeat == 126.5) textMap.get("we").draw(1.1,0,0, 132.5);
		if (currBeat == 127.5) textMap.get("still").draw(0,1,0, 132.5);

		if (currBeat == 133) textMap.get("are").draw(-0.9,0,0, 136);
		if (currBeat == 133.5) textMap.get("we").draw(1.1,0,0, 136);
		if (currBeat == 134.5) textMap.get("still").draw(0,1,0, 136);
		if (currBeat == 135.5) textMap.get("young").draw(0,2,0, 136);

		lyricsSinWaves();
		floatSetFill(125,125,255, -100,125,-100);
	} // Yell cry sounds 1
	else if (beatInRange(136,169)) {
		if (currBeat == 136) {
			for (Plant plant : par) plant.die();
			for (int i = 0 ; i < far.arm ; i ++) far.get(i).lifeSpan = 0;
			cam.ang.P.set(0,0,0);
		} else if (currBeatF == 144 || currBeatF == 160) {
			for (Plant plant : par) plant.die();
			for (int i = 0 ; i < far.arm ; i ++) far.ar.get(i).lifeSpan = 0;
		} else if (beatInRange(151.25,152.25)) {
			for (Plant plant : par) plant.kill(2);
			for (int i = 0 ; i < far.arm ; i ++) far.ar.get(i).lifeSpan = 0;
		} else if (beatInRange(166.5,169)) {
			if (par.size() > 0) for (int o = 0 ; o < 3 ; o ++) par.get((int)random(par.size())).die();
		} else {
			yellCryMain();
		}

		for (int i = 0 ; i < par.size() ; i ++) if (par.get(i).p.p.z > de*1.1) par.get(i).die();
		segSetWPM(0.25,8);
		segSetAngPM(0.005,8);
		segSetFill(125,222,75, 75,-125,75);
		floatSetFill(125,175,255, 125,125,125);
	} // Scream trees 1
	else if (beatInRange(169,176)) {
		if (currBeat == 169) {
			for (Plant plant : par) plant.die();
			for (int i = 0 ; i < far.arm ; i ++) far.get(i).lifeSpan = 0;
			cam.ang.P.set(-0.3,0,0);
		} else {
			screamTrees();
		}
		segSetWPM(0.25,8);
		segSetAngPM(0.005,8);
		segSetFill(166,106,22, 75,55,15);
		floatSetFill(125,75,75, -55,-55,55);
	} // Yell cry sounds 2
	else if (beatInRange(176,184)) {
		if (currBeat == 176) {
			for (Plant plant : par) plant.die();
			for (int i = 0 ; i < far.arm ; i ++) far.get(i).lifeSpan = 0;
			cam.ang.P.set(0,0,0);
		} else if (beatInRange(182.5,184)) {
			for (Plant plant : par) plant.kill(2);
			for (int i = 0 ; i < far.arm ; i ++) far.ar.get(i).lifeSpan = 0;
		} else {
			yellCryMain();
		}

		for (int i = 0 ; i < par.size() ; i ++) if (par.get(i).p.p.z > de*1.1) par.get(i).die();
		segSetWPM(0.25,8);
		segSetAngPM(0.005,8);
		segSetFill(125,222,75, 75,-125,75);
		floatSetFill(125,175,255, 125,125,125);
	} //"Bwuhh" stab
	else if (beatInRange(184,186)) {
		if (currBeat == 184) {
			for (Plant plant : par) plant.die();
		} else {
			float angOffset = random(PI);
			for (float o = 0 ; o < 5 ; o ++) {
				t = o/5;
				Plant mob = new Fern(0,0,0, de*0.2, 0,0,t*2*PI+angOffset, random(12,15), randomR(0.1,0.2));
				mob.rav.reset(0,0,randomR(0.01,0.03));
				mobs.add(mob);
			}
			for (float o = 0 ; o < 5 ; o ++) {
				t = o/5;
				Plant mob = new Curl(0,0,0, de*0.1, 0,0,t*2*PI+angOffset, random(12,15), randomR(0.5,0.8));
				mob.rav.reset(0,0,randomR(0.01,0.03));
				mobs.add(mob);
			}
			for (Plant plant : par) plant.grow(5);
			segSetWPM(0.05,8);
			segSetAngPM(0.005,8);
			segSetFill(125,222,75, 75,-125,75);
			floatSetFill(125,175,255, 125,125,125);
		}
	} // Scream trees 3
	else if (beatInRange(186,192)) {
		if (currBeat == 186) {
			for (Plant plant : par) plant.die();
			for (int i = 0 ; i < far.arm ; i ++) far.get(i).lifeSpan = 0;
			cam.ang.P.set(-0.3,0,0);
		} else {
			screamTrees();
		}
		segSetWPM(0.25,8);
		segSetAngPM(0.005,8);
		segSetFill(166,106,22, 75,55,15);
		floatSetFill(75,100,125, 55,55,55);
	} // Yell cry sounds 4
	else if (beatInRange(192,200)) {
		if (currBeat == 192) {
			for (Plant plant : par) plant.die();
			for (int i = 0 ; i < far.arm ; i ++) far.get(i).lifeSpan = 0;
			cam.ang.P.set(0,0,0);
		} else if (currBeat > 198) {
			for (Plant plant : par) plant.kill(1);
			for (int i = 0 ; i < far.arm ; i ++) far.ar.get(i).lifeSpan = 0;
		} else {
			yellCryMain();
		}

		for (int i = 0 ; i < par.size() ; i ++) if (par.get(i).p.p.z > de*1.1) par.get(i).die();
		segSetWPM(0.25,8);
		segSetAngPM(0.005,8);
		segSetFill(125,222,75, 75,-125,75);
		floatSetFill(125,175,255, 125,125,125);
	} // Quiet bridge
	else if (beatInRange(200,233)) {
		if (currBeat == 200) {
			for (Plant plant : par) plant.die();
			for (int i = 0 ; i < far.arm ; i ++) far.get(i).lifeSpan = 0;
			cam.ang.P.set(0,0,0);
			Plant tree = new Tree(0,de*0.5,0, de*0.15, 0,0,-PI/2, 9,0.5,2);
			tree.av.reset(0,-0.006,0);
			mobs.add(tree);
		}
		for (int o = 0 ; o < 2 ; o ++) {
			Float mob = far.add(randomR(de),randomR(de), randomR(de), random(de*0.01,de*0.03));
			mob.pv.reset(randomR(3),randomR(3),randomR(3));
			mob.lifeSpan = 360;
		}
		Plant mob;
		switch((int)random(3)) {
			case 0:
			mob = new Daisy(0,de*0.5,0, de*0.05, 0,0,-PI/2);
			break;
			case 1:
			mob = new Fern(0,de*0.5,0, de*0.05, 0,0,-PI/2);
			break;
			default:
			mob = new Curl(0,de*0.5,0, de*0.05, 0,0,-PI/2);
		}
		mob.r.reset(0,0,random(de*0.75));
		mob.rang.reset(0,random(-PI,PI),0);
		mob.rav.reset(0,-0.006,0);
		mobs.add(mob);
		for (Plant plant : par) plant.grow();
		segSetWPM(0.1,10);
		segSetAngPM(0.005,10);
		segSetFill(166,166,166, 125,75,-55);
		floatSetFill(125,125,125, -155,155,155);
	} // Lyrics 2
	else if (beatInRange(233,296)) {
		if (currBeat == 233) {
			for (Plant plant : par) plant.die();
			for (int i = 0 ; i < far.arm ; i ++) far.ar.get(i).lifeSpan = 0;
		} else if (currBeat == 234) {
			far.ar.clear();
			far.arm = 0;
			segs.ar.clear();
			segs.arm = 0;
			par.clear();
		}
		if (currBeat == 249.5 || currBeat == 272) {
			for (int i = 0 ; i < far.arm ; i ++) far.ar.get(i).lifeSpan = 0;
		} else if (currBeat < 296) {
			Float mob = far.add(random(-de,de),random(-de,de),random(-de,0), random(de*0.03,de*0.06), 0,0,0).pv.reset(random(-3,3),random(-3,3),random(-3,3));
		}
		if (currBeat == 235.5) textMap.get("time").draw(-1.2,0,0, 239);
		if (currBeat == 236.5) textMap.get("runs").draw(1.2,0,0, 239);
		if (currBeat == 237.5) textMap.get("me").draw(-1.4,1,0, 239);
		if (currBeat == 238) textMap.get("over").draw(0.7,1,0, 239);

		if (currBeat == 239.5) textMap.get("and").draw(-1,1,0, 242);
		if (currBeat == 240.5) textMap.get("I've").draw(1,1,0, 242);

		if (currBeat == 242.5) textMap.get("grown").draw(-1.5,0,0, 249.5);
		if (currBeat == 243.5) textMap.get("some").draw(1.3,0,0, 249.5);
		if (currBeat == 244) textMap.get("thicker").draw(0,1,0, 249.5);
		if (currBeat == 245.75) textMap.get("skin").draw(0,2,0, 249.5);

		if (currBeat == 251.5) textMap.get("learned").draw(0,0,0, 258);
		if (currBeat == 252.5) textMap.get("to").draw(-0.7,1,0, 258);
		if (currBeat == 253.5) textMap.get("be").draw(0.7,1,0, 258);
		if (currBeat == 254) textMap.get("skeptical").draw(-0.8,2,0, 258);
		if (currBeat == 256.5) textMap.get("of").draw(1.9,2,0, 258);

		if (currBeat == 258.5) textMap.get("those").draw(0,0,0, 266);
		if (currBeat == 259.5) textMap.get("with").draw(-1.15,1,0, 266);
		if (currBeat == 260) textMap.get("good").draw(1.15,1,0, 266);
		if (currBeat == 261) textMap.get("intentions").draw(0,2,0, 266);

		if (currBeat == 267) textMap.get("why").draw(-1.4,0,0, 272);
		if (currBeat == 268.75) textMap.get("is").draw(0.3,0,0, 272);
		if (currBeat == 269) textMap.get("it").draw(1.4,0,0, 272);
		if (currBeat == 269.5) textMap.get("hard").draw(-0.7,1,0, 272);
		if (currBeat == 270.5) textMap.get("to").draw(1.3,1,0, 272);
		if (currBeat == 271.5) textMap.get("love").draw(0,2,0, 272);

		if (currBeat == 272.5) textMap.get("without").draw(0,0,0, 278.75);
		if (currBeat == 274.5) textMap.get("hurting").draw(0,1,0, 278.75);
		if (currBeat == 275.5) textMap.get("anyone").draw(0,2,0, 278.75);

		if (currBeat == 280) textMap.get("are").draw(-0.9,0,0, 283);
		if (currBeat == 280.5) textMap.get("we").draw(1.1,0,0, 283);
		if (currBeat == 281.25) textMap.get("still").draw(0,1,0, 283);
		if (currBeat == 282.25) textMap.get("young").draw(0,2,0, 283);

		if (currBeat == 284) textMap.get("are").draw(-0.9,0,0, 287);
		if (currBeat == 284.5) textMap.get("we").draw(1.1,0,0, 287);
		if (currBeat == 285.25) textMap.get("still").draw(0,1,0, 287);
		if (currBeat == 286.25) textMap.get("young").draw(0,2,0, 287);

		if (currBeat == 287.5) textMap.get("are").draw(-0.9,0,0, 294.5);
		if (currBeat == 288) textMap.get("we").draw(1.1,0,0, 294.5);
		if (currBeat == 288.75) textMap.get("still").draw(0,1,0, 294.5);

		//lyricsSinWaves();
		floatSetFill(255,125,125, -100,-125,125);
	} // Drop vocal
	/*else if (beatInRange(296,299)) {
		if (currBeat == 296) {
			for (Plant plant : par) plant.die();
		} else {
			for (int o = 0 ; o < 15 ; o ++) {
				Float mob = far.add(randomR(de),randomR(de), randomR(de), random(de*0.01,de*0.03));
				mob.pv.reset(randomR(10),randomR(10),randomR(10));
			}
			for (int o = 0 ; o < 10 ; o ++) {
				Plant mob;
				switch((int)random(4)) {
					case 0:
					mob = new Daisy(0,0,0, de*0.15, random(-PI,PI),random(-PI,PI),random(-PI,PI), 6, random(0.1,0.5));
					break;
					case 1:
					mob = new Fern(0,0,0, de*0.15, random(-PI,PI),random(-PI,PI),random(-PI,PI), 15, random(0.1,0.5));
					break;
					case 2:
					mob = new Tree(0,0,0, de*0.2, random(-PI,PI),random(-PI,PI),random(-PI,PI), 8, random(0.1,0.5),2);
					break;
					default:
					mob = new Curl(0,0,0, de*0.15, random(-PI,PI),random(-PI,PI),random(-PI,PI), 15, random(0.1,0.5));
				}
				mob.av.reset(0,-0.02,0);
				mobs.add(mob);
			}
			for (Plant plant : par) plant.grow(5);
		}
		segSetWPM(0.05,8);
		segSetAngPM(0.005,8);
		segSetFill(125,222,75, 75,-125,75);
		floatSetFill(125,175,255, 125,125,125);
	} // Yell cry sounds 5
	else if (beatInRange(299,333)) {
		if (currBeat == 299) {
			for (Plant plant : par) plant.die();
			for (int i = 0 ; i < far.arm ; i ++) far.ar.get(i).lifeSpan = 0;
		}
	}*/
	segSetIndex();
	plantSetIndex();
}

void addEvents() {

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
		setTime(73723,135);
		break;
		case '6':
		setTime(91184,167);
		break;
		case '7':
		setTime(100426,184);
		break;
		case '8':
		setTime(108622,199);
		break;
		case '9':
		setTime(125527,232);
		break;
		case '0':
		setTime(139691,258);
		break;
		case 'q':
		setTime(160473,296);
		break;
	}
}