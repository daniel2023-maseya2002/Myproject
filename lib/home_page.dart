import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayText = '0';
  String inputState = '';
  String operand = '';
  double num1 = 0;
  double num2 = 0;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'CLEAR') {
        displayText = '0';
        inputState = '';
        num1 = 0;
        num2 = 0;
        operand = '';
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == 'x' ||
          buttonText == '/') {
        num1 = double.parse(displayText);
        operand = buttonText;
        inputState = '$num1 $operand';
        displayText = '0';
      } else if (buttonText == '=') {
        num2 = double.parse(displayText);
        double result;
        if (operand == '+') {
          result = num1 + num2;
        } else if (operand == '-') {
          result = num1 - num2;
        } else if (operand == 'x') {
          result = num1 * num2;
        } else if (operand == '/') {
          result = num1 / num2;
        } else {
          result = num2;
        }

        // Remove the trailing .0 if it exists
        displayText = result.toString().replaceAll(RegExp(r'\.0$'), '');
        inputState = '$num1 $operand $num2 = $displayText';
        operand = '';
      } else {
        if (displayText == '0') {
          displayText = buttonText;
        } else {
          displayText += buttonText;
        }
        inputState += buttonText;
      }
    });
  }

  Widget buildButton(String buttonText, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
            textStyle: const TextStyle(fontSize: 24.0),
            backgroundColor: color,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  inputState,
                  style: const TextStyle(fontSize: 24.0, color: Colors.grey),
                ),
                Text(
                  displayText,
                  style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(children: [
                    buildButton("7", Colors.green),
                    buildButton("8", Colors.green),
                    buildButton("9", Colors.green),
                    buildButton("/", Colors.lightGreen),
                  ]),
                ),
                Expanded(
                  child: Row(children: [
                    buildButton("4", Colors.green),
                    buildButton("5", Colors.green),
                    buildButton("6", Colors.green),
                    buildButton("x", Colors.lightGreen),
                  ]),
                ),
                Expanded(
                  child: Row(children: [
                    buildButton("1", Colors.green),
                    buildButton("2", Colors.green),
                    buildButton("3", Colors.green),
                    buildButton("-", Colors.lightGreen),
                  ]),
                ),
                Expanded(
                  child: Row(children: [
                    buildButton(".", Colors.green),
                    buildButton("0", Colors.green),
                    buildButton("00", Colors.green),
                    buildButton("+", Colors.lightGreen),
                  ]),
                ),
                Expanded(
                  child: Row(children: [
                    buildButton("CLEAR", Colors.lightGreen),
                    buildButton("=", Colors.lightGreen),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
