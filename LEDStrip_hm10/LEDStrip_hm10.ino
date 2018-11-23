// Modified from tutorial: https://www.codemahal.com/video/controlling-an-led-light-using-a-mobile-app-and-bluetooth/

#include <Adafruit_NeoPixel.h>
#include <SoftwareSerial.h>
#include "DHT.h"


#define PIN 3
#define N_LEDS 144 // LED 개수
#define DHTPIN 6
#define DHTTYPE DHT11 // DHT 11

Adafruit_NeoPixel strip = Adafruit_NeoPixel(N_LEDS, PIN, NEO_GRB + NEO_KHZ800);

DHT dht(DHTPIN, DHTTYPE);

int fetPin = 4;
const int pinUP = 255; // max analog output, heater on
const int pinDOWN = 0; // heater off 

SoftwareSerial Bluetooth(7, 8);

void setup() {  
  // Bluetooth
  Serial.begin(9600);
  Bluetooth.begin(9600);
  
  strip.begin();
  strip.show(); // Initialize all pixels to 'off'

//  Serial.begin(9600);
  Serial.println("DHTxx test!");

  dht.begin();

  pinMode(fetPin, OUTPUT);  
}

void loop() {  
  int command;
  
  if (Bluetooth.available()) {
    command = Bluetooth.read();  
    Serial.println("Input received:");
    
    if (command == 1) {
      // A non-zero input will turn on the LED
      Serial.println("1 / ON");
      rainbow(1);
      analogWrite(fetPin, pinUP); // heater on at 100%
//      rainbowCycle(1);
      
    } else if (command == 0) {
      // A zero value input will turn off the LED
      Serial.println("0 / OFF");

      // turn off the LED strip
      for (int i = 0; i < strip.numPixels(); i++) {
        strip.setPixelColor(i, strip.Color(0,0,0));
      }
      
      strip.show();   // important
      analogWrite(fetPin, pinDOWN); // heater off

   } 
        // Wait a few seconds between measurements.
    delay(1);
  
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

     // Send integer to the app. Later change to the temp sensor value.
    Bluetooth.write(t);
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
