import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:simpsons_app/pages/login_page.dart';



class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Image.asset("assets/launch_gif.gif"),
      ),
      nextScreen: const LoginPage(), //Başlangıç ekranından sonra açılacak olan ekran belirtildi.
      backgroundColor: Colors.black,
      duration: 5000, //Animasyonun toplam süresi 5 saniye olarak ayarlandı.
      splashIconSize: 300,
    );
  }
}
