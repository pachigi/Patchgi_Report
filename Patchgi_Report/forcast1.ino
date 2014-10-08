
#include <AquesTalk.h>
#include <Wire.h>  

AquesTalk atp;

float RV=3.3,vf,fg,svf;
float tellg[20];
int n,sn,gcount;

void setup(){
  Serial.begin(9600);
}

void loop()
{
  svf=0;
  sn=0;

  for(int i=0;i<10;i++){

    n=analogRead(0);
    vf=n*RV/1024;
    svf+=vf;
    sn+=n;
  }
  vf=svf/10;
  n=sn/10;
  fg=vf*18.715-17.813;
  tellg[gcount]=(fg+6.5)*(5/3)+2.5;
  Serial.println(tellg[gcount]);

  if(tellg[gcount]>6){
    if(Serial.available()>0){
      int data=Serial.read();
      if(data=='a'){
        atp.Synthe("senntakusiyo?.");
      }
    } 

  }
  if(tellg[gcount-1]>6&&tellg[gcount]<3){
    
    if(Serial.available()>0){
      int data=Serial.read();
      if(data=='b'){
        atp.Synthe("kyouwagogokaraamedayo?.");
      }
    }

  }

  gcount++;
  if(gcount>19){
    gcount=0;
  }
  delay(500);
}






