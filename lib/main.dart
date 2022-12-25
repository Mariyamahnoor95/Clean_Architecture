import 'package:clean_architecture/feature/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/weather/presentation/bloc/weather_bloc.dart';
import 'feature/weather/presentation/pages/weather_page.dart';
import 'injection_container.dart' as di;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const NumberTriviaPage(),
    );
  }
}
