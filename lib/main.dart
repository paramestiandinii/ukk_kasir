import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Donuts Rush"),
              
              ],
        ),
      ),
      body: Container(
         padding: const EdgeInsets.symmetric(horizontal: 20), 
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 200,
              width: 900,
              child: Image.network(
                  "https://media.istockphoto.com/id/1412571593/id/vektor/clipart-logo-toko-roti-yang-digambar-tangan-sederhana.jpg?s=170667a&w=0&k=20&c=dxO__dvopf1m1rMrmlyrsUEaEnwtYPcMH3Cgye0wZIk=",
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                width: 1000,
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),

              ),
              Container(
                width: 1000,
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "UserName",
                    icon: Icon(Icons.person, color: Colors.black, size: 30,),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.only(left: 10, right: 10), // Menambahkan padding kanan
                  ),
                ),
              ),
              Container(
                width: 1000,
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  obscureText: true, //menyembunyikan pasword
                  decoration: InputDecoration(
                    labelText: "Password",
                    icon: Icon(Icons.vpn_key_sharp, color: Colors.black, size: 30,),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.only(left: 10, right: 5), // Menambahkan padding kanan
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),  // Menambahkan jarak atas
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Login", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    fixedSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Membuat sudut tombol melengkung
                    ),
                  )
                )
              )
        ]
      ),
    ),
    ),
    );
  }
}