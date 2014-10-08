import processing.serial.*;
XML xml;
Serial serial;

String input;
void setup() {
  serial= new Serial(this, Serial.list()[0], 9600);
}
void draw() {
  xml = loadXML("http://www.drk7.jp/weather/xml/13.xml");
  XML pref= xml.getChild("pref");
  XML []area= pref.getChildren("area");
  XML info= area[3].getChild("info");
  XML weather= info.getChild("weather");

  String tellArea=area[3].getString("id");
  String tellWeather=weather.getContent("weather");

  XML temperature= info.getChild("temperature");
  println(temperature.getContent("temperature"));

  XML []centigrade= temperature.getChildren("range");

  println(tellArea);
  println(tellWeather);


  for (int i=0; i<centigrade.length; i++) {
    String maxmin=centigrade[i].getString("centigrade");
    String tellTemperture=centigrade[i].getContent("range");
    println(maxmin+":");
    println(tellTemperture+"℃");
  }
  XML rainfallchance=info.getChild("rainfallchance");//降水確率読み込み

  XML []chance= rainfallchance.getChildren("period");//時刻別に降水確率を配列に格納
  for (int j=0; j<chance.length; j++) {
    String percent = chance[j].getContent("period");
    String hour =chance[j].getString("hour");

    println(hour);
    println(percent+"%");
  }
  if (tellWeather.equals("晴れ")) {
    serial.write('a');
    //background(255,0,0);
  }
  if (tellWeather.equals("くもりのち雨")) {
    serial.write('b');
  }
}

