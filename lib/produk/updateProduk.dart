import 'package:flutter/material.dart';
import 'package:kasir/produk/insertProduk.dart';
import 'package:kasir/produk/indexProduk.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProduk extends StatefulWidget {
  final int produkID;

  EditProduk({Key? key, required this.produkID}) : super(key: key);

  @override
  State<EditProduk> createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  final _NamaProduk = TextEditingController();
  final _Harga = TextEditingController();
  final _Stok = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProdukData();
  }

  Future<void> _loadProdukData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await Supabase.instance.client
          .from('produk')
          .select()
          .eq('produkID', widget.produkID)
          .single();

      if (data == null) {
        throw Exception('Data Produk tidak ditemukan');
      }

      setState(() {
        _NamaProduk.text = data['NamaProduk'] ?? '';
        _Harga.text = (data['Harga'] ?? 0).toString();
        _Stok.text = (data['Stok'] ?? 0).toString();
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data Produk: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateProduk() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await Supabase.instance.client.from('produk').update({
          'NamaProduk': _NamaProduk.text,
          'Harga': int.tryParse(_Harga.text) ?? 0, // Konversi String ke int
          'Stok': int.tryParse(_Stok.text) ?? 0,
        }).eq('produkID', widget.produkID);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data Produk berhasil diperbarui')),
        );
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui data Produk: $e')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Produk'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _NamaProduk,
                      decoration: InputDecoration(
                        labelText: 'Nama Produk',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama Produk wajib diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _Harga,
                      decoration: InputDecoration(
                        labelText: 'Harga',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harga wajib diisi';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Harga harus berupa angka';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _Stok,
                      decoration: InputDecoration(
                        labelText: 'Stok',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Stok wajib diisi';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Stok hanya boleh berisi angka';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: updateProduk,
                      child: Text('Update'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
