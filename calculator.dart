import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '0';
  double num1 = 0;
  double num2 = 0;
  String operand = '';

  void _buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      _clear();
    } else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/') {
      _operandPressed(buttonText);
    } else if (buttonText == '=') {
      _calculate();
    } else {
      _digitPressed(buttonText);
    }
  }

  void _clear() {
    setState(() {
      _output = '0';
      num1 = 0;
      num2 = 0;
      operand = '';
    });
  }

  void _operandPressed(String newOperand) {
    setState(() {
      operand = newOperand;
      num1 = double.parse(_output);
      _output = '0';
    });
  }

  void _digitPressed(String digit) {
    setState(() {
      if (_output == '0') {
        _output = digit;
      } else {
        _output += digit;
      }
    });
  }

  void _calculate() {
    setState(() {
      num2 = double.parse(_output);
      switch (operand) {
        case '+':
          _output = (num1 + num2).toString();
          break;
        case '-':
          _output = (num1 - num2).toString();
          break;
        case '*':
          _output = (num1 * num2).toString();
          break;
        case '/':
          if (num2 != 0) {
            _output = (num1 / num2).toString();
          } else {
            _output = 'Error';
          }
          break;
      }
      operand = '';
      num1 = 0;
      num2 = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    int columns = 4; 
    return Scaffold(
      appBar: AppBar(
        title: Text('My Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttonText.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _buttonPressed(buttonText[index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isOperator(buttonText[index])
                            ? Color.fromARGB(255, 176, 104, 9)
                            : Color.fromARGB(220, 141, 128, 128),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          buttonText[index],
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: isOperator(buttonText[index])
                                ? Colors.white
                                : Color.fromARGB(255, 6, 6, 6),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String buttonText) {
    return buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '*' ||
        buttonText == '/' ||
        buttonText == '=';
  }

  final List<String> buttonText = [
    '7', '8', '9', '/',
    '4', '5', '6', '*',
    '1', '2', '3', '-',
    'C', '0', '=', '+',
    '(', ')', '.','%',];
}
