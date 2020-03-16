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
	float amp = 0.5;
	for (int i = 0 ; i < segs.arm ; i ++) {
		PSeg mob = segs.ar.get(i);
		temp = (float)frameCount/30;
		t = (float)i/segs.arm;
		mob.fillStyle.set(rc+rcr*t,gc+gcr*t,bc+bcr*t,255, rm+rmr*t,gm+gmr*t,bm+bmr*t,0);
		mob.strokeStyle.set((rc+rcr*t)*amp,(gc+gcr*t)*amp,(bc+bcr*t)*amp,125, rm+rmr*t,gm+gmr*t,bm+bmr*t,2);
	}
}

void floatSetFill(float rc, float gc, float bc, float rcr, float gcr, float bcr, 
	float rm, float gm, float bm, float rmr, float gmr, float bmr) {
	float amp = 0.5;
	for (int i = 0 ; i < far.arm ; i ++) {
		Float mob = far.ar.get(i);
		temp = (float)frameCount/30;
		t = (float)i/far.arm;
		mob.fillStyle.set(rc+rcr*t,gc+gcr*t,bc+bcr*t,255, rm+rmr*t,gm+gmr*t,bm+bmr*t,0);
		mob.strokeStyle.set((rc+rcr*t)*amp,(gc+gcr*t)*amp,(bc+bcr*t)*amp,125, rm+rmr*t,gm+gmr*t,bm+bmr*t,2);
	}
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