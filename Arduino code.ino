const int f1 = A0;
const int f2 = A1;
const int f5 = A4;
const int f4 = A3;

// Your mid values
int mid1 = 800;
int mid2 = 820;
int mid3 =900;
int mid4 = 1016;

int v1, v2, v3, v4;

void setup() {
  Serial.begin(9600);
  Serial.println("One Finger Gesture System Started...");
}

void loop() {

  v1 = analogRead(f1);
  v2 = analogRead(f2);
  v3 = analogRead(f5);
  v4 = analogRead(f4);

  Serial.print("F1: "); Serial.print(v1);
  Serial.print(" F2: "); Serial.print(v2);
  Serial.print(" F3: "); Serial.print(v3);
  Serial.print(" F4: "); Serial.println(v4);

  delay(500);
  
   if(v1 > mid1 && v2 > mid2&& v3 > mid3 && v4 > mid4){
    Serial.println("GESTURE:Help!!!");
  }

  else if (v1 > mid1&& v2 < mid2&& v3 < mid3 && v4 < mid4) {
    Serial.println("GESTURE: I Need Water");
  }

  else if (v2 > mid2&& v1 < mid1&& v3 < mid3 && v4 < mid4 ) {
    Serial.println("GESTURE: I Need Food");
  }

  else if (v3 >mid3&& v2 < mid2&& v1 < mid1 && v4 < mid4 ) {
    Serial.println("GESTURE: I Need Medicine");
  }

  else if (v4 > mid4 && v2 < mid2&& v3 < mid3 && v1 < mid1) {
    Serial.println("GESTURE: I Want To Go Washroom");
  }
  

  else {
    Serial.println("No Valid Single-Finger Gesture");
  }
}