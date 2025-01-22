import 'package:flutter/material.dart';
import 'package:kasir/pelanggan/index_pelanggan.dart';
import 'package:kasir/produk/indexProduk.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Home Page"),
            backgroundColor: Color.fromARGB(255, 250, 189, 209),
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Membuka drawer
                  },
                );
              },
            ),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.drafts), text: 'Detail Penjualan'),
                Tab(icon: Icon(Icons.person_2_sharp), text: 'Customer'),
                Tab(icon: Icon(Icons.shopping_bag), text: 'Produk'),
                Tab(icon: Icon(Icons.shopping_cart), text: 'Penjualan'),
              ],
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 250, 189, 209), // Warna latar belakang DrawerHeader
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 40, color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Paramesti Andini',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Text(
                        'paramestixpplg1@gmail.com',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context); // Menutup drawer
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Home selected')),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.pop(context); // Menutup drawer
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Settings selected')),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.pop(context); // Menutup drawer
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logout selected')),
                    );
                  },
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://png.pngtree.com/thumb_back/fh260/background/20210116/pngtree-download-simple-wallpaper-donuts-image_533935.jpg",
                    ),
                    fit: BoxFit.cover, // Membuat gambar menutupi seluruh layar
                  ),
                ),
              ),
              TabBarView(
                children: [
                  Center(child: Text('Detail Penjualan Content')),
                  PelangganTab(),
                  ProdukTab(),
                  Center(child: Text('Penjualan Content')),
                ],
              ),
            ],
            
          ),
        ),
      ),
    );
  }
}
