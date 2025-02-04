import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailProdukTab extends StatefulWidget {
  final Map<String, dynamic>? produk;
  DetailProdukTab({Key? key, this.produk}) : super(key: key);

  @override
  State<DetailProdukTab> createState() => _DetailPenjualanTabState();
}

class _DetailPenjualanTabState extends State<DetailProdukTab> {
  int jumlahPesanan = 0;
  int totalHarga = 0;
  int stokAwal = 0;

  @override
  void initState() {
    super.initState();
    stokAwal = widget.produk?['Stok'] ?? 0; // Tambahkan null check di sini
  }

  // Fungsi untuk memperbarui jumlah pesanan
  void updateJumlahPesanan(int harga, int delta) {
    setState(() {
      if (jumlahPesanan + delta <= stokAwal && jumlahPesanan + delta >= 0) {
        jumlahPesanan += delta;
        totalHarga = jumlahPesanan * harga;
      }
    });
  }

  // Fungsi untuk menyimpan data ke tabel detailpenjualan
  Future<void> insertDetailPenjualan(
    int produkID, int penjualanID, int jumlahPesanan, int totalHarga) async {
    final supabase = Supabase.instance.client;

     try {
      // Validasi nilai input sebelum mengirim permintaan ke Supabase
      if (produkID <= 0 || penjualanID <= 0 || jumlahPesanan <= 0 || totalHarga <= 0) {
        throw Exception('Data input tidak valid.');
      }

      // Insert data ke tabel detailpenjualan
      final response = await supabase.from('detailpenjualan').insert({
        'ProdukID': produkID,
        'PenjualanID': penjualanID,
        'JumlahProduk': jumlahPesanan,
        'SubTotal': totalHarga,
      });

      if (response.error != null) {
        throw Exception(response.error!.message);
      }

      // Update stok produk setelah pesanan berhasil
      int stokAkhir = stokAwal - jumlahPesanan;
      final updateResponse = await supabase
          .from('produk')
          .update({'Stok': stokAkhir}).eq('ProdukID', produkID);

      if (updateResponse.error != null) {
        throw Exception(updateResponse.error!.message);
      }

      // Tampilkan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pesanan berhasil disimpan!')),
      );

      // Kembali ke halaman sebelumnya
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error menyimpan pesanan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final produk = widget.produk;
    if (produk == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Detail Produk')),
        body: Center(
          child: Text('Data produk tidak ditemukan', style: TextStyle(fontSize: 18)),
        ),
      );
    }

    final int harga = produk['Harga'] ?? 0;
    final int produkID = produk['produkID'] ?? 0;
    final int penjualanID = 1; // HARUS diganti dengan ID Penjualan yang valid

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            elevation: 4,
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama Produk: ${produk['NamaProduk'] ?? 'Tidak Tersedia'}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Text('Harga: $harga', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 16),
                  Text('Stok: $stokAwal', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          updateJumlahPesanan(harga, -1);
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text(
                        '$jumlahPesanan',
                        style: TextStyle(fontSize: 20),
                      ),
                      IconButton(
                        onPressed: () {
                          updateJumlahPesanan(harga, 1);
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Tutup', style: TextStyle(fontSize: 20)),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          if (jumlahPesanan > 0) {
                            await insertDetailPenjualan(produkID, penjualanID, jumlahPesanan, totalHarga);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Jumlah pesanan harus lebih dari 0')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade200,
                        ),
                        child: Text('Pesan ($totalHarga)', style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
