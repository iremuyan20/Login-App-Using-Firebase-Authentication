import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simpsons_app/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;
  String? surname;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser; //Oturum açmış kullanıcıyı temsil eden bir User nesnesi döndürür.
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {  //Name ve surname değişkenlerini güncellemek için setState fonksiyonu kullanıldı.
        name = userDoc['name'];
        surname = userDoc['surname'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Spacer(),
            if (name != null && surname != null)
              Center(
                child: Text(
                  "$name $surname",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 30,
                    fontFamily: "Lora", //Font family "Lora" olarak ayarlandı
                  ),
                ),
              ),
            Spacer() ,
            Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(double.infinity, 60),
                    backgroundColor: Colors.yellow,

                  ),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Lora"
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
