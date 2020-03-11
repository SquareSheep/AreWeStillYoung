float ringWMass = 30;
float ringWVMult = 0.5;
float ringWThreshold = 0.9;
class Ring extends Entity {
	SpringValue w = new SpringValue(0, ringWVMult, ringWMass);
	float wMax = 1000;
	float amp = 0;
	IColor fillStyle = new IColor(255,255,255,255);
	int type = 0;

	Ring(int type, float w, float wMax, float amp) {
		reset(type, w, wMax, amp);
	}

	Ring() {
		finished = true;
	}

	void reset(int type, float w, float wMax, float amp) {
		this.w.x = w;
		this.w.X = wMax;
		this.wMax = wMax;
		this.amp = amp;
		this.type = type;
		this.finished = false;
	}

	void update() {
		w.update();
		fillStyle.update();
		if (w.x >= wMax*ringWThreshold) {
			finished = true;
			println(this + " " + w.x);
		}
	}

	void render() {
		switch(type) {
			case 0:
			fillStyle.strokeStyle();
			noFill();
			strokeWeight((wMax*ringWThreshold-w.x)*amp);
			rect(0,0,w.x,w.x);
			break;
			case 1:
			fillStyle.fillStyle();
			noStroke();
			rect(0,0,wMax-w.x,wMax-w.x);
			break;
			case 2:
			fillStyle.fillStyle();
			noStroke();
			rect(0,-w.x,wMax,wMax-w.x);
			rect(0,w.x,wMax,wMax-w.x);
			break;
		}
	}
}