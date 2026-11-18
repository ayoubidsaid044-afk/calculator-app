import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = '';
  String result = '';

  void onPressed(String value) {
    setState(() {
      if (value == 'C') {
        display = '';
        result = '';
      } else if (value == '⌫') {
        if (display.isNotEmpty) {
          display = display.substring(0, display.length - 1);
        }
      } else if (value == '=') {
        try {
          String finalExp = display.replaceAll('×', '*').replaceAll('÷', '/');
          // حساب بسيط
          result = _calculate(finalExp).toString();
        } catch (e) {
          result = 'خطأ';
        }
      } else {
        display += value;
      }
    });
  }

  double _calculate(String exp) {
    // كنستعملو طريقة بسيطة: كنقسمو على العمليات
    // هادي غير للتجربة، ماشي حساب كامل
    if (exp.contains('+')) {
      var parts = exp.split('+');
      return double.parse(parts[0]) + double.parse(parts[1]);
    }
    if (exp.contains('-')) {
      var parts = exp.split('-');
      return double.parse(parts[0]) - double.parse(parts[1]);
    }
    if (exp.contains('*')) {
      var parts = exp.split('*');
      return double.parse(parts[0]) * double.parse(parts[1]);
    }
    if (exp.contains('/')) {
      var parts = exp.split('/');
      return double.parse(parts[0]) / double.parse(parts[1]);
    }
    return double.parse(exp);
  }

  Widget buildButton(String text, {Color color = Colors.grey}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: () => onPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      appBar: AppBar(
        title: const Text('آلة حاسبة'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    display,
                    style: const TextStyle(fontSize: 36, color: Colors.white),
                  ),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 28, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(children: [
                buildButton('C', color: Colors.red),
                buildButton('⌫', color: Colors.orange),
                buildButton('÷', color: Colors.orange),
                buildButton('×', color: Colors.orange),
              ]),
              Row(children: [
                buildButton('7'),
                buildButton('8'),
                buildButton('9'),
                buildButton('-', color: Colors.orange),
              ]),
              Row(children: [
                buildButton('4'),
                buildButton('5'),
                buildButton('6'),
                buildButton('+', color: Colors.orange),
              ]),
              Row(children: [
                buildButton('1'),
                buildButton('2'),
                buildButton('3'),
                buildButton('=', color: Colors.green),
              ]),
              Row(children: [
                buildButton('0'),
                buildButton('00'),
                buildButton('.'),
                buildButton('%', color: Colors.orange),
              ]),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}