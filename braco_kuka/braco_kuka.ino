#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <Servo.h>

WiFiUDP conexao;//Cria um objeto da classe UDP.
char pacote[5];//String que armazena os dados recebidos pela rede.
String servo;
Servo s1,s2,s3,s4,s5; 
int valor;


void setup() {

  s1.attach(2); 
  s2.attach(0);
  s3.attach(4);
  s4.attach(5);
  s5.attach(13); 
  WiFi.mode(WIFI_AP);//Define o ESP8266 como Acess Point.
  WiFi.softAP("Kuka_", "");//Cria um WiFi de nome "NodeMCU" e sem senha.
  delay(2000);//Aguarda 2 segundos para completar a criaçao do wifi.
  conexao.begin(3333);
  Serial.begin(9600);
  Serial.println(WiFi.softAPIP());
  

}

void loop() {
  int tamanhoPacote = conexao.parsePacket();
  if(tamanhoPacote == 5){
    conexao.read(pacote,5);
    servo =  String(pacote).substring(0,2);
    valor = ((String(pacote).substring(2,6)).toInt());
    Serial.println(servo);
    Serial.println(valor);
    if (servo == "s1"){
      s1.write(valor);
    }
      if (servo == "s2"){
      s2.write(valor);
    }
      if (servo == "s3"){
      s3.write(valor);
    }
      if (servo == "s4"){
      s4.write(valor);
    }
      if (servo == "s5"){
      s5.write(valor);
      Serial.println(5);
    }
  }
}
