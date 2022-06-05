import java.util.Queue;
import java.util.ArrayDeque;
import java.util.Arrays; 
import java.util.Stack; 
boolean flag =true;
int tour;
int i,j, w, h;
float r,g,b;
int x_int = 6;int y_int = 1;//to be used after applying the algho 'memorized'
int x_obj = 6;
int y_obj = 1;//current
int [] s ={ y_obj,x_obj};
int x_fin = 5;// finales
int y_fin = 7;
int [] fin ={ y_fin,x_fin};
int pathLength=0; int path_index = 0;
int stepx,stepy;
int c = 0;
int [][]obst={{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,2,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1},
        {1,1,0,0,1,0,0,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,1,0,0,1,1,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,3,0,0,0,0,0,0,0,0,0,1,0,0,1},
        {1,0,0,0,1,0,0,0,0,0,0,0,1,0,0,1},
        {1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}}; 

boolean finished = true;
static final int DIM = 100, MAX = 03000, DETAIL = 1000, DEPTH = 2000;

 
static final boolean HAS_MAX_LIMIT = true;
 
 Queue<int[]> Open = new ArrayDeque(MAX);
 Queue<Node> Open1 = new ArrayDeque(MAX);
  Queue<int[]> Closed = new ArrayDeque(MAX);
  Queue<Node> Closed1 = new ArrayDeque(MAX);
   Queue<int[]> path = new ArrayDeque(MAX);
   Queue<Node> parent = new ArrayDeque(MAX);

 boolean  found =false;
 boolean draw_finished = false;

void setup() {
  size(512, 512);
  Node node = null; // node S
 w=512;
 h=512;
 tour=0;
 frameRate(30);
 stepx = w/16;stepy=h/16;
  //display();
  
  // first part of the alghorithm 
  if (obst[y_obj][x_obj] == obst[y_fin][x_fin]){
    found =true;
  }
  else{
    if ( check_succ() == false ){found =false;}
    else{
      int a[] = {y_obj,x_obj};
      //Open.add(a);
      
      node = new Node(a);
      Open1.add(node);
    }
  }
}

void draw() {
  display();
  // the rest of the alghorithm:
  if((found) | (Open1.size()==0)){ flag = false;}
  if(flag){
     println("size=",Open.size());

    Node n = Open1.poll();
    

    x_obj = n.value[1];//x_obj = n[1];
    y_obj = n.value[0];//y_obj = n[0];
obst[y_obj][x_obj]=6;
   display();
    delay(1);
    println("x=",x_obj);
    println("y=",y_obj);
    println("################");
    Closed1.add(n);
    
    
    // lets check if the current node has successors
    if ( check_succ() ){
    
     int [] adj = getSucc();
     //for(int i = 0; i<4 ; i++){
       if(adj[0] == 1){
         int []droite = {y_obj , x_obj+1};
         if( !contained_node_version(droite)& !found){
            //Open.add(droite);
            Node node = new Node(droite);
            node.parent = n;
            Open1.add(node);
         
           if(obst[y_obj][x_obj+1]==3){found =true; }
         }
         else{print("contrained");}
       }
       if(adj[1] == 1){
         int []bas = {y_obj+1 , x_obj};
         if( !contained_node_version(bas)& !found){
           
           //Open.add(bas);
           Node node = new Node(bas);
            node.parent = n;
            Open1.add(node);
        
           if(obst[y_obj+1][x_obj]==3){found =true;}
         }
       }
       if(adj[2] == 1){
         int []gauche = {y_obj , x_obj-1};
         if( !contained_node_version(gauche)& !found){
           //Open.add(gauche);
           Node node = new Node(gauche);
            node.parent = n;
            Open1.add(node);
           
           if(obst[y_obj][x_obj-1]==3){found =true;}
         }
       }
       if(adj[3] == 1){
         int []up = {y_obj-1 , x_obj};
         if( !contained_node_version(up) & !found){
           //Open.add(up);
           Node node = new Node(up);
            node.parent = n;
            Open1.add(node);
           
           if(obst[y_obj-1][x_obj]==3){found =true;}
         }
       }
     //}
    
    }
  }
  else{
   if(!found){println("objective not found");}
   else{
   if(finished){ println("found");
    path();
    
    
     finished= false;
    }
  }
   
  }
   
   if ((finished == false) & (draw_finished == false)){
     println("pere");
     int[] a = path.poll();
     
     if(a != null){
       println(" a ", a[0] , " ,, " , a[1]);
     obst[y_obj][x_obj]=0;
     y_obj = a[0];
     x_obj = a[1];
     obst[y_obj][x_obj]=2;
     display();
     delay(200);}
     else{
       draw_finished = true;
     }
   }
}
void display(){
loadPixels();

  for (int x = 0; x < w; x++ ) {
    for (int y = 0; y < h; y++ ) {

      // Calculate the 1D pixel location
      int loc = x + y*w;
      
      i= y/stepy; j=x/stepx;
      int val=obst[i][j];
      switch (val)
      {
        case 0: r= 0; g=0; b=0; break;
        case 1: r= 0; g=0; b=255; break;
        case 2: r= 255; g=0; b=0; break;
        case 3: r= 0; g=255; b=0; break;
         case 4: r=10; g=255; b=33;break;
        case 5: r=10; g=120; b=100;break;
        case 6: r=255; g=255; b=255;break;
      }      

      color c = color(r, g, b);
      //out.pixels[loc]=c;
      pixels[loc] = c;
    }
  }
  updatePixels();
}


boolean check_succ(){ 
  boolean result = false;
  if( (x_obj+1)<w-1){ 
    if(obst[y_obj][x_obj+1] != 1){result = result | true;}
  }
  
  if( (x_obj)>0){ if(obst[y_obj][x_obj-1] != 1){
    result = result | true;}
  }
  
  if( (y_obj+1)<h-1){ if(obst[y_obj+1][x_obj] != 1){
    result = result | true;}
  }
  
  if( (y_obj)>0){ if(obst[y_obj-1][x_obj] != 1){ 
    result = result | true;}
  }
  
  return result;
}

int [] getSucc(){
  int [] succ ={-1,-1,-1,-1};
         //succ= {value(droite) , value(bas), value(gauche),value(up)};
         // si value = -1 : no adjacnt
         // si value = 1  : adjacent
  if( (x_obj+1)<w-1){ if(obst[y_obj][x_obj+1] != 1){succ[0] =1; }}//droite
  
  if( (x_obj)>0){ if(obst[y_obj][x_obj-1] != 1){succ[2] = 1;}}//gauche
  
  if( (y_obj+1)<h-1){ if(obst[y_obj+1][x_obj] != 1){succ[1] = 1;}}//bas
  
  if( (y_obj)>0){ if(obst[y_obj-1][x_obj] != 1){succ[3] = 1;}}
  
  
  return  succ;
}

boolean contained(int[]arr){
  Object[] arr_base = {arr};
  Object[] open_arr = Open.toArray();
  Object[] closed_arr = Closed.toArray();
  for(int i = 0 ; i< Open.size();i++){
    Object[] objectVersionOfOpenElement ={ open_arr[i]};
    if (Arrays.deepEquals(arr_base, objectVersionOfOpenElement)){
      return true;
    }
  }
  for(int i = 0 ; i< Closed.size();i++){
    Object[] objectVersionOfClosedElement ={ closed_arr[i]};
    if (Arrays.deepEquals(arr_base, objectVersionOfClosedElement)){
      return true;
    }
  }
  return false;
}
boolean contained_node_version(int[]arr){
  Object[] arr_base = {arr}; //<>//
  Object[] open_arr = Open1.toArray();
  Object[] closed_arr = Closed1.toArray();
  for(int i = 0 ; i< Open1.size();i++){

    Node n1 =  (Node) open_arr[i];

    Object[] objectVersionOfOpenElement ={ n1.value};
    
    if (Arrays.deepEquals(arr_base, objectVersionOfOpenElement)){
      print("equals");
      return true;
    }
  }
  for(int i = 0 ; i< Closed1.size();i++){
    Node n2 = (Node) closed_arr[i];
    Object[] objectVersionOfClosedElement ={n2.value};
    if (Arrays.deepEquals(arr_base, objectVersionOfClosedElement)){
      return true;
    }
  }
  return false;
}
/*boolean contained_node_version(int[]arr){
  Object[] arr_base = {arr};
  Object[] open_arr = Open1.toArray();
  Object[] closed_arr = Closed1.toArray();
  for(int i = 0 ; i< Open1.size();i++){
    Node n1 =  (Node) open_arr[i];
    Object[] objectVersionOfOpenElement ={ n1.value};
    if (Arrays.deepEquals(arr_base, objectVersionOfOpenElement)){
      print("equals");
      return true;
    }
  }
  for(int i = 0 ; i< Closed.size();i++){
    Node n2 = (Node) closed_arr[i];
    Object[] objectVersionOfClosedElement ={n2.value};
    if (Arrays.deepEquals(arr_base, objectVersionOfClosedElement)){
      return true;
    }
  }
  return false;
}*/
Queue<int[]> path(){
  Node fin = Open1.poll();
  println(" x = ",fin.value[1], " / y = " ,  fin.value[0]);
  path.add(fin.value);
  print(fin.value);
  Node node = fin.parent;
  while(node !=null){
    //for(int i = 0; i< 4 ; i++){
    println("curretn node is " , node);
    path.add(node.value);
    println(" x = ",node.value[1], " / y = " ,  node.value[0]);
    node = node.parent;
    println("new node is " , node);
    pathLength ++;
  }
  reversequeue(path);
  return path;
}


static void reversequeue(Queue<int[]> q) 
    { 
        Stack<int []> stack = new Stack(); 
        while (!q.isEmpty()) { 
            stack.add(q.peek()); 
            q.remove(); 
        } 
        while (!stack.isEmpty()) { 
            q.add(stack.peek()); 
            stack.pop(); 
        } 
    }
    
    
   class Node{
     int[] value;
     Node parent;
     public Node(int[] n) {
      value= n;
      parent = null;
    }
   }
