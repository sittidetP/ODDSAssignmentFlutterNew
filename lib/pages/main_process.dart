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
          input != -0.0) {
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
        child: Column(
          children: [
            _buildInputPanel(),
            Row(
              children: [
                Expanded(
                  child: _buildOutputProcess(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOutputProcess() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Process Statement",
              style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < _results.length; ++i)
                  Text(
                    "${String.fromCharCode(65 + i)} : ${_results[i]}",
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

  Flexible _buildInputPanel() {
    return Flexible(
      child: Container(
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
                child: TextField(
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
              TextButton(
                onPressed: () {
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
      ),
    );
  }
}
