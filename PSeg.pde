class PSeg extends Entity {
	Point w = new Point();
	Point ang = new Point();
	PSeg parent;
	ArrayList<PSeg> children = new ArrayList<PSeg>();

	IColor fillStyle = new IColor();
	IColor strokeStyle = new IColor();
	int type = 0;
	int level;
	boolean alive = true;

	Ring ring = new Ring();

	PSeg() {}

	void reset(PSeg parent, int type, float wx, float wy, float wz, float ax, float ay, float az) {
		this.finished = false;
		this.alive = true;
		this.w.reset(0,0,0,wx,wy,wz);
		this.ang.reset(ax,ay,az);
		this.type = type;
		this.parent = parent;
		if (parent != null) {
			parent.children.add(this);
			this.level = parent.level + 1;
		} else {
			this.level = 0;
		}
		this.children.clear();
	}

	void effect(int type, float w, float wMax, float amp) {
		ring.reset(type,w*this.w.p.x,wMax*this.w.p.x,amp);
	}

	void update() {
		for (int i = 0 ; i < children.size() ; i ++) {
			children.get(i).update();
		}
		w.update();
		ang.update();
		fillStyle.update();
		strokeStyle.update();
		if (!ring.finished) ring.update();
		if (!alive && w.p.x <= 0) finished = true;
	}

	void render() {
		push();
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		ring.w.X ++;
		strokeStyle.strokeStyle();
		fillStyle.fillStyle();
		translate(w.p.x/2,0,0);
		switch(type) {
			case 0: // Stem
			box(w.p.x,w.p.x*0.1,w.p.x*0.1);
			break;
			case 1: // Leaf
			box(w.p.x,w.p.x*0.5,w.p.x*0.2);
			break;
			case 2: // Petal
			beginShape();
			vertex(w.p.x/2,-w.p.x/4,-w.p.x*0.1);
			vertex(-w.p.x/2,0,0);
			vertex(w.p.x/2,w.p.x/4,-w.p.x*0.1);
			endShape(CLOSE);
			beginShape();
			vertex(w.p.x/2,-w.p.x/4,w.p.x*0.1);
			vertex(-w.p.x/2,0,0);
			vertex(w.p.x/2,w.p.x/4,w.p.x*0.1);
			endShape(CLOSE);
			break;
		}
		translate(w.p.x/2,0,0);
		for (PSeg child : children) {
			child.render();
		}
		if (!ring.finished) ring.render();	
		pop();
	}

	void die() {
		alive = false;
		w.P.set(-w.p.x,-w.p.y,-w.p.z);
		for (PSeg child : children) child.die();
	}

	void setIndex(float k) {
		int i = (int)k%binCount;
		w.index = i;
		ang.index = i;
		fillStyle.index = i;
		strokeStyle.index = i;
	}
}

class PSegPool {
	int arm = 0;
	ArrayList<PSeg> ar = new ArrayList<PSeg>();

	PSeg add(PSeg parent, int type, float wx, float wy, float wz, float ax, float ay, float az) {
		PSeg mob;
		if (arm == ar.size()) {
			mob = new PSeg();
			ar.add(mob);
		} else {
			mob = ar.get(arm);
		}
		mob.reset(parent, type, wx, wy, wz, ax, ay, az);
		arm ++;
		return mob;
	}

	PSeg add(PSeg parent, int type, float wx, float wy, float wz) {
		return add(parent, type, wx,wy,wz, 0,0,0);
	}

	PSeg add(PSeg parent, int type, float w, float ax, float ay, float az) {
		return add(parent, type, w,w,w, ax,ay,az);
	}

	PSeg add(PSeg parent, int type, float w) {
		return add(parent, type, w,w,w, 0,0,0);
	}

	void remove(int i) {
		remove(ar.get(i));		
	}

	void remove(PSeg seg) {
		if (seg.parent != null) seg.parent.children.remove(seg);
		for (int i = 0 ; i < seg.children.size() ; i ++) remove(seg.children.get(i));
		ar.remove(seg);
		ar.add(seg);
		arm --;
	}

	void update() {
		for (int i = 0 ; i < arm ; i ++) {
			if (ar.get(i).finished) remove(ar.get(i));
		}
	}

	PSeg get() {
		return ar.get(arm-1);
	}
}

/*
Plant segments have no awareness of the whole plant
Seeds do
Every plant is a chain of plant segments rooted by a seed
Seeds have the ability to grow, shrink(), spawn(), die(), etc
They keep track of the current leaf segments (segments with null children)
from which the plant can currently grow new segments
*/
