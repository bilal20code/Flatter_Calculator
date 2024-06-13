import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String result = "";

  void handleKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      final key = event.logicalKey;
      if (key == LogicalKeyboardKey.digit1 || key == LogicalKeyboardKey.numpad1) {
        abc('1');
      } else if (key == LogicalKeyboardKey.digit2 || key == LogicalKeyboardKey.numpad2) {
        abc('2');
      } else if (key == LogicalKeyboardKey.digit3 || key == LogicalKeyboardKey.numpad3) {
        abc('3');
      } else if (key == LogicalKeyboardKey.digit4 || key == LogicalKeyboardKey.numpad4) {
        abc('4');
      } else if (key == LogicalKeyboardKey.digit5 || key == LogicalKeyboardKey.numpad5) {
        abc('5');
      } else if (key == LogicalKeyboardKey.digit6 || key == LogicalKeyboardKey.numpad6) {
        abc('6');
      } else if (key == LogicalKeyboardKey.digit7 || key == LogicalKeyboardKey.numpad7) {
        abc('7');
      } else if (key == LogicalKeyboardKey.digit8 || key == LogicalKeyboardKey.numpad8) {
        abc('8');
      } else if (key == LogicalKeyboardKey.digit9 || key == LogicalKeyboardKey.numpad9) {
        abc('9');
      } else if (key == LogicalKeyboardKey.digit0 || key == LogicalKeyboardKey.numpad0) {
        abc('0');
      } else if (key == LogicalKeyboardKey.equal || key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.numpadEnter) {
        output();
      } else if (key == LogicalKeyboardKey.add || key == LogicalKeyboardKey.numpadAdd) {
        abc('+');
      } else if (key == LogicalKeyboardKey.minus || key == LogicalKeyboardKey.numpadSubtract) {
        abc('-');
      } else if (key == LogicalKeyboardKey.asterisk || key == LogicalKeyboardKey.numpadMultiply) {
        abc('*');
      } else if (key == LogicalKeyboardKey.slash || key == LogicalKeyboardKey.numpadDivide) {
        abc('/');
      } else if (key == LogicalKeyboardKey.backspace) {
        clear();
      }
    }
  }

  Widget btn(String texttt, {Color color = Colors.blueAccent}) {
    return ElevatedButton(
      onPressed: () {
        abc(texttt);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Button background color
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        textStyle: TextStyle(fontSize: 24),
      ),
      child: Text(texttt),
    );
  }

  void abc(String texttt) {
    setState(() {
      result += texttt;
    });
  }

  void clear() {
    setState(() {
      result = "";
    });
  }

  void output() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(result);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        result = eval.toString();
      });
    } catch (e) {
      setState(() {
        result = "Error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, // Background color
      body: RawKeyboardListener(
        focusNode: FocusNode()..requestFocus(),
        onKey: handleKey,
        autofocus: true,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.topRight,
                child: Text(
                  result,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      btn("7", color: Colors.grey[850]!),
                      btn("8", color: Colors.grey[850]!),
                      btn("9", color: Colors.grey[850]!),
                      btn("/", color: Colors.orange),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      btn("4", color: Colors.grey[850]!),
                      btn("5", color: Colors.grey[850]!),
                      btn("6", color: Colors.grey[850]!),
                      btn("*", color: Colors.orange),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      btn("1", color: Colors.grey[850]!),
                      btn("2", color: Colors.grey[850]!),
                      btn("3", color: Colors.grey[850]!),
                      btn("-", color: Colors.orange),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      btn("0", color: Colors.grey[850]!),
                      ElevatedButton(
                        onPressed: output,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Button background color
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                          textStyle: TextStyle(fontSize: 24),
                        ),
                        child: Text('='),
                      ),
                      ElevatedButton(
                        onPressed: clear,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Button background color
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                          textStyle: TextStyle(fontSize: 24),
                        ),
                        child: Text('C'),
                      ),
                      btn("+", color: Colors.orange),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
