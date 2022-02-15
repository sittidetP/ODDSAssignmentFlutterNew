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

    String int2Str = input.toString();
    String result = "";
    for(var i = 0; i < int2Str.length; ++i){
      int intInStr = int.parse(int2Str[i]);
      if(intInStr % 2 == 0){
        result += "Even$intInStr";
      }else{
        result += "Odd$intInStr";
      }
      _numIndexInStr[result.length - 1] = intInStr;
    }
    return result;
  }

  static String _B(String a){
    String upperA = a.toUpperCase();
    int startStrRound = 0;
    String result = "";
    _numIndexInStr.forEach((key, value) {
      int numIndex = key;
      String wordRev = upperA.substring(startStrRound, numIndex).split('').reversed.join();
      startStrRound = numIndex + 1;
      result += wordRev + value.toString();
    });
    return result;
  }

  static String _C(String b){
    String result = "";
    List<String> spiltB = b.split(RegExp(r"[0-9]"));
    spiltB.removeLast();
    int countSpiltB = 0;
    _numIndexInStr.forEach((key, value) {
      if(spiltB[countSpiltB].isNotEmpty){
        String str2ascii = spiltB[countSpiltB].codeUnits.join();
        result += str2ascii + value.toString();
        ++countSpiltB;
      }
    });
    return result;
  }
}