import 'package:flutter/material.dart';
import 'package:kasir/home_page.dart';

void main() {
  runApp(RegistrasiPage());
}

class RegistrasiPage extends StatefulWidget {
  RegistrasiPage({super.key});

  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Registrasi Pengguna',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://png.pngtree.com/thumb_back/fh260/background/20210116/pngtree-download-simple-wallpaper-donuts-image_533935.jpg",
              ),
              fit: BoxFit.cover, // This will make the image cover the whole screen
            ),
          ),
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,  // Menggunakan GlobalKey untuk validasi form
          child: Column(
            children: [
              SizedBox(height: 20),
              // Nama Lengkap - Wajib Diisi
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              
              // Email - Tidak Wajib Tapi Cek Format
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password harus diisi';
                  } 
                  return null;
                },
              ),
              SizedBox(height: 20),
              
              // Password - Wajib Diisi
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Role",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Role harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Tombol Sign Up
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Jika validasi sukses, tampilkan snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Pendaftaran berhasil!')),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    ); // Kembali ke halaman sebelumnya
                  }
                },
                child: Text('Registrasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
