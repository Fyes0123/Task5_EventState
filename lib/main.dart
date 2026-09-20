import 'package:flutter/material.dart';

void main() {
  runApp(const MovieBox());
}

class MovieBox extends StatelessWidget {
  const MovieBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieBox',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const Beranda(),
    );
  }
}

// SCREEN 1 - BERANDA
class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  final List<Map<String, String>> film = [
    {
      'judul': 'Interstellar',
      'tahun': '2014',
      'genre': 'Sci-Fi • Adventure',
      'sinopsis':
          'Sebuah perjalanan luar angkasa untuk mencari planet baru yang dapat menjadi tempat tinggal manusia.',
    },
    {
      'judul': 'Spider-Man',
      'tahun': '2018',
      'genre': 'Animation • Action',
      'sinopsis':
          'Miles Morales menemukan kekuatan baru dan belajar menjadi Spider-Man dengan caranya sendiri.',
    },
    {
      'judul': 'The Hunger Games',
      'tahun': '2012',
      'genre': 'Action • Drama',
      'sinopsis':
          'Katniss Everdeen mengikuti permainan berbahaya demi menyelamatkan keluarganya.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MovieBox',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: film.length,
        itemBuilder: (context, index) {
          final item = film[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailFilm(
                      judul: item['judul']!,
                      tahun: item['tahun']!,
                      genre: item['genre']!,
                      sinopsis: item['sinopsis']!,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.movie,
                        size: 40,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['judul']!,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(item['tahun']!),

                          const SizedBox(height: 4),

                          Text(
                            item['genre']!,
                            style: TextStyle(
                              color: Colors.grey.shade400,
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              SizedBox(width: 4),
                              Text('Tap untuk melihat detail'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// SCREEN 2 - DETAIL FILM
class DetailFilm extends StatefulWidget {
  final String judul;
  final String tahun;
  final String genre;
  final String sinopsis;

  const DetailFilm({
    super.key,
    required this.judul,
    required this.tahun,
    required this.genre,
    required this.sinopsis,
  });

  @override
  State<DetailFilm> createState() => _DetailFilmState();
}

class _DetailFilmState extends State<DetailFilm> {
  bool isLiked = false;
  int rating = 0;

  void ubahLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  void pilihRating(int nilai) {
    setState(() {
      rating = nilai;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Film'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // Poster film
            Center(
              child: Container(
                width: 160,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.movie,
                  size: 80,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.judul,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${widget.tahun} • ${widget.genre}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Container pastel untuk sinopsis
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                widget.sinopsis,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Tombol Like
            Center(
              child: ElevatedButton.icon(
                onPressed: ubahLike,
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                ),
                label: Text(
                  isLiked ? 'Liked' : 'Like',
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Rating
            const Center(
              child: Text(
                'Beri Rating Film',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) {
                    final nomorBintang = index + 1;

                    return IconButton(
                      onPressed: () {
                        pilihRating(nomorBintang);
                      },
                      icon: Icon(
                        nomorBintang <= rating
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 34,
                      ),
                    );
                  },
                ),
              ),
            ),

            Center(
              child: Text(
                rating == 0
                    ? 'Belum memberikan rating'
                    : 'Rating kamu: $rating/5',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}