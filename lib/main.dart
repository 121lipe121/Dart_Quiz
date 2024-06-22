// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'menu.dart'; // Importando o arquivo menu.dart
import 'temas.dart'; // Importando o arquivo temas.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz para Programadores',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: QuizScreen(),
      routes: {
        '/temas': (context) => const TemasScreen(), // Definindo a rota para TemasScreen
        // '/teste': (context) => const 
      },
    );
  }
}
