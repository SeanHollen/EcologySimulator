// Moves and finds food of various kinds to eat 
class Animal extends Organism {
  
  public float bodySize; 
  public float grazing, jaws, legs, fins, climbing, burrowing, fur, longNeck; 
  private HashMap<Integer, Integer> otherOrganismsConsumedTimes;
  
  public Animal(ArrayList<Action> actions, Location location, float energy) {
    this(actions, location, energy, 2, 0, 0, 0, 0, 0, 0, 0, 0); 
  }
  
  public Animal(ArrayList<Action> actions, Location location, float energy, float bodySize) {
    this(actions, location, energy, bodySize, 0, 0, 0, 0, 0, 0, 0, 0); 
  }
  
  private Animal(ArrayList<Action> actions, Location location, float energy, float bodySize, float grazing, 
  float jaws, float legs, float fins, float climbing, float burrowing, float fur, float longNeck) {
    super(actions, location, energy);
    this.bodySize = bodySize; 
    this.grazing = grazing; 
    this.jaws = jaws; 
    this.legs = legs; 
    this.fins = fins; 
    this.climbing = climbing; 
    this.burrowing = burrowing; 
    this.fur = fur; 
    this.longNeck = longNeck; 
    otherOrganismsConsumedTimes = new HashMap<Integer, Integer>(); 
  }
  
  protected Organism child(ArrayList<Action> actions, Location loc, float startingEnergy) {
    return new Animal(actions, loc, startingEnergy);
  }
  
  public void move() {
    float step = getStep(); 
    super.location.moveBy(step, super.orientationInRadians); 
  }
  
  private float getStep() {
    return speedMultiplier; 
  }
  
  public void drawOrganism() {
    fill(219, 197, 156); 
    circle(super.location.getX(), super.location.getY(), this.width());
    drawHead(); 
  }
  
  private void drawHead() {
    Location headLoc = this.location.getLocOffBy(this.width() / 2, super.orientationInRadians);
    if (grazing > jaws) {
      // We have to draw the larger one first so the smaller one is not covered up
      drawCarnivoreHead(headLoc); 
      drawHerbavoreHead(headLoc);
    } else {
      drawHerbavoreHead(headLoc);
      drawCarnivoreHead(headLoc); 
    }
  }
  
  private void drawCarnivoreHead(Location headLoc) {
    fill(237, 40, 40); 
    circle(headLoc.getX(), headLoc.getY(), (this.jaws * jawsSizeMultiplier));
  }
  
  private void drawHerbavoreHead(Location headLoc) {
    fill(191, 134, 0); 
    circle(headLoc.getX(), headLoc.getY(), (this.grazing * headSizeMultiplier));
  }
  
  protected int width() {
    return (int) (this.bodySize * bodySizeMultiplier); 
  }
  
  public void modifyCollidedOrganisms(Organism other) {
    if (!inGracePeriod(other)) {
      int toGrowBy = 0;
      toGrowBy += other.removeFromCanopy(this.grazing); 
      if (other.canBeEatenWithJaws(this.jaws)) {
        toGrowBy += other.removeFromBody(this.jaws); 
      }
      if (toGrowBy > 0) {
        addEnergy(toGrowBy);
      }
      //reverseOrientation();
      setRandomOrientation(); 
    } 
    otherOrganismsConsumedTimes.put(other.ID, frameCount); 
  }
  
  public boolean inGracePeriod(Organism other) {
    return otherOrganismsConsumedTimes.containsKey(other.ID) 
      && frameCount - otherOrganismsConsumedTimes.get(other.ID) <= gracePeriod; 
  }
  
  protected void addEnergy(float energy) {
    super.energy += energy; 
  }
  
  protected float sizeCost() { return bodySize * bodySize * PI * costPerBodySize; }
  
  protected void reduceBaseBy(float amount) { removeFromBody(amount); }
  
  protected float base() { return this.bodySize; }
  
  protected void takeAction(Action action, float toGrowWith) { action.act(this, toGrowWith); }
  
  protected float removeFromBody(float toRemove) {
    toRemove = min(toRemove, bodySize); 
    bodySize -= toRemove; 
    float maxGrazing = min(grazing, bodySize * grazingMaxSizeMultiplier); 
    grazing = maxGrazing; 
    float maxJaws = min(jaws, bodySize * jawsMaxSizeMultiplier); 
    jaws = maxJaws; 
    return toRemove; 
  }
  
  public float removeFromCanopy(float toRemove) { return 0; }; 
  
  public boolean canBeEatenWithJaws(float otherJawsSize) {
    return this.jaws < otherJawsSize; 
  }
  
  public void obsorbSunlight(float sunlight) {} // does not
  public void obsorbSunlight() {} // does not
     
  public String getType() {
    return "ANIMAL"; 
  }
  
  public boolean isDead() {
    return super.age >= infancyLength && this.bodySize <= 0; 
  }
  
  public float getPlantHeight() {
    return 0;
  }
  
}
