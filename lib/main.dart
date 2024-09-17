import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator - Habiba Ghazi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculator - Habiba Ghazi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _expression = '';
  String _result = '';

  void _onPressed(String text) {
  setState(() {
    if (text == 'C') {
      _expression = '';
      _result = '';
    } else if (text == '=') {
      try {
        // **New Check**: Detect if the user is dividing by zero
        if (_expression.contains('/0')) {
          _result = ' Cannot divide by zero';  // Display this message instead of calculating
        } else {
          final expression = Expression.parse(_expression);
          const evaluator = ExpressionEvaluator();
          final result = evaluator.eval(expression, {});
          _result = ' = $result';  // Continue if no division by zero is found
        }
      } catch (e) {
        _result = ' Error';  // Handle other errors (e.g., invalid expressions)
      }
    } else {
      _expression += text;
    }
  });
}

  Widget _buildButton(String text) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => _onPressed(text),
        child: Text(text, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                '$_expression$_result',
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              Row(
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                ],
              ),
              Row(
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                ],
              ),
              Row(
                children: [
                  _buildButton('0'),
                  _buildButton('C'),
                  _buildButton('='),
                  _buildButton('+'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

