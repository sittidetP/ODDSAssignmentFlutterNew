import 'package:flutter/material.dart';
import 'package:oddsasflutter/otherClass/BackwardProcess.dart';
import 'package:oddsasflutter/otherClass/ForwardProcess.dart';

class MainProcess extends StatefulWidget {
  const MainProcess({Key? key}) : super(key: key);

  @override
  _MainProcessState createState() => _MainProcessState();
}

class _MainProcessState extends State<MainProcess> {
  final TextEditingController _controller = TextEditingController();

  final List _results = [];

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorPositiveInteger() {
    _showMaterialDialog("Error", "Enter the positive integer only!");
    _controller.clear();
  }

  void _checkInputAndProcess() {
    //ตรวจสอบข้อมูลเข้า แล้วนำไปประมวลผล
    setState(() {
      if (_results.isNotEmpty) {
        _results.clear();
      }

      int? input = int.tryParse(_controller.text);
      if (input != null &&
          input >= 0 &&
          !input.toString().contains('e') &&
          !input.toString().contains("-")) {
        List fwdResult = ForwardProcess.startProcess(input);
        _results.addAll(fwdResult);
        List bwdResult = BackwardProcess.startProcess(fwdResult.last);
        _results.addAll(bwdResult);
      } else {
        _showErrorPositiveInteger();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ODDS Assignment'),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            _buildInputPanel(), //ที่ใส่เลข
            _buildOutputProcess(), //ที่แสดงผลลัพธ์
          ],
        ),
      ),
    );
  }

  Widget _buildOutputProcess() { //ที่แสดงผลลัพธ์
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text( //หัวข้อ Process Statement สีขาว
              "Process Statement",
              style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Column( //ผลลัพธ์ของแต่ละขั้น
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < _results.length; ++i)
                  Text(
                    "${String.fromCharCode(65 + i)} : ${_results[i]}", //${String.fromCharCode(65 + i)} เป็นสตริงที่แปลงจาก ascii เป็นสตริง
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 26.0),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInputPanel() { //ที่ใส่เลข
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Flexible(
              child: TextField( //ช่องใส่เลข
                onSubmitted: (value) {
                  //เมื่อกด enter
                  _checkInputAndProcess();
                },
                controller: _controller,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
                cursorColor: Colors.white,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                    )),
                    hintText: 'Enter the positive integer here',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 20.0,
                    )),
              ),
            ),
            TextButton( //ปุ่ม Process
              onPressed: () { //เมื่อกดปุ่ม Process
                _checkInputAndProcess();
              },
              child: const Text(
                'Process',
                style: TextStyle(fontSize: 22.0, color: Colors.yellow),
              ),
            )
          ],
        ),
      ),
    );
  }
}
