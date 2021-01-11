// Does not move. Has canopy that obsorbs sunlight 
class Plant extends Organism {
  
  public float trunk; 
  public float canopy; 
  
  public Plant(ArrayList<Action> actions, Location location, float energy) {
    this(actions, location, energy, 2, 0); 
  }
  
  public Plant(ArrayList<Action> actions, Location location, float energy, float trunk, float canopy) {
    super(actions, location, energy);
    this.trunk = trunk;
    this.canopy = canopy; 
  }
  
  protected Organism child(ArrayList<Action> actions, Location newLoc, float startingEnergy) {
     return new Plant(actions, newLoc, startingEnergy);
  }
  
  public void obsorbSunlight() {
    obsorbSunlight(1.0);
  }
  
  public void obsorbSunlight(float energy) {
    addEnergy(energy); 
  }
  
  protected void addEnergy(float energy) {
    super.energy += energy; 
  }
  
  protected float sizeCost() { return trunk * trunk * trunk * PI * costPerTrunkSize; }
  
  protected void reduceBaseBy(float amount) { reduceTrunkBy(amount); }
  
  protected float base() { return this.trunk; }
  
  protected void takeAction(Action action, float toGrowWith) { action.act(this, toGrowWith); }
  
  private void reduceTrunkBy(float amount) {
    trunk -= amount; 
    float maxCanopy = min(canopy, trunk * canopyMaxSizeMultiplier); 
    canopy = maxCanopy; 
  }
  
  public void drawOrganism() {
    fill(128,0,0); 
    circle(super.location.getX(), super.location.getY(), (this.trunk * trunkSizeMultiplier));
    fill(66, 245, 114); 
    circle(super.location.getX(), super.location.getY(), (this.canopy * canopySizeMultiplier));
  }
  
  protected int width() {
    return (int) (canopy * bodySizeMultiplier);
  }
  
  public void modifyCollidedOrganisms(Organism other) {}
  
  public float removeFromCanopy(float toRemove) { 
    toRemove = min(toRemove, canopy); 
    canopy -= toRemove; 
    return toRemove; 
  }
  
  public boolean canBeEatenWithJaws(float otherJawsSize) {
    return false; 
  }
  
  protected float removeFromBody(float toRemove) { return 0; }; 
  
  public void move() {}; 
  public String getType() {
    return "PLANT"; 
  }
  
  public boolean isDead() {
    return super.age >= infancyLength && this.trunk <= 0; 
  }
  
  public float getPlantHeight() {
    return this.trunk;
  }
}
