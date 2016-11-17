int ldrPin = 0; //LDR no pino analígico 8
int ldrValor = 0; //Valor lido do LDR
long milliInicial = 0;
long milliFinal = 0;
int milliAux = 0;
int milliAux2 = 0;
int flagAux = 5;
int flag; // flag = 1 : Esta maior que 5, flag = 0 : esta menor que cinco
int changeFlag = 0;
int  const PARAMATER = 5;

void setup() {
 Serial.begin(57600); //Inicia a comunicação serial
 ldrValor = analogRead(ldrPin)/100;
 if(ldrValor > 5) flag = 1;
 else flag = 0; 
 milliInicial = millis();
}

void loop() {
  ldrValor = (analogRead(ldrPin)/100);

  if((ldrValor > PARAMATER && flag == 0) || (ldrValor < 5 && flag == 1)){
    changeFlag = 1;
    milliFinal = millis();
    milliAux2 = 0;
  } else {
    changeFlag = 0;
    milliAux2 = millis() - milliInicial;
  }

  if(ldrValor > PARAMATER) flag = 1;
  else flag = 0;

  milliAux = milliFinal - milliInicial;

  if(milliAux > 0){
    if(milliAux <= 250) Serial.println(3);
    if (milliAux >= 251 && milliAux <= 600) Serial.println(2);
    if (milliAux >= 601 && milliAux <= 1000) Serial.println(1);
    flagAux = 1;
  }
  else if(changeFlag == 0 && milliAux2 > 1000) {
    Serial.println(0);
    milliAux2 = 0;
  }
    
  milliAux2 = milliAux;
  milliInicial = milliFinal;
  delay(10);
}
