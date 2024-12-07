import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_state.dart';
import '../utils/tmdb_api_helper.dart';
import '../utils/http_helper.dart';

class MovieSelectionScreen extends StatefulWidget {
  const MovieSelectionScreen({super.key});

  @override
  _MovieSelectionScreenState createState() => _MovieSelectionScreenState();
}

class _MovieSelectionScreenState extends State<MovieSelectionScreen> {
  List<Map<String, dynamic>> movies = [];
  int currentIndex = 0;
  int currentPage = 1;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    try {
      final newMovies = await TMDBApiHelper.fetchMovies(currentPage);
      setState(() {
        movies.addAll(newMovies);
        isLoading = false;
        currentPage++;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load movies'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _voteMovie(bool vote) async {
    final appState = Provider.of<AppState>(context, listen: false);
    final sessionId = appState.sessionId!;
    final movie = movies[currentIndex];
    final movieId = movie['id'];

    try {
      final response = await HttpHelper.voteMovie(sessionId, movieId, vote);

      if (response.containsKey('data')) {
        final match = response['data']['match'] as bool;
        if (match) {
          _showMatchDialog(movie);
        }
      }

      setState(() {
        currentIndex++;
      });

      if (currentIndex >= movies.length - 1) {
        await _loadMovies();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to submit vote'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showMatchDialog(Map<String, dynamic> movie) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('It\'s a Match!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(movie['title']),
            const SizedBox(height: 10),
            Image.network(
              '${TMDBApiHelper.imageBaseUrl}${movie['poster_path']}',
              height: 150,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading && movies.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (movies.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Movie Selection'),
          backgroundColor: Colors.blue[900],
        ),
        body: const Center(child: Text('No movies available')),
      );
    }

    final movie = movies[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Selection'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Dismissible(
          key: Key(movie['id'].toString()),
          direction: DismissDirection.horizontal,
          onDismissed: (direction) {
            final vote = direction == DismissDirection.startToEnd;
            _voteMovie(vote);
          },
          background: _buildSwipeBackground(
              Colors.green, Icons.thumb_up, Alignment.centerLeft),
          secondaryBackground: _buildSwipeBackground(
              Colors.red, Icons.thumb_down, Alignment.centerRight),
          child: _buildMovieCard(movie),
        ),
      ),
    );
  }

  Widget _buildSwipeBackground(
      Color color, IconData icon, Alignment alignment) {
    return Container(
      color: color,
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Icon(icon, color: Colors.white, size: 40),
    );
  }

  Widget _buildMovieCard(Map<String, dynamic> movie) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (movie['poster_path'] != null)
            Image.network(
              '${TMDBApiHelper.imageBaseUrl}${movie['poster_path']}',
              height: 400,
            )
          else
            const SizedBox(
              height: 400,
              child: Center(child: Text('No Image')),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie['title'] ?? 'No Title',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Release Date: ${movie['release_date'] ?? 'N/A'}'),
                const SizedBox(height: 8),
                Text('Rating: ${movie['vote_average'] ?? 'N/A'}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
