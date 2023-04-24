class Evolve{

  Evolve(){
  
  }
  
  void elite(){
    
  }
  
  void insertsort(ArrayList<Cell> olist){
    for(int i = 1; i<olist.size(); i++){
      // We need to fix cell where fitness is incremented by 1 for every food it eats
      int key = olist.get(i).fitness;
      int j= i - 1;
      
      while(j>=0 && olist.get(i).fitness > key){
        olist.get(i+1).fitness = olist.get(i).fitness;
        j = j - 1;
      }
      olist.get(i+1).fitness = key;
    }
  }
}
