import 'package:flutter/material.dart';

//Kelas MovieDetailPage: Kelas ini merupakan StatelessWidget yang bertanggung jawab untuk
// menampilkan halaman detail film. Konstruktor menerima argumen movie yang merupakan Map<String, dynamic>
// berisi informasi film yang akan ditampilkan.
class MovieDetailPage extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    // kode dibawah digunakan untuk mendapatkan URL data pada API TMDB
    final posterPath = movie['poster_path'];
    final title = movie['title'];
    final imageUrl = 'https://image.tmdb.org/t/p/w342$posterPath';

    // komponen Scaffold sebagai kerangka utama halaman dengan judul di AppBar dan tampilan utama di dalam body.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(title, style: const TextStyle(color: Colors.white60),),
      ),
      body: ListView(
        children: [
          // properti container akan menampilkan gambar poster film
          Container(
            width: double.infinity,
            // height akan mengatur tinggi gambar
            height: MediaQuery.of(context).size.height * 0.81,
            decoration: BoxDecoration(
              image: DecorationImage(
                // networkImage digunakan untuk mengambil gambar dari api
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // menampilkan judul film
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 33,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          //menampilkan tanggal rilis film
          Text(
            'Release Date: ${movie['release_date']}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8,),
          // menampilkan overview film
          Text(movie['overview'], textAlign: TextAlign.center,),
          const SizedBox( height: 5,)
        ],
      ),
    );
  }
}