#include <WiFi.h>
#include <Firebase_ESP_Client.h>

#include <HX711.h>
#include <Wire.h>
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>

#include <OneWire.h>
#include <DallasTemperature.h>

#include <time.h>

#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"



// WiFi name and password
#define WIFI_SSID "Galaxy"
#define WIFI_PASSWORD "11111112"



// Firebase API and database URL
#define API_KEY "AIzaSyAiRh0VTmfAvrnv3vbdnzlSkj8-O-tg_Nw"
#define DATABASE_URL "https://smart-water-bottle-iot-default-rtdb.asia-southeast1.firebasedatabase.app/"



// Pins used for sensors
#define DT 18
#define SCK 19
#define ONE_WIRE_BUS 4
#define TDS_PIN 34
#define VREF 3.3



// Create objects for sensors
HX711 scale;
Adafruit_MPU6050 mpu;

OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature tempSensor(&oneWire);

// Firebase objects
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;



// calibration value for the load cell
float calibration_factor = 373.2;

// used to compare previous weight
float previousWeight = 0;

// check if MPU6050 works
bool mpuReady = false;



// function to connect ESP32 to WiFi
void connectWiFi()
{
  Serial.print("Connecting WiFi");

  WiFi.mode(WIFI_STA);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

  // wait until WiFi connects
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(500);
  }

  Serial.println(" Connected");
}



// get time from internet using NTP
void setupTime()
{
  configTime(19800, 0, "pool.ntp.org", "time.nist.gov"); 
  // Sri Lanka time offset

  Serial.println("Waiting for NTP time...");

  struct tm timeinfo;

  // wait until time is received
  while (!getLocalTime(&timeinfo))
  {
    Serial.print(".");
    delay(500);
  }

  Serial.println(" Time synced!");
}

// function to get current date
String getDate()
{
  struct tm timeinfo;
  getLocalTime(&timeinfo);

  char dateString[11];

  strftime(dateString, sizeof(dateString), "%Y-%m-%d", &timeinfo);

  return String(dateString);
}

// function to get current time
String getTime()
{
  struct tm timeinfo;
  getLocalTime(&timeinfo);

  char timeString[9];

  strftime(timeString, sizeof(timeString), "%H:%M:%S", &timeinfo);

  return String(timeString);
}



void setup()
{

  Serial.begin(115200);

  Serial.println("STEP 1: Boot");

  // connect to WiFi
  connectWiFi();

  Serial.println("STEP 2: WiFi OK");

  // sync time
  setupTime();

  Serial.println("STEP 3: Time synced");

  

  // firebase config
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;
  config.token_status_callback = tokenStatusCallback;

  auth.user.email = "main.inoj@gmail.com";
  auth.user.password = "111111";

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  Serial.println("STEP 4: Firebase initialized");

  

  // setup HX711 load cell
  scale.begin(DT, SCK);
  scale.set_scale(calibration_factor);
  scale.tare();

  Serial.println("STEP 5: HX711 ready");

 

  // start temperature sensor
  tempSensor.begin();

  Serial.println("STEP 6: Temperature sensor ready");

 

  Wire.begin(21,22);

  // check if MPU6050 is detected
  if (!mpu.begin())
  {
    Serial.println("MPU6050 NOT detected");
  }
  else
  {
    Serial.println("MPU6050 detected");
    mpuReady = true;
  }

  Serial.println("Setup complete");
}



void loop()
{



  // read weight from load cell
  float weight = scale.get_units(10);

  // remove small noise values
  if(weight < 2)
    weight = 0;

 

  // get water temperature
  tempSensor.requestTemperatures();
  float temperature = tempSensor.getTempCByIndex(0);

 

  // read TDS analog value
  int raw = analogRead(TDS_PIN);

  float voltage = raw * (VREF / 4095.0);

  // temperature compensation
  float compensationCoefficient = 1.0 + 0.02 * (temperature - 25.0);

  float compensationVoltage = voltage / compensationCoefficient;

  // calculate TDS value
  float tds = (133.42 * pow(compensationVoltage,3)
              -255.86 * pow(compensationVoltage,2)
              +857.39 * compensationVoltage) * 0.5;

  

  sensors_event_t a, g, temp;
  float tilt = 0;

  // read tilt only if MPU is working
  if (mpuReady)
  {
    mpu.getEvent(&a, &g, &temp);
    tilt = abs(a.acceleration.x) + abs(a.acceleration.y);
  }

  

  // check if water level suddenly drops
  float consumed = previousWeight - weight;

  bool drinking = false;

  // simple condition to detect drinking
  if(consumed > 30 && consumed < 400 && tilt > 5)
  {
    drinking = true;
  }

 

  Serial.println("------------");

  Serial.print("Weight: ");
  Serial.println(weight);

  Serial.print("Temperature: ");
  Serial.println(temperature);

  Serial.print("TDS: ");
  Serial.println(tds);

  Serial.print("Tilt: ");
  Serial.println(tilt);

 

  // send data to firebase
  if(Firebase.ready())
  {

    Firebase.RTDB.setFloat(&fbdo,"/smartBottle/live/weight",weight);
    Firebase.RTDB.setFloat(&fbdo,"/smartBottle/live/temperature",temperature);
    Firebase.RTDB.setFloat(&fbdo,"/smartBottle/live/tds",tds);

    Firebase.RTDB.setInt(&fbdo,"/smartBottle/live/heartbeat",time(NULL));

    Firebase.RTDB.setString(&fbdo,"/smartBottle/live/time",getTime());

    // if drinking detected, save history
    if(drinking)
    {

      Firebase.RTDB.setFloat(&fbdo,"/smartBottle/live/lastDrink",consumed);

      String datePath = "/smartBottle/history/" + getDate() + "/" + getTime();

      Firebase.RTDB.setFloat(&fbdo, datePath, consumed);

      Serial.print("User drank: ");
      Serial.println(consumed);

    }

  }

  // update previous weight for next loop
  previousWeight = weight;

  delay(3000);
}
