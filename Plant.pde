class Daisy extends Plant {
	float angR = 0.1; // Angle range
	float angT = random(-0.1,0.1);
	float nofPetals = (int)random(8,10);

	float tempY = random(1000);
	float tempX = random(-400,400);

	Daisy(float x, float y, float z, float w, float ax, float ay, float az, float maxLevel, float angR) {
		super(x,y,z, w, ax,ay,az);
		this.maxLevel = (int)maxLevel;
		this.angR = angR;
	}

	Daisy(float x, float y, float z, float w, float ax, float ay, float az) {
		super(x,y,z, w, ax,ay,az);
		maxLevel = (int)random(8,16);
	}

	Daisy(float x, float y, float z, float w) {
		this(x,y,z,w, 0,0,-PI/2);
	}

	void grow() {
		if (alive && tips.get(0).level < maxLevel) {
			tips.add(segs.add(tips.remove(0), 0, w.p.x,0,0, random(-angR,angR),random(-angR,angR),angT+random(-angR,angR)));
		} else if (alive && tips.get(0).children.size() < nofPetals) {
			float a = randomR(0.6,1.5);
			for (float i = 0 ; i < nofPetals ; i ++) {
				segs.add(tips.get(0), 2, w.p.x/3,w.p.x,0, 0,a,i/nofPetals*2*PI);
			}
		}
	}
}

class Tree extends Plant {
	float bf = 2; // Branching factor
	float angR = 0.6; // Angle range

	Tree(float x, float y, float z, float w, float ax, float ay, float az, float maxLevel, float angR, float bf) {
		super(x,y,z, w, ax,ay,az);
		this.maxLevel = (int)maxLevel; this.bf = bf; this.angR = angR;
	}

	Tree(float x, float y, float z, float w, float ax, float ay, float az, float maxLevel, float angR) {
		super(x,y,z, w, ax,ay,az);
		this.maxLevel = (int)maxLevel; this.angR = angR;
	}

	Tree(float x, float y, float z, float w, float ax, float ay, float az) {
		this(x,y,z, w, ax,ay,az, 5, 0.6, 2);
	}

	Tree(float x, float y, float z, float w) {
		this(x,y,z,w, 0,0,-PI/2);
	}

	void grow() {
		if (alive && tips.get(0).level < maxLevel) {
			int prevTips = tips.size();
			for (int i = 0 ; i < prevTips ; i ++) {
				for (int o = 0 ; o < bf ; o ++) {
					if (tips.get(i).level > 1) {
						tips.add(segs.add(tips.get(i), 0, w.p.x,w.p.x/6,0, random(-angR,angR),random(-angR,angR),random(-angR,angR)));
					} else {
						tips.add(segs.add(tips.get(i), 0, w.p.x,w.p.x/6,0, random(-angR,angR)*0.6,random(-angR,angR)*0.6,random(-angR,angR)*0.6));
					}
				}
			}
			for (int i = 0 ; i < prevTips ; i ++) {
				tips.remove(0);
			}
		}
	}
}

class Fern extends Plant {
	float angR = 0.4; // Angle range
	float angT = random(0.1,0.3);

	Fern(float x, float y, float z, float w, float ax, float ay, float az, float maxLevel, float angR) {
		super(x,y,z, w, ax,ay,az);
		this.maxLevel = (int)maxLevel;
		this.angR = angR;
	}

	Fern(float x, float y, float z, float w, float ax, float ay, float az) {
		super(x,y,z, w, ax,ay,az);
		maxLevel = (int)random(8,16);
	}

	Fern(float x, float y, float z, float w) {
		this(x,y,z,w, 0,0,-PI/2);
	}

	void grow() {
		if (alive && tips.get(0).level < maxLevel) {
			if (tips.get(0).level < maxLevel-1) tips.add(segs.add(tips.get(0), 0, w.p.x,0,0, random(angR),random(angR),angT-random(angR)));
			segs.add(tips.get(0), 1, w.p.x,w.p.x/2,0, random(-angR,angR),random(-angR,angR),angT-random(-angR,angR)+PI/2);
			if (tips.get(0).level == maxLevel-1) tips.add(segs.get());
			tips.remove(0);
		}
	}
}

class Curl extends Plant {
	float angR = 0.3; // Angle range
	float angT = random(0.5,0.8);

	Curl(float x, float y, float z, float w, float ax, float ay, float az, float maxLevel, float angR) {
		super(x,y,z, w, ax,ay,az);
		this.maxLevel = (int)maxLevel; this.angR = angR;
	}

	Curl(float x, float y, float z, float w, float ax, float ay, float az) {
		super(x,y,z, w, ax,ay,az);
		maxLevel = (int)random(8,12);
	}

	Curl(float x, float y, float z, float w) {
		this(x,y,z,w, 0,0,-PI/2);
	}

	void grow() {
		if (alive && tips.get(0).level < maxLevel) {
			tips.add(segs.add(tips.get(0), 0, w.p.x,0,0, random(angR),random(angR),angT-random(angR)));
			tips.remove(0);
		}
	}
}

abstract class Plant extends Mob {
	ArrayList<PSeg> tips = new ArrayList<PSeg>();
	ArrayList<PSeg> rips = new ArrayList<PSeg>();
	int maxLevel;
	PSeg root;

	boolean alive = true;

	Ring ring = new Ring();

	Plant(float x, float y, float z, float w, float ax, float ay, float az) {
		p = new Point(x,y,z);
		ang = new Point(ax,ay,az);
		root = segs.add(null, 0, 0,0,0, 0,0,0);
		tips.add(root);
		this.w = new Point(w,0,0);
		par.add(this);
	}

	Plant(float x, float y, float z) {
		this(x,y,z, de*0.01, 0,0,-PI/2);
	}

	void effect(int type, float w, float wMax, float amp) {
		for (PSeg tip : tips) tip.ring.reset(type, this.w.p.x*w, this.w.p.x*wMax, amp);
	}

	abstract void grow();

	void growAll() {
		if (alive) for (int i = 0 ; i < maxLevel ; i ++) grow();
	}

	void grow(int num) {
		if (alive) for (int i = 0 ; i < num ; i ++) grow();
	}

	void kill() {
		for (int i = 0 ; i < tips.size() ; i ++) {
			rips.add(tips.get(i));
		}
		for (int i = 0 ; i < rips.size() ; i ++) {
			PSeg tip = rips.get(i);
			if (tip != root) {
				tip.die();
				if (!tips.contains(tip.parent)) tips.add(tip.parent);
				tips.remove(tip);
			} else {
				for (PSeg child : root.children) child.die();
			}
		}
		rips.clear();
	}

	void kill(int num) {
		for (int i = 0 ; i < num ; i ++) {
			kill();
		}
	}

	void killAll() {
		for (PSeg child : root.children) child.die();
		tips.clear();
		tips.add(root);
	}

	void update() {
		super.update();
		if (root != null) root.update();
		if (!ring.finished) ring.update();
		if (!alive && root.children.size() == 0) {
			finished = true;
			par.remove(this);
		}
	}

	void die() {
		alive = false;
		killAll();
	}

	void render() {
		setDraw();
		//rect(0,0,25,25);
		root.render();
		if (!ring.finished) ring.render();
		pop();
	}
}