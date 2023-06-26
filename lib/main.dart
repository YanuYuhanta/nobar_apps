import 'api.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'movie_detail.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //menghilangkan debug label
      debugShowCheckedModeBanner: false,
      title: 'Nobar Apps',
      home: HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //membuat appbar dengan background hitam dan font berwarna putih
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Center(
          child: Text(
            "Apk Nobar",style: TextStyle(
              color: Colors.white60

            ),
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        // pada futureBuilder akan mengirim permintaan http ke API Tmdb untuk mendapatkan
        // daftar film popular.
        future: TmdbApi.getPopularMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //ListView.Builder digunakan untuk menampilkan daftar film yang diperoleh dari api
            return ListView.builder(
              // itemcount digunakan untuk mengatur panjang data yang ingin ditampilkan
              itemCount: snapshot.data!.length,
              //itembuilder merupakan bentuk widget yang akan ditampilkan
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                final posterPath = movie['poster_path'];
                final title = movie['title'];
                final imageUrl = 'https://image.tmdb.org/t/p/w500$posterPath';

                return Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: ListTile(
                    //menampilkan gambar
                    leading: CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: 100,
                    ),
                    // menampilkan judul
                    title: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // properti onTap akan menavigasi ke halaman detail film saat user mengklik item film.
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(movie: movie),
                        ),
                      );
                    },
                  ),
                );
              },
            );
            // else untuk menampilkan error jika data tidak dapat dimuat.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}