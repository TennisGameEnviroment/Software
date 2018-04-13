import processing.serial.*;
import java.awt.Robot;
import java.awt.event.KeyEvent;

import java.awt.event.*;
import java.io.IOException;
 
Serial MiSerial;        // The serial port
byte[] Arreglo;
float JoystickX = 0;
float JoystickY = 0;
float AcelerometroX = 0;
float AcelerometroY = 0;
int inicio = 0;
int modo = 0;
void setup () {
  
  println(Serial.list());
  MiSerial = new Serial(this, Serial.list()[0], 57600);
  
      //try{
      //ProcessBuilder pb = new ProcessBuilder("C:\\Users\\ana teresa\\Desktop\\virtualtennis\\virtualtennis.exe");
      //pb.start();
      //}catch(Exception e)
      //{System.out.print(e);}
}

void draw(){
    try{
      
      //if(inicio == 0){
      //final ProcessBuilder pb = new ProcessBuilder("D:\\Dragon Ball Super\\Dragon Ball Super - Season 5\\Virtua Tennis\\VIRTUA_TENNIS_PC.exe");
      //pb.directory(new File("D:\\Dragon Ball Super\\Dragon Ball Super - Season 5\\Virtua Tennis"));
      //final Process p = pb.start();
      //}
      inicio = 1;
      Robot robot = new Robot();
      robot.delay(1);
          if (MiSerial.available() == 9) {
            Arreglo = MiSerial.readBytes(9);
            if(int(Arreglo[0]) == 242){
              JoystickX = (((int(Arreglo[1]) & 127) *256)>>1) + int(Arreglo[2]);
              JoystickY = (((int(Arreglo[3]) & 127) *256)>>1) + int(Arreglo[4]);
              AcelerometroX = ((int(Arreglo[5]) *256)>>1) + int(Arreglo[6]);
              AcelerometroY = ((int(Arreglo[7]) *256)>>1) + int(Arreglo[8]);
             println(AcelerometroY);
            }
            
            if(JoystickX > 3000){
              robot.keyRelease(KeyEvent.VK_W);
              robot.keyPress(KeyEvent.VK_S);
            }
            else if(JoystickX < 1000){
              robot.keyRelease(KeyEvent.VK_S);
              robot.keyPress(KeyEvent.VK_W);
            }
            else{
              robot.keyRelease(KeyEvent.VK_W);              
              robot.keyRelease(KeyEvent.VK_S);
            }  
            if(JoystickY > 3000){
              robot.keyRelease(KeyEvent.VK_D);
              robot.keyPress(KeyEvent.VK_A);
            }
            else if(JoystickY < 1000){
              robot.keyRelease(KeyEvent.VK_A);
              robot.keyPress(KeyEvent.VK_D);
            }else{              
              robot.keyRelease(KeyEvent.VK_A);
              robot.keyRelease(KeyEvent.VK_D);
            }
           if(AcelerometroY < 1640){
              robot.keyPress(KeyEvent.VK_L);
              robot.delay(40);
              robot.keyRelease(KeyEvent.VK_L); 
            }
            if(AcelerometroX > 1700){
              robot.keyPress(KeyEvent.VK_K);
              robot.delay(40);
              robot.keyRelease(KeyEvent.VK_K);              
            }
            if(AcelerometroX < 1000){              
              robot.keyPress(KeyEvent.VK_K);
              robot.keyPress(KeyEvent.VK_W);
              robot.delay(40);
              robot.keyRelease(KeyEvent.VK_K);
              robot.keyRelease(KeyEvent.VK_W);              
            }
            
            if(int(Arreglo[3])<128){
              robot.keyPress(KeyEvent.VK_K);
              robot.delay(40);
              robot.keyRelease(KeyEvent.VK_K);
            }
             if(int(Arreglo[1])<128)
             {
              robot.keyPress(KeyEvent.VK_ENTER);
                    robot.delay(40);
              robot.keyRelease(KeyEvent.VK_ENTER);
            }
            
              
              
              
          }
       MiSerial.clear();   
      
    }
      catch (Exception e) {
         e.printStackTrace();
      }    
}