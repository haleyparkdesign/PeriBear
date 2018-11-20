// Modified from tutorial: https://www.codemahal.com/video/controlling-an-led-light-using-a-mobile-app-and-bluetooth/

#include <SoftwareSerial.h>
int led = 2;

SoftwareSerial Bluetooth(7, 8);

void setup() {  
  Serial.begin(9600);
  Bluetooth.begin(9600);
  pinMode(led, OUTPUT);
}

void loop() {  
  int command;
  
  if (Bluetooth.available()) {
    command = Bluetooth.read();  
    Serial.println("Input received:");
    
    if (command == 1) {
      // A non-zero input will turn on the LED
      Serial.println("1 / ON");
      digitalWrite(led, HIGH);
      
    } else if (command == 0) {
      // A zero value input will turn off the LED
      Serial.println("0 / OFF");
      digitalWrite(led, LOW);
    } 

    // Send integer to the app. Later change to the temp sensor value.
    int temperature = 99;
    Bluetooth.write(temperature);
  }
}
