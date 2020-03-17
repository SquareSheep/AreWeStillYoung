static String fontName = "../Fonts/FreeSans.ttf";
int fontW = 500;
class TextHolder {
	RShape grp;
	RPoint[] ar;
	int w;

	TextHolder(String str, int w, int pDist) {
		this.w = w;
		grp = RG.getText(str, fontName, w, CENTER);
		RG.setPolygonizerLength(pDist);
		ar = grp.getPoints();
	}

	TextHolder(String str) {
		this(str,fontW,20);
	}

	void draw(float x, float y, float z, int minLifeSpan, int maxLifeSpan) {
		x *= fontW;
		y = (y-1)*fontW*1.3;
		z *= fontW;
		for (int i = 0 ; i < ar.length ; i ++) {
			far.add(ar[i].x + x,ar[i].y + y,z).lifeSpan = (int)random(minLifeSpan, maxLifeSpan);
		}
	}

	void draw(float x, float y, float z, float lastBeat) {
		float beatSpan = (lastBeat-currBeat)*fpb;
		draw(x,y,z,(int)(beatSpan*0.9),(int)beatSpan);
	}
	
	void draw(float x, float y, float z) {
		draw(x,y,z, 60,90);
	}
}