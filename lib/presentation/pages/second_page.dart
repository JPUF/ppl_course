import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: Container(
                width: 380,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.amber),
              )),
              const SizedBox(height: 16),
              Expanded(
                  child: Container(
                width: 380,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.deepPurpleAccent),
                child: Lottie.asset(
                    'assets/loading_anim.json',
                  repeat: true,
                  animate: true
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
