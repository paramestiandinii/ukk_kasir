import 'package:flutter/material.dart';
import 'package:kasir/pelanggan/indexPelanggan.dart';
import 'package:kasir/pelanggan/insertPenjualan.dart';
import 'package:kasir/pelanggan/updatePenjualan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PelangganTab extends StatefulWidget {
  @override
  _PelangganTabState createState() => _PelangganTabState();
}

class _PelangganTabState extends State<PelangganTab> {
  List<Map<String, dynamic>> pelanggan = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPelanggan();
  }

  Future<void> fetchPelanggan() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response =
          await Supabase.instance.client.from('pelanggan').select();
      setState(() {
        pelanggan = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching pelanggan: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deletePelanggan(int id) async {
    try {
      await Supabase.instance.client
          .from('pelanggan')
          .delete()
          .eq('PelangganID', id);
      fetchPelanggan();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pelanggan berhasil dihapus')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting pelanggan: $e')),
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
          : pelanggan.isEmpty
              ? Center(
                  child: Text(
                    'Tidak ada pelanggan',
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
                  itemCount: pelanggan.length,
                  itemBuilder: (context, index) {
                    final langgan = pelanggan[index];
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
                              langgan['NamaPelanggan'] ??
                                  'Pelanggan tidak tersedia',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              langgan['Alamat'] ?? 'Alamat tidak tersedia',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              langgan['Nomor Telepon'] ?? 'Tidak tersedia',
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
                                    final pelangganID =
                                        langgan['PelangganID'] ?? 0;
                                    if (pelangganID != 0) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditPelanggan(
                                              PelangganID: pelangganID),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'ID pelanggan tidak valid')),
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
                                          title: Text('Hapus Pelanggan'),
                                          content: Text(
                                              'Apakah Anda yakin ingin menghapus pelanggan ini?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Batal'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                deletePelanggan(
                                                    langgan['PelangganID']);
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
            MaterialPageRoute(builder: (context) => AddPelanggan()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
