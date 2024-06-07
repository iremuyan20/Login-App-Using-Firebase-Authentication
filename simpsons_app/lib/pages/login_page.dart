import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simpsons_app/colors.dart';
import 'package:simpsons_app/pages/create_account.dart';
import 'package:simpsons_app/firebase_auth_services.dart';
import 'package:simpsons_app/form_container_widget.dart';
import 'package:simpsons_app/toast.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  bool _rememberMe = true;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(  // Arkaplan görüntüsü ve diğer arayüz öğelerini üst üste binen widgetlar içinde tutar.
        alignment: Alignment.bottomCenter,  // Çocuk widgetlar alt ortaya hizalandı.
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration( // Dekorasyon özellikleri belirtildi.
              image: DecorationImage(
                image: AssetImage("assets/Background.png"),
                fit: BoxFit.cover, // Görüntünün ekrana sığacak şekilde boyutlandırılması sağlandı.
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: h / 2.5,
                child: Image.asset("assets/logo.png"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormContainerWidget(
                  controller: _emailController, // Email alanı denetleyicisi
                  hintText: "Email Address", // Email alanı için ipucu metni.
                  isPasswordField: false,
                ),
                SizedBox(
                  height: 20,
                ),
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Colorsfromirem.deepgreenfromirem,
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4), // Kenar yuvarlaklığı ayarlandı.
                            side: BorderSide(color: Colors.grey),
                          ),
                        ),

                        Text("Remember me", style: TextStyle(
                          fontFamily: "Lora",
                            color: Colors.grey,)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {

                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontFamily: "Lora",
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    _signIn();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isSigning
                          ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        "Login Now",
                        style: TextStyle(
                          fontFamily: "Lora",
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontFamily:"Lora",
                          fontSize:17,
                          color: Colorsfromirem.greyfromirem),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector( // Dokunma algılayıcı eklendi.
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAccountPage()),
                              (route) => false, // Mevcut sayfayı kapatma koşulunu belirlendi.
                        );
                      },
                      child: Text(
                        "Create one",
                        style: TextStyle(
                          fontSize:17,
                          fontFamily: "Lora",
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10, //Yükseklik olarak boşluk bırakıldı
                ),
                Center(
                  child: Container(
                    width: w / 3,
                    height: 4, // Çizginin kalınlığı
                    color: Colorsfromirem.darkgreyfromirem, // Çizginin rengi
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "User is successfully signed in");  //Uygulama içinde bir kısa mesaj göstermek için kullanıldı.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showToast(message: "Some error occurred");
    }
  }
}

