
int Val;

void setup ()
{
  randomSeed(analogRead(0));
  Serial.begin(9600);
}

void loop () {
  if (Serial.available()) {
     Serial.read() / 255.0f;
  }

  Val = 80;
  delay(250); //250 ms para proximo numero
  
  Serial.println(Val, DEC);
}
