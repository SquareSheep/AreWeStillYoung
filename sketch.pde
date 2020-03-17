import geomerative.*;
static float bpm = 110;
static float beatInc = 0.5;
static int threshold = 100;
static int offset = -50;
static int binCount = 144;
static float defaultMass = 17;
static float defaultVMult = 0.6;
static float fillMass = 3;
static float fillVMult = 0.1;
static float fftThreshold = 1;
static float fftPow = 1.7;
static float fftAmp = 2;
static float volumeGain = -11;
static String songName = "../Music/arewestillyoung.mp3";

IColor defaultFill = new IColor(125,125,125,255);
IColor defaultStroke = new IColor(125,125,125,255);

PSegPool segs = new PSegPool();
FloatPool far = new FloatPool();
ArrayList<Plant> par = new ArrayList<Plant>();
HashMap<String, TextHolder> textMap = new HashMap<String, TextHolder>();
SpringValue strokeW = new SpringValue(3);

void render() {
	strokeCap(ROUND);
	strokeJoin(ROUND);
	segs.update();
	if (beatQ) instantEvents();
	strokeW.v += avg*0.001;
	strokeW.update();
	strokeWeight(strokeW.x);
	text(mobs.size() +  " " + par.size() + " " + far.ar.size() + " " + segs.ar.size() + " ", 0,0);
	text(far.arm + " " + segs.arm, 0,de*0.15);
	text((int)frameRate, 0,de*0.3);
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);
	mobs.add(far);
}