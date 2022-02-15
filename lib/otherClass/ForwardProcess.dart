class ForwardProcess {
  static Map<int, int> _numIndexInStr = {};
  static List _resultFwd = [];

  static List startProcess(dynamic input){
    if(_numIndexInStr != null){
      _numIndexInStr.clear();
    }
    if(_resultFwd.isNotEmpty){
      _resultFwd.clear();
    }
    _resultFwd.add(_A(input));
    _resultFwd.add(_B(_resultFwd[0]));
    _resultFwd.add(_C(_resultFwd[1]));
    return _resultFwd;
  }

  static String _A(int input){

    String int2Str = input.toString(); //แปลง input ที่เป็นเลข ให้เป็น String เพื่อไม่ให้มีเลขไหนขาดตกไปตอนที่ หาค่าของเลขแต่ละตัว เช่น กรณี 100
    String result = "";
    for(var i = 0; i < int2Str.length; ++i){
      int intInStr = int.parse(int2Str[i]); //หยิบเลขแต่ละตัว ออกมา
      if(intInStr % 2 == 0){ //เช็คว่าเป็นเลขคี่หรือเลขคู่
        result += "Even$intInStr";
      }else{
        result += "Odd$intInStr";
      }
      _numIndexInStr[result.length - 1] = intInStr; //เก็บตำแหน่งและเลขไว้ใน _numIndexInStr โดย key เป็นตำแหน่งบนสตริง และ value เป็นเลขแต่ละตัว
    }
    return result;
  }

  static String _B(String a){
    String upperA = a.toUpperCase(); //แปลงสตริงจาก A ให้เป็นพิมพ์ใหญ่ทั้งหมด
    int startStrRound = 0; //ตัวนับของตำแหน่งเริ่มต้นของคำ Odd หรือ Even
    String result = "";
    _numIndexInStr.forEach((key, value) { //วนตามแต่ละ element ใน _numIndexInStr
      int numIndex = key; //ตำแหน่งของเลขบนสตริง
      String wordRev = upperA.substring(startStrRound, numIndex).split('').reversed.join(); //ตัดสตริงแล้วกลับอักษรจากหน้ามาหลัง เช่น ODD => DDO
      startStrRound = numIndex + 1; //ให้ startStrRound = ตำแหน่งของตัวอักษรตัวแรกของคำต่อไป
      result += wordRev + value.toString(); //นำคำที่นำมาต่อกับเลข
    });
    return result;
  }

  static String _C(String b){
    String result = "";
    List<String> spiltB = b.split(RegExp(r"[0-9]")); //แยกคำโดยใช้เลขเป็นตัวแบ่ง
    spiltB.removeLast(); //ลบ element สุดท้ายออก เพราะ เวลา split จะเกิด element ว่างขึ้นมาต่อท้าย
    int countSpiltB = 0; //ตัวนับตำแหน่ง spiltB
    _numIndexInStr.forEach((key, value) {
      if(spiltB[countSpiltB].isNotEmpty){
        String str2ascii = spiltB[countSpiltB].codeUnits.join(); //แปลงสตริงให้เป็นรหัส ascii
        result += str2ascii + value.toString(); //นำคำที่นำมาต่อกับเลข
        ++countSpiltB;
      }
    });
    return result;
  }
}