// Modified from tutorial: https://www.codemahal.com/video/controlling-an-led-light-using-a-mobile-app-and-bluetooth/

#include <Adafruit_NeoPixel.h>
#include <SoftwareSerial.h>
#include "DHT.h"


#define StripPIN 3
#define RingPIN 9
#define N_LEDS 144 // Number of LEDs
#define DHTPIN 6
#define DHTTYPE DHT11 // DHT 11
void ringOn();
void ringOff();
Adafruit_NeoPixel strip = Adafruit_NeoPixel(N_LEDS, StripPIN, NEO_GRB + NEO_KHZ800);
Adafruit_NeoPixel ring = Adafruit_NeoPixel(16, RingPIN, NEO_GRB + NEO_KHZ800);

DHT dht(DHTPIN, DHTTYPE);

int fetPin = 4;
int state = 0;
int pinUP = 200; // heater on. max analog output is 255
int pinDOWN = 0; // heater off 

SoftwareSerial Bluetooth(7, 8);

void setup() {  
  // Bluetooth
  Serial.begin(9600);
  Bluetooth.begin(9600);
  
  strip.begin();
  strip.show(); // Initialize all pixels to 'off'

  ring.begin();
  ring.show(); // Initialize all pixels to 'off'

  Serial.println("DHTxx test!");
  dht.begin();

  pinMode(fetPin, OUTPUT);  
}

void loop() {  
  int command;
  
  if (Bluetooth.available()) {
    command = Bluetooth.read();  
    Serial.println("Input received:");
    
    if (command == 1) { // turn on LED
      Serial.println("1 / ON");
      state = pinUP;
      Serial.println(state);
      rainbow(1);
//     rainbowCycle(1);
      
    } else if (command == 0) {
      // A zero value input will turn off the LED
      Serial.println("0 / OFF");
      state = pinDOWN;
      Serial.println(state);

      // turn off the LED strip
      for (int i = 0; i < strip.numPixels(); i++) {
        strip.setPixelColor(i, strip.Color(0,0,0));
      }
      
      strip.show();   // important for turning off the LED strip

   } else if (command == 4) {
     analogWrite(fetPin, pinUP); // heater on at 100% 
     ringOn();
    
   } else if (command == 3) {
//     state = pinDOWN;
     analogWrite(fetPin, pinDOWN); // heater off
     ringOff();
   }
        
   delay(1);  // Wait a little bit between measurements.
  
    // Reading temperature or humidity takes about 250 milliseconds!
    // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
    float h = dht.readHumidity();
    // Read temperature as Celsius (the default)
    float t = dht.readTemperature();
    // Read temperature as Fahrenheit (isFahrenheit = true)
    float f = dht.readTemperature(true);
  
    // Check if any reads failed and exit early (to try again).
    if (isnan(h) || isnan(t) || isnan(f)) {
      Serial.println("Failed to read from DHT sensor!");
      return;
  
      // Compute heat index in Fahrenheit (the default)
    float hif = dht.computeHeatIndex(f, h);
    // Compute heat index in Celsius (isFahreheit = false)
    float hic = dht.computeHeatIndex(t, h, false);
  
    Serial.print("Humidity: ");
    Serial.print(h);
    Serial.print(" %\t");
    Serial.print("Temperature: ");
    Serial.print(t);
    Serial.print(" *C ");
    Serial.print(f);
    Serial.print(" *F\t");
    Serial.print("Heat index: ");
    Serial.print(hic);
    Serial.print(" *C ");
    Serial.print(hif);
    Serial.println(" *F");
  }
    // Compute heat index in Fahrenheit (the default)
    float hif = dht.computeHeatIndex(f, h);
    // Compute heat index in Celsius (isFahreheit = false)
    float hic = dht.computeHeatIndex(t, h, false);
  
    Serial.print("Humidity: ");
    Serial.print(h);
    Serial.print(" %\t");
    Serial.print("Temperature: ");
    Serial.print(t);
    Serial.print(" *C ");
    Serial.print(f);
    Serial.print(" *F\t");
    Serial.print("Heat index: ");
    Serial.print(hic);
    Serial.print(" *C ");
    Serial.print(hif);
    Serial.println(" *F");

    Bluetooth.write(t); // Send integer to the app.
  }
}

void rainbow(uint8_t wait) {
  uint16_t i, j;

  for(j=0; j<256; j++) {
    for(i=0; i<strip.numPixels(); i++) {
      strip.setPixelColor(i, Wheel((i+j) & 255));
    }
    strip.show();
    delay(wait);
  }
}

// Slightly different, this makes the rainbow equally distributed throughout
void rainbowCycle(uint8_t wait) {
  uint16_t i, j;

  for(j=0; j<256*5; j++) { // 5 cycles of all colors on wheel
    for(i=0; i< strip.numPixels(); i++) {
      strip.setPixelColor(i, Wheel(((i * 256 / strip.numPixels()) + j) & 255));
    }
    strip.show();
    delay(wait);
  }
}

//Theatre-style crawling lights with rainbow effect (don't use)
void theaterChaseRainbow(uint8_t wait) {
  for (int j=0; j < 256; j++) {     // cycle all 256 colors in the wheel
    for (int q=0; q < 3; q++) {
      for (int i=0; i < strip.numPixels(); i=i+3) {
        strip.setPixelColor(i+q, Wheel( (i+j) % 255));    //turn every third pixel on
      }
      strip.show();

      delay(wait);

      for (int i=0; i < strip.numPixels(); i=i+3) {
        strip.setPixelColor(i+q, 0);        //turn every third pixel off
      }
    }
  }
}

// Input a value 0 to 255 to get a color value.
// The colours are a transition r - g - b - back to r.
uint32_t Wheel(byte WheelPos) {
  WheelPos = 255 - WheelPos;
  if(WheelPos < 85) {
    return strip.Color(255 - WheelPos * 3, 0, WheelPos * 3);
  }
  if(WheelPos < 170) {
    WheelPos -= 85;
    return strip.Color(0, WheelPos * 3, 255 - WheelPos * 3);
  }
  WheelPos -= 170;
  return strip.Color(WheelPos * 3, 255 - WheelPos * 3, 0);
}

void ringOn() {     // turn off the LED ring
  uint16_t i, j;
  
    for(j = 0; j < 100; j++) {
      for(i=0; i<ring.numPixels(); i++) {
        ring.setPixelColor(i, ring.Color(100,0,0));
      }
      ring.show();
      delay(10);
    }
}   

void ringOff() {    // turn off the LED ring
      for (int i = 0; i < ring.numPixels(); i++) {
        ring.setPixelColor(i, ring.Color(0,0,0));
      }
      
      ring.show();   // important for turning off the LED strip  
}
