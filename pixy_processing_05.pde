import processing.serial.*;

int SCREENWITDH= 1200;
int SCREENHEIGHT= 800;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
String sx,sy ,sw,sh, sig;
int x, y, w,h, s;

int lf = 10; 

int[] objecte = new int[6];
int[] objectePrev = new int[6];
boolean[] controlObj = new boolean[7];
boolean fons = true;


void setup()
{
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  
  size(1000,600);
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  fill(255,0,0);
  //frameRate(50);
  smooth();

}

void draw(){ 
  //background(0);
  while ( myPort.available() > 0) {
   //background(0); 
   // If data is available,
    
    val = myPort.readStringUntil(int('.'));
        // read it and store it in val

   if(val!=null && val.length() == 24) {
     //println(val.length());
     //println(val);   

     sx= val.substring(0,3);
     sy= val.substring(5,8);
     sw = val.substring(10,13);
     sh = val.substring(15,18);
     sig = val.substring(20,23);

     x= parseInt(sx);
     y= parseInt(sy);
     w= parseInt(sw);
     h= parseInt(sh);
     s= parseInt(sig);
     
     print(s);
     print(": ");
     println(x);
     
     objecte[s] = x;

     //detecció de la figura a l'inici
     if(fons){
         if(s==1){ controlObj[s] = true; }
         if(s==4){ controlObj[s] = true; }
         fons = false;
     }
     
     if(controlObj[1]){ fill(255,0,0); rect(0,0,width,height); } // fons vermell
     if(controlObj[4]){ fill(0,125,50); rect(0,0,width,height); } // fons verd
      
     if(s==1){  // figura vermell 
       if(abs(objecte[1]-objectePrev[1])>5 && abs(objecte[1]-objectePrev[1])<20){
         fill(255,0,0);
         rect((300-objecte[1])*width/300,100,50,50);
         objectePrev[1] = objecte[1];
       }
       else{
           fill(255,0,0);
           rect((300-objectePrev[1])*width/300,100,50,50);
       }
     }  
     else{
         fill(255,0,0);
         rect((300-objectePrev[1])*width/300,100,50,50);
     }
     
     if(s==4){  // figura verd
       if(abs(objecte[4]-objectePrev[4])>5 && abs(objecte[4]-objectePrev[4])<20){
         fill(0,125,50);
         rect((300-objecte[4])*width/300,200,50,50);
         objectePrev[4] = objecte[4];
       }
       else{
         fill(0,125,50);
         rect((300-objectePrev[4])*width/300,200,50,50);
       }
     } 
     else{
         fill(0,125,50);
         rect((300-objectePrev[4])*width/300,200,50,50);
     }
     
     if(abs(objecte[1]-objecte[4])<60 && objecte[1] > 100){ line(25+(300-objecte[1])*width/300,125,25+(300-objecte[4])*width/300,225); }
     
     // màscara
     fill(0);
     rect(0,0,150,height);
     rect(width-150,0,150,height);  
    
   } //-----------fi if(val!=null)
  

  } //-----------fi while()
    

} //------fi draw()


  