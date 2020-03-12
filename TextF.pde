static String fontName = "../Fonts/FreeSans.ttf";
int fontW = 600;
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
		this(str,fontW,30);
	}

	void draw(float x, float y, float z, int minLifeSpan, int maxLifeSpan) {
		for (int i = 0 ; i < ar.length ; i ++) {
			Float mob = far.add(ar[i].x + x,ar[i].y + y,z);
			mob.lifeSpan = (int)random(minLifeSpan, maxLifeSpan);
		}
	}
	
	void draw(float x, float y, float z) {
		draw(x,y,z, 20,40);
	}
}