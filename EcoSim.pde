boolean isPaused = false; 

void settings() {
  size(BOARD_X, BOARD_Y);
}

void setup() {
  organisms = new ArrayList<Organism>();
  addStartingPlants(); 
  addStartingHerbavores();
  addStartingCarnivores();
}

void draw() {
  background(217, 255, 224);
  noStroke(); 
  drawOrganisms(); 
  drawNumOrganisms(); 
  drawSelected(); 
  if (!isPaused) {
    incrementAges(); 
    moveAnimals();
    collisionOperations(); 
    feedPlants();
    homeostasis();
    removeDead(); 
  } 
  pausedText(); 
}

void mouseClicked() {
  if (mouseX < 100 && mouseY < 100) {
    isPaused = !isPaused; 
  } else {
    selectOrganism(); 
  }
}

void pausedText() {
  textSize(16);
  fill(0);
  String text; 
  if (isPaused) text = "paused"; else text = "pause"; 
  text(text, textXOffset, 60);
}

// === Board Diminsions === //
final int BOARD_X = 750;
final int BOARD_Y = 750; 

// === Visuals === ///
final float BODY_SIZE_VIEW = 1;
final float HEAD_SIZE_VIEW = 1;
final float JAWS_SIZE_VIEW = 1;
final float TRUNK_SIZE_VIEW = 1;
final float CANOPY_SIZE_VIEW = 1;
final float LEGS_WIDTH_VIEW = 0.5; 
final float LEGS_LENGTH_VIEW_X = 0.5;
final float SHELL_STROKE = 0.2; 
final boolean SHOW_LIGHT_RAYS = false; 

// === Info Display === // 
final float textXOffset = 13; 
final float panelTop =  BOARD_Y - 210;
float panelLoc;
float panelFont = 15;
float INDICATOR_TRIANGLE_SIZE = 16;

// === Starting Situation === //
final int START_PLANTS = 100; 
final float PLANT_START_ENERGY = 20;
final int START_HERBAVORES = 5; 
final int START_CARNIVORES = 20; 
final float START_ANIMAL_ENERGY = 40; 
final float START_GRAZE = 1.5; 
final float START_JAWS = 5; 

// === Movement === //
final float NOLEG_SPEED = 0; 
final float LEGS_SPEED = 12; 
final int GRACE_PERIOD = 10; 

// === Energy and Costs === //
final float COST_PER_BODY_SIZE = 0.00003; 
final float COST_PER_TRUNK = 0.00003; 
final float AGE_COST_PER1K_ONGOING = 0.0006; 
final float GROWTH_SPEED = 0.5;
final float ENERGY_PER_RAY = 20; 
final float RAYS_PER_10K_PIXELS = 1; 
final float INFANCY_LENGTH = 20; 
final float SEED_DISPERSAL_COST = 0; 
final float SHELL_PROTECTION = 1; 

// === Restrictions === //
final float CANOPY_MAX_SIZE_X = 2;
final float GRAZING_MAX_SIZE_X = 0.5;
final float JAWS_MAX_SIZE_X = 0.75;
final float LEGS_MAX_SIZE_X = 0.3;
final float SHELL_MAX_SIZE_X = 0.2; 

// === Genetics === // 
final int START_GENETIC_AFFINITY = 10; // set 0-20s
final float MUTATION_RANGE_PORTION = 0.25; 
final int COLOR_MUTATION_RANGE = 20;
