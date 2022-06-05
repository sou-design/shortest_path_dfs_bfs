import java.util.Queue;
import java.util.Stack;
import java.util.ArrayDeque;
import java.util.Arrays; 

boolean flag =true;
int tour;
int i,j, w, h;
float r,g,b;
int x_int = 6;int y_int = 1;//to be used after applying the algho 'memorized'
int x_obj = 6;
int y_obj = 1;//current
int L =5; // level of depth
int x_fin = 5;// finales
int y_fin = 7;

int [] fin ={ y_fin,x_fin};
int stepx,stepy;
int c = 0;
int [][]obst={{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,2,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1},
        {1,1,0,0,1,0,0,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,1,0,0,1,1,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,3,0,0,0,0,0,0,1,0,0,1},
        {1,0,0,0,1,0,0,0,0,0,0,0,1,0,0,1},
        {1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}}; 

boolean hh = true;
static final int DIM = 100, MAX = 03000, DETAIL = 1000, DEPTH = 2000;

 
static final boolean HAS_MAX_LIMIT = true;
 
 Stack<int[]> Open = new Stack();
  Queue<int[]> Closed = new ArrayDeque(MAX);
  Queue<int[]> visited = new ArrayDeque(MAX);
   Queue<int[]> path = new ArrayDeque(MAX);

 boolean  found =false;
 

void setup() {
  size(512, 512);
 w=512;
 h=512;
 tour=0;
 frameRate(30);
 stepx = w/16;stepy=h/16;
  display();
  L = y_fin;
  
  // first part of the alghorithm 
  if (obst[y_obj][x_obj] == obst[y_fin][x_fin]){
    found =true;
  }
  else{
    if ( check_succ() == false ){found =false;}
    else{
      int a[] = {y_obj,x_obj};
      Open.push(a);
    }
  }
}

void draw() {
  // the rest of the alghorithm:
  if((found) | (Open.size()==0)){ flag = false;println("end");}
  if(flag){
     println("size=",Open.size());
    int n[] = Open.pop();
    
    println(n);
    obst[y_obj][x_obj]=0;
    x_obj = n[1];
    y_obj = n[0];
    obst[y_obj][x_obj]=2;
    display();
    delay(400);
    println("x=",n[1]);
    println("y=",n[0]);
    println("################");
    
    visited.add(n);
    
    int  level = n[0];
    // lets check if the current node has successors
    if ( check_succ() ){
    // it has children wow:
    
      if(level <L)
        {
          L++;
         int [] adj = getSucc();
         for(int i = 0; i<4 ; i++){
           if(adj[0] == 1){
             int []droite = {y_obj , x_obj+1};
             if( !contained(droite)){
               Open.push(droite);
                visited.add(droite);
               if(obst[y_obj][x_obj+1]==3){found =true;}
             }
           }
           if(adj[1] == 1){
             int []bas = {y_obj+1 , x_obj};
             if( !contained(bas)){
                 visited.add(bas);
               Open.push(bas);
               if(obst[y_obj+1][x_obj]==3){found =true;}
             }
           }
           if(adj[2] == 1){
             int []gauche = {y_obj , x_obj-1};
             if( !contained(gauche)){
               Open.push(gauche);
                visited.add(gauche);
               if(obst[y_obj][x_obj-1]==3){found =true;}
             }
           }
           if(adj[3] == 1){
             int []up = {y_obj-1 , x_obj};
             if( !contained(up)){
               Open.push(up);
               visited.add(up);
               if(obst[y_obj-1][x_obj]==3){found =true;}
             }
           }
         }
        
        }
    }
  }
  ///-----------------------------------------------
  else{
   if(!found){println("objective not found");}
   else{
   if(hh){ println("found");
    
     hh= false;
    }
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

  Object[] closed_arr = visited.toArray();

  for(int i = 0 ; i< visited.size();i++){
    Object[] objectVersionOfClosedElement ={ closed_arr[i]};
    if (Arrays.deepEquals(arr_base, objectVersionOfClosedElement)){
      return true;
    }
  }
  return false;
}
