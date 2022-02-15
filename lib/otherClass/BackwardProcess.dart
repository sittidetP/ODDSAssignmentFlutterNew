class BackwardProcess {
  static Map<int, int> _numIndexInStr = {};
  static List _resultBwd = [];
  static List startProcess(String fwdResult){
    if(_numIndexInStr != null){
      _numIndexInStr.clear();
    }
    if(_resultBwd.isNotEmpty){
      _resultBwd.clear();
    }
    _resultBwd.add(_D(fwdResult));
    _resultBwd.add(_E(_resultBwd[0]));
    _resultBwd.add(_F(_resultBwd[1]));
    return _resultBwd;
  }
  static String _D(String c) {
    String result = "";
    int startIndex = 0; //ตำแหน่งของตัวอักษรตัวแรกของคำที่อยู่หน้าตัวเลข ที่แปลงเป็นรหัส ascii

    while (startIndex < c.length){
      int endIndex = 0;
      String num2Str = "";
      if (c[startIndex] == "6") { //ถ้าอักษรตัวแรกของคำ เป็น 6 จะเป็น 686879 (DDO)
        endIndex = startIndex + 6;
        num2Str = "DDO";
      } else if (c[startIndex] == "7") { //ถ้าอักษรตัวแรกของคำ เป็น 7 จะเป็น 78698669 (NEVE)
        endIndex = startIndex + 8;
        num2Str = "NEVE";
      }

      result += "$num2Str${c[endIndex]}"; //นำคำที่นำมาต่อกับเลข
      _numIndexInStr[result.length-1] = int.parse(c[endIndex]); //เก็บตำแหน่งและเลขไว้ใน _numIndexInStr โดย key เป็นตำแหน่งบนสตริง และ value เป็นเลขแต่ละตัว
      startIndex = endIndex + 1;
    }
    return result;
  }

  static String _E(String d){
    String lowerD = d.toLowerCase(); //แปลงสตริงจาก B ให้เป็นพิมพ์ใหญ่ทั้งหมด
    String result = "";
    int startStrRound = 0; //ตัวนับของตำแหน่งเริ่มต้นของคำ DDO หรือ NEVE
    _numIndexInStr.forEach((key, value) { //วนตามแต่ละ element ใน _numIndexInStr
      int numIndex = key; //ตำแหน่งของเลขบนสตริง
      String wordRev = lowerD.substring(startStrRound, numIndex).split('').reversed.join(); //ตัดสตริงแล้วกลับอักษรจากหน้ามาหลัง เช่น ddo => odd
      String rWordRev = "${wordRev[0].toUpperCase()}${wordRev.substring(1)}"; //แปลงให้คำแรกของ wordRev เป็นตัวพิมพ์ใหญ่ แล้วนำที่เหลือมาต่อ
      startStrRound = numIndex + 1;
      result += rWordRev + value.toString(); //นำคำที่นำมาต่อกับเลข
    });
    return result;
  }

  static int _F(String e){
    String replaceE = e.replaceAll(RegExp(r"[a-zA-Z]"), ""); //แทนที่ตัวอักษรด้วย ""
    int result = int.parse(replaceE); //แปลง replaceE ให้เป็น int
    return result;
  }
}
