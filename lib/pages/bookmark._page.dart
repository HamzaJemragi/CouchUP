import 'package:couchup/model/movie.dart';
import 'package:couchup/model/db_helper.dart';
// import 'package:couchup/pages/home_page.dart';
import 'package:flutter/material.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<Movie> _bookmarkedMovies = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarkedMovies();
  }

  _loadBookmarkedMovies() async {
    final databaseHelper = DatabaseHelper();
    final bookmarkedMovies = await databaseHelper.getBookmarkedMovies();
    setState(() {
      _bookmarkedMovies = bookmarkedMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarked Movies'),
      ),
      body: _bookmarkedMovies.isEmpty
          ? Center(
              child: Text('No bookmarked movies'),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1.5,
              ),
              itemCount: _bookmarkedMovies.length,
              itemBuilder: (context, index) {
                return MovieElement(_bookmarkedMovies[index]);
              },
            ),
    );
  }
}

class MovieElement extends StatelessWidget {
  final Movie movie;

  MovieElement(this.movie);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(movie.backdrop_path),
          Text(movie.title),
          Text(movie.release_date),
        ],
      ),
    );
  }
}