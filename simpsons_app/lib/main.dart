import 'package:flutter/material.dart';
import 'package:simpsons_app/pages/launch_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Flutter uygulamasının başlatılması sağlandı.
  await Firebase.initializeApp(  // Firebase'in başlatılmasını ve yapılandırılmasını sağlandı.
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LaunchScreen(),  // Uygulamanın ana ekranını LaunchScreen olarak ayarla.
    );
  }
}

