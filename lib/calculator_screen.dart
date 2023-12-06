import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0';
  double numOne = 0;
  double numTwo = 0;
  String result = '';
  String finalResult = '';
  String currentOperator = '';
  String previousOperator = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    displayText,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 90,
                    ),
                  ),
                ),
              ],
            ),
            buildButtonRow(['AC', '+/-', '%', '/'], Colors.grey, Colors.black),
            const SizedBox(height: 4),
            buildButtonRow(
                ['7', '8', '9', 'x'], Colors.grey.shade800, Colors.white),
            const SizedBox(height: 4),
            buildButtonRow(
                ['4', '5', '6', '-'], Colors.grey.shade800, Colors.white),
            const SizedBox(height: 4),
            buildButtonRow(
                ['1', '2', '3', '+'], Colors.grey.shade800, Colors.white),
            const SizedBox(height: 4),
            buildButtonRow(['0', '.', '='], Colors.grey.shade800, Colors.white),
          ],
        ),
      ),
    );
  }

  Widget buildButtonRow(
      List<String> buttons, Color buttonColor, Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons
          .map((btnText) => calcButton(btnText, buttonColor, textColor))
          .toList(),
    );
  }

  Widget calcButton(String btnText, Color buttonColor, Color textColor) {
    final List<String> operators = ['+', '-', 'x', '/', '='];
    return ElevatedButton(
      onPressed: () => calculation(btnText),
      style: ElevatedButton.styleFrom(
        shape: btnText == '0' ? const StadiumBorder() : const CircleBorder(),
        backgroundColor:
            operators.contains(btnText) ? Colors.amber.shade700 : buttonColor,
        padding: btnText == '0'
            ? const EdgeInsets.fromLTRB(34, 15, 120, 15)
            : const EdgeInsets.all(30),
      ),
      child: Text(
        btnText,
        style: TextStyle(color: textColor, fontSize: btnText == '0' ? 35 : 30),
      ),
    );
  }

  void calculation(String btnText) {
    switch (btnText) {
      case 'AC':
        clear();
        break;
      case '=':
        if (currentOperator == '=') {
          if (previousOperator.isNotEmpty) {
            finalResult = performOperation(previousOperator);
          }
        } else {
          performPendingOperation();
        }
        break;
      case '+':
      case '-':
      case 'x':
      case '/':
        performPendingOperation();
        currentOperator = btnText;
        break;
      case '%':
        result = (numOne / 100).toString();
        finalResult = doesContainDecimal(result);
        break;
      case '.':
        if (!result.contains('.')) {
          result += '.';
        }
        finalResult = result;
        break;
      case '+/-':
        result = result.startsWith('-') ? result.substring(1) : '-$result';
        finalResult = result;
        break;
      default:
        result += btnText;
        finalResult = result;
    }

    setState(() {
      displayText = finalResult;
    });
  }

  void performPendingOperation() {
    if (numOne != 0) {
      numTwo = tryParseDouble(result);
      finalResult = performOperation(currentOperator);
      previousOperator = currentOperator;
      currentOperator = '';
      result = '';
    } else {
      numOne = tryParseDouble(result);
      result = '';
    }
  }

  String performOperation(String operation) {
    switch (operation) {
      case '+':
        return add();
      case '-':
        return sub();
      case 'x':
        return mul();
      case '/':
        return div();
      default:
        return 'Error';
    }
  }

  String add() => doesContainDecimal((numOne + numTwo).toString());
  String sub() => doesContainDecimal((numOne - numTwo).toString());
  String mul() => doesContainDecimal((numOne * numTwo).toString());
  String div() =>
      numTwo != 0 ? doesContainDecimal((numOne / numTwo).toString()) : 'Error';

  double tryParseDouble(String value) => double.tryParse(value) ?? 0;

  void clear() {
    numOne = 0;
    numTwo = 0;
    result = '';
    finalResult = '0';
    currentOperator = '';
    previousOperator = '';
  }

  String doesContainDecimal(String result) {
    if (result.contains('.')) {
      List<String> splitDecimal = result.split('.');
      if (int.parse(splitDecimal[1]) <= 0) {
        return splitDecimal[0];
      }
    }
    return result;
  }
}
