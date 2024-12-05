import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/modules/todochecklistPage/provider/todo_provider.dart';
import 'package:todoapp/splash_screen_view.dart';

void main() {
  runApp(
    
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider()),

        
      ],
         
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen()
    );
  }
}
