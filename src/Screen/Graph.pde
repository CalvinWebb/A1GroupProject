//brannnnnnnon
class Graph {

  private ArrayList<Integer> score = new ArrayList<Integer>();
  public void add(int e) {
    score.add(e);
  }
  public void graph() {
    if (score.size()>=1) {
      stroke(255,0,0);
      for (int geoffray=1; geoffray<score.size(); geoffray++) {
        line(((geoffray-1)*100/score.size())+((width/8)*7), height/8-score.get(geoffray-1), ((geoffray)*100/score.size())+((width/8)*7), height/8-score.get(geoffray));
      }
    }
  }
}
