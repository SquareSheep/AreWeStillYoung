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
		y = (y-1.4)*fontW;
		z *= fontW;
		for (int i = 0 ; i < ar.length ; i ++) {
			Float mob = far.add(ar[i].x + x,ar[i].y + y,z);
			mob.lifeSpan = (int)random(minLifeSpan, maxLifeSpan);
		}
	}
	
	void draw(float x, float y, float z) {
		draw(x,y,z, 60,90);
	}
}