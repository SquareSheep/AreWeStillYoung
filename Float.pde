class Float extends MobF {
	boolean alive = true;
	int lifeSpan;

	Float() {
		p = new Point();
		ang = new Point();
		w = new Point();
		w.mass = 30;
	}

	void reset(float x, float y, float z, float w, float ax, float ay, float az) {
		this.p.reset(x,y,z);
		this.w.reset(0,0,0,w,w,w);
		this.ang.reset(ax,ay,az);
		this.pv.reset(0,0,0);
		this.av.reset(0,0,0);
		this.r.reset(0,0,0);
		this.rv.reset(0,0,0);
		this.rang.reset(0,0,0);
		this.rav.reset(0,0,0);
		this.finished = false;
		this.alive = true;
		this.lifeSpan = (int)random(20,40);
		this.strokeStyle.reset(125,125,125,0);
		this.fillStyle.reset(0,0,0,0);
	}

	void update() {
		super.update();
		if (lifeSpan > 0) {
			lifeSpan --;
		} else if (alive) {
			alive = false;
			w.P.set(-5,-5,-5);
			pv.reset(random(-w.p.x,w.p.x),random(-w.p.x,w.p.x),random(-w.p.x,w.p.x));
		} else if (w.p.x <= 0) {
			finished = true;
		}
	}

	void render() {
		setDraw();
		box(w.p.x);
		pop();
	}
}

class FloatPool extends ObjectPool<Float> {

	Float add(float x, float y, float z, float w, float ax, float ay, float az) {
		Float mob;
		if (arm == ar.size()) {
			mob = new Float();
			ar.add(mob);
		} else {
			mob = ar.get(arm);
		}
		mob.reset(x,y,z,w,ax,ay,az);
		arm ++;
		return mob;
	}

	Float add(float x, float y, float z, float w) {
		return add(x,y,z, w, 0,0,0);
	}

	Float add(float x, float y, float z) {
		return add(x,y,z, 16, 0,0,0);
	}
}