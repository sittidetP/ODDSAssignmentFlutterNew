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
    int startIndex = 0;

    while (startIndex < c.length){
      int endIndex = 0;
      String num2Str = "";
      if (c[startIndex] == "6") {
        endIndex = startIndex + 6;
        num2Str = "DDO";
      } else if (c[startIndex] == "7") {
        endIndex = startIndex + 8;
        num2Str = "NEVE";
      }

      result += "$num2Str${c[endIndex]}";
      _numIndexInStr[result.length-1] = int.parse(c[endIndex]);
      startIndex = endIndex + 1;
    }
    return result;
  }

  static String _E(String d){
    String lowerD = d.toLowerCase();
    String result = "";
    int startStrRound = 0;
    _numIndexInStr.forEach((key, value) {
      int numIndex = key;
      String wordRev = lowerD.substring(startStrRound, numIndex).split('').reversed.join();
      String rWordRev = "${wordRev[0].toUpperCase()}${wordRev.substring(1)}";
      startStrRound = numIndex + 1;
      result += rWordRev + value.toString();
    });
    return result;
  }

  static int _F(String e){
    String replaceE = e.replaceAll(RegExp(r"[a-zA-Z]"), "");
    int result = int.parse(replaceE);
    return result;
  }
}
