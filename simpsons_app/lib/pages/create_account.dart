import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simpsons_app/firebase_auth_services.dart';
import 'package:simpsons_app/pages/home_page.dart';
import 'package:simpsons_app/pages/login_page.dart';
import 'package:simpsons_app/form_container_widget.dart';
import 'package:simpsons_app/toast.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final FirebaseAuthService _auth = FirebaseAuthService(); //Authentication servisi başlatıldı.

  TextEditingController _nameController = TextEditingController();  //Text fieldları kontrol etmek için TextEditingController kullanıldı.
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {  //dispose yöntemi ile kaynaklar serbest bırakıldı.
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;  //Responsive bir dizayn olması ve türlü ekranlarda orantılı çalışma yapmak için w ve h atandı.
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea( //Arayüzün kesilmiş alanlara denk gelmemesi sağlandı.
        child: Column(
          children: [
            Expanded(  //Belirlenen eksen boyunca tüm boş alanı dolduruldu.
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: h / 15),
                      Text(
                        "Create Account",
                        style: TextStyle(
                          fontFamily: "Lora",
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                        ),
                      ),
                      SizedBox(height: 20),
                      FormContainerWidget(
                        controller: _nameController,
                        hintText: "Name",
                        isPasswordField: false,
                      ),
                      SizedBox(height: 10),
                      FormContainerWidget(
                        controller: _surnameController,
                        hintText: "Surname",
                        isPasswordField: false,
                      ),
                      SizedBox(height: 10),
                      FormContainerWidget(
                        controller: _emailController,
                        hintText: "Email",
                        isPasswordField: false,
                      ),
                      SizedBox(height: 10),
                      FormContainerWidget(
                        controller: _passwordController,
                        hintText: "Password",
                        isPasswordField: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0), //Padding ve EdgeInsets.all ile her eksenden boşluk bırakmamız sağlandı.
              child: Column(
                children: [
                  GestureDetector( //Kullanıcı etkileşimi algılama ve işleme için kullanılan widget.
                    onTap: _signUp,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: isSigningUp
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                          "Create Account",
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
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(double.infinity, 60),
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontFamily: "Lora",
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String name = _nameController.text;
    String surname = _surnameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': name,
        'surname': surname,
        'email': email,
      });

      setState(() {
        isSigningUp = false;
      });

      showToast(message: "User is successfully created");  //Uygulama içinde bir kısa mesaj göstermek için kullanıldı.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      setState(() {
        isSigningUp = false;
      });
      showToast(message: "Some error happened");
    }
  }
}

