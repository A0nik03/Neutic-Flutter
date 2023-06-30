import 'package:flutter/material.dart';
import 'home_screen.dart';

void main(){
  runApp(const Neutic());
}

class Neutic extends StatefulWidget {
  const Neutic({Key? key}) : super(key: key);

  @override
  State<Neutic> createState() => _NeuticState();
}

class _NeuticState extends State<Neutic> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
