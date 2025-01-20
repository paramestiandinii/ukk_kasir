import 'package:flutter/material.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Home Page"),
            backgroundColor: Color.fromARGB(255, 250, 189, 209),
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Membuka drawer
                  },
                );
              },
            ),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.dashboard), text: 'Dashboard'),
                Tab(icon: Icon(Icons.shopping_cart), text: 'Orders'),
                Tab(icon: Icon(Icons.person), text: 'Profile'),
              ],
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 250, 189, 209), // Warna latar belakang DrawerHeader
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context); // Menutup drawer
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Home selected')),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context); // Menutup drawer
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Settings selected')),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.pop(context); // Menutup drawer
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logout selected')),
                    );
                  },
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://png.pngtree.com/thumb_back/fh260/background/20210116/pngtree-download-simple-wallpaper-donuts-image_533935.jpg",
                    ),
                    fit: BoxFit.cover, // Membuat gambar menutupi seluruh layar
                  ),
                ),
              ),
              const TabBarView(
                children: [
                  Center(child: Text('Dashboard Content')),
                  Center(child: Text('Orders Content')),
                  Center(child: Text('Profile Content')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
