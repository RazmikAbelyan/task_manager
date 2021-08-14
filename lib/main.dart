import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/abely/AndroidStudioProjects/flutter_bloc_example/lib/screen/firebase_page.dart';
import 'package:flutter_bloc_example/screen/auth_screen.dart';
import 'package:flutter_bloc_example/screen/task_detail_screen.dart';
import 'package:flutter_bloc_example/screen/user_tasks.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String , WidgetBuilder>{
        '/authScreen' : (context)=> AuthScreen(),
        '/firebasePage' : (context)=> FirebasePage(),
        '/taskDetailScreen' : (context) => TaskDetailScreen(),
      },
      home:  AuthScreen(),

    );
  }
}
