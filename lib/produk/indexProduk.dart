import 'package:flutter/material.dart';
import 'package:kasir/produk/indexProduk.dart';
import 'package:kasir/produk/insertProduk.dart';
import 'package:kasir/produk/updateProduk.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProdukTab extends StatefulWidget {
  @override
  _ProdukTabState createState() => _ProdukTabState();
}

class _ProdukTabState extends State<ProdukTab> {
  List<Map<String, dynamic>>produk = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProduk();
  }

  Future<void> fetchProduk() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response =
          await Supabase.instance.client.from('produk').select();
      setState(() {
       produk = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetchingProduk: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteProduk(int id) async {
    try {
      await Supabase.instance.client
          .from('produk')
          .delete()
          .eq('produkID', id);
      fetchProduk();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produk berhasil dihapus')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deletingProduk: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          :produk.isEmpty
              ? Center(
                  child: Text(
                    'Tidak ada Produk',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  padding: EdgeInsets.all(10),
                  itemCount:produk.length,
                  itemBuilder: (context, index) {
                    final langgan =produk[index];
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             langgan['NamaProduk']?.toString() ??
                                  'Produk tidak tersedia',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              langgan['Harga']?.toString() ??
                              'Harga tidak tersedia',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              langgan['Stok']?.toString() ??
                              'Stok habis',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit,
                                      color: Colors.blueAccent),
                                  onPressed: () {
                                    final ProdukID =
                                        langgan['produkID'] ?? 0;
                                    if (ProdukID != 0) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditProduk(
                                             produkID:ProdukID),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'IDProduk tidak valid')),
                                      );
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('HapusProduk'),
                                          content: Text(
                                              'Apakah Anda yakin ingin menghapus Produk ini?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Batal'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                deleteProduk(
                                                    langgan['produkID']);
                                                Navigator.pop(context);
                                              },
                                              child: Text('Hapus'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProduk()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
