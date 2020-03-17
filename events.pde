void screamTrees() {
	t = (float)frameCount/30;
	for (int o = 0 ; o < 10 ; o ++) far.add(random(-de,de),random(-de,de*0.25),random(-de,0), random(de*0.02,de*0.06)).pv.reset(15*noise(t+10),5*noise(t),25);
	Plant mob = new Tree(random(-de,de),de*0.25,-de, de*0.15, 0,0,-PI/2, random(4,8), random(0.4,0.8), 2);
	mob.pv.reset(0,0,25);
	mob.av.reset(randomR(0.001,0.002),0,0);
	mobs.add(mob);
	for (Plant plant : par) plant.grow(2);
	for (int i = 0 ; i < par.size() ; i ++) if (par.get(i).p.p.z > de*1.1) par.get(i).die();
}

void yellCryMain() {
	for (float i = 0 ; i < 10 ; i ++) {
		float ang = random(-PI,PI);
		float dist = random(de*0.7,de*1.2);
		far.add(cos(ang)*dist,sin(ang)*dist,random(-de,de), random(de*0.05,de*0.1)).pv.reset(0,0,25);
	}

	int num = (int)random(4,6);
	float length = random(4,6);
	float angOffset = random(PI);
	float dist = random(0.7,0.9)*de;
	float ravAmp = random(-0.0001,0.0001);
	int rangIndex = (int)random(binCount);
	for (float i = 0 ; i < num ; i ++) {
		t = i/num + angOffset;
		Plant mob;
		switch((int)random(2)) {
			case 0:
			mob = new Daisy(0,0,-de*0.75, de*0.13, 0,0,PI, length, random(0.1,0.5));
			break;
			default:
			mob = new Fern(0,0,-de*0.75, de*0.13, 0,0,PI, length*2, random(0.5,0.9));
		}
		mob.p.mass = 3;
		mob.p.vMult = 0;
		mob.pv.mass = 3;
		mob.pv.vMult = 0;
		mob.r.reset(dist,0,0);
		mob.rang.reset(0,0,t*2*PI);
		mob.pv.reset(0,0,10);
		mob.pv.pm.set(0,0,0.5);
		mob.rav.pm.set(0,0,ravAmp);
		mob.rav.index = rangIndex;
		mobs.add(mob);
	}
	for (Plant plant : par) plant.grow(3);
}

void yellCryRing(float length, float rav, float num) {
	float angOffset = random(PI);
	for (float o = 0 ; o < num ; o ++) {
		t = o/num+angOffset;
		Fern mob = new Fern(0,0,0, de*0.15, PI/2+random(-PI/4,PI/4),0,0, length, random(0.1,0.6));
		mob.r.reset(random(de*0.5),0,0);
		mob.rang.reset(0,0,t*2*PI);
		mob.rav.reset(0,0,rav);
		mobs.add(mob);
	}
	for (int i = 0 ; i < num/2 ; i ++) par.get(i).die();
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

void plantSetIndex() {
	for (int i = 0 ; i < par.size() ; i ++) par.get(i).setIndex((float)i/par.size()*binCount);
}

void segSetFill(float rc, float gc, float bc, float rcr, float gcr, float bcr, 
	float rm, float gm, float bm, float rmr, float gmr, float bmr) {
	rc *= noise(frameCount*0.07)*0.5+0.5;
	gc *= noise(frameCount*0.1)*0.5+0.5;
	bc *= noise(frameCount*0.13)*0.5+0.5;
	float amp = 0.5;
	for (int i = 0 ; i < segs.arm ; i ++) {
		PSeg mob = segs.ar.get(i);
		temp = (float)frameCount/30;
		t = (float)i/segs.arm-0.5;
		mob.fillStyle.set(rc+rcr*t,gc+gcr*t,bc+bcr*t,55, rm+rmr*t,gm+gmr*t,bm+bmr*t,1);
		mob.strokeStyle.set((rc+rcr*t)*amp,(gc+gcr*t)*amp,(bc+bcr*t)*amp,255, rm+rmr*t,gm+gmr*t,bm+bmr*t,0);
	}
}

void segSetFill(float rc, float gc, float bc, float rcr, float gcr, float bcr) {
	float amp = 0.01;
	segSetFill(rc,gc,bc,rcr,gcr,bcr, rc*amp,bc*amp,gc*amp, rcr*amp,gcr*amp,bcr*amp);
}

void floatSetFill(float rc, float gc, float bc, float rcr, float gcr, float bcr, 
	float rm, float gm, float bm, float rmr, float gmr, float bmr) {
	rc *= noise(frameCount*0.07)*0.5+0.5;
	gc *= noise(frameCount*0.1)*0.5+0.5;
	bc *= noise(frameCount*0.13)*0.5+0.5;
	float amp = 0.5;
	for (int i = 0 ; i < far.arm ; i ++) {
		Float mob = far.ar.get(i);
		temp = (float)frameCount/30;
		t = (float)i/far.arm;
		mob.fillStyle.set(rc+rcr*t,gc+gcr*t,bc+bcr*t,55, rm+rmr*t,gm+gmr*t,bm+bmr*t,1);
		mob.strokeStyle.set((rc+rcr*t)*amp,(gc+gcr*t)*amp,(bc+bcr*t)*amp,255, rm+rmr*t,gm+gmr*t,bm+bmr*t,0);
	}
}

void floatSetFill(float rc, float gc, float bc, float rcr, float gcr, float bcr) {
	float amp = 0.01;
	floatSetFill(rc,gc,bc,rcr,gcr,bcr, rc*amp,bc*amp,gc*amp, rcr*amp,gcr*amp,bcr*amp);
}


class PointReset extends Event {
	Point p;
	float x,y,z,X,Y,Z;

	PointReset(float time, Point p, float x, float y, float z, float X, float Y, float Z) {
		super(time,time+1);
		this.p = p;
		this.x = x; this.y = y; this.z = z;
		this.X = X; this.Y = Y; this.Z = Z;
	}

	PointReset(float time, Point p, float x, float y, float z) {
		this(time,p,x,y,z,x,y,z);
	}
}

class PointSetMass extends Event {
	Point p;
	float mass;

	PointSetMass(float time, Point p, float mass) {
		super(time,time+1);
		this.p = p;
		this.mass = mass;
	}

	void spawn() {
		p.mass = mass;
	}
}

class PointSetVMult extends Event {
	Point p;
	float vMult;

	PointSetVMult(float time, Point p, float vMult) {
		super(time,time+1);
		this.p = p;
		this.vMult = vMult;
	}

	void spawn() {
		p.vMult = vMult;
	}
}

class SpringValueSetX extends Event {
	SpringValue spr;
	float x;

	SpringValueSetX(float time, SpringValue spr, float x) {
		super(time,time+1);
		this.spr = spr;
		this.x = x;
	}

	void spawn() {
		spr.X = x;
	}
}

class SpringValueSetx extends Event {
	SpringValue spr;
	float x;

	SpringValueSetx(float time, SpringValue spr, float x) {
		super(time,time+1);
		this.spr = spr;
		this.x = x;
	}

	void spawn() {
		spr.x = x;
	}
}

class PVectorSet extends Event {
	PVector p;
	float x,y,z;

	PVectorSet(float time, PVector p, float x, float y, float z) {
		super(time,time+1);
		this.p = p;
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		p.set(x,y,z);
	}
}

class PVectorAdd extends Event {
	PVector p;
	float x,y,z;

	PVectorAdd(float time, PVector p, float x, float y, float z) {
		super(time,time+1);
		this.p = p;
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		p.add(x,y,z);
	}
}

class FillStyleSetC extends Event {
	IColor fillStyle;
	float r,g,b,a;

	FillStyleSetC(float time, IColor fillStyle, float r, float g, float b, float a) {
		super(time, time+1);
		this.fillStyle = fillStyle;
		this.r = r; this.g = g; this.b = b; this.a = a;
	}

	void spawn() {
		fillStyle.setC(r,g,b,a);
	}
}

class FillStyleSetM extends Event {
	IColor fillStyle;
	float r,g,b,a;

	FillStyleSetM(float time, IColor fillStyle, float r, float g, float b, float a) {
		super(time, time+1);
		this.fillStyle = fillStyle;
		this.r = r; this.g = g; this.b = b; this.a = a;
	}

	void spawn() {
		fillStyle.setM(r,g,b,a);
	}
}

class FillStyleSetMass extends Event {
	IColor fillStyle;
	float mass;

	FillStyleSetMass(float time, IColor fillStyle, float mass) {
		super(time, time+1);
		this.fillStyle = fillStyle;
		this.mass = mass;
	}

	void spawn() {
		fillStyle.setMass(mass);
	}
}

class FillStyleSetVMult extends Event {
	IColor fillStyle;
	float vMult;

	FillStyleSetVMult(float time, IColor fillStyle, float vMult) {
		super(time, time+1);
		this.fillStyle = fillStyle;
		this.vMult = vMult;
	}

	void spawn() {
		fillStyle.setMass(vMult);
	}
}