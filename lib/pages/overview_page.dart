import 'package:couchup/model/db_helper.dart';
import 'package:flutter/material.dart';
import '../model/movie.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({super.key, required this.movie});

  final Movie movie;

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  bool _toggleProgressed = false;
  final _databaseHelper = DatabaseHelper();

  Future<void> toggleProgressed() async {
  if (_toggleProgressed) {
    // Remove movie from bookmarks
    await _databaseHelper.deleteBookmarkMovie(widget.movie.id);
  } else {
    // Add movie to bookmarks
    await DatabaseHelper.addBookmarkedMovie(widget.movie);
  }
  setState(() {
    _toggleProgressed = !_toggleProgressed;
  });
}

  @override
  Widget build(BuildContext context) {
    // Get the screen height for responsive image sizing
    // final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // AppBar with a back button
      appBar: AppBar(
        title: Text(widget.movie.title), // Display movie title in AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen (homepage in this case)
            Navigator.pop(context);
          },
        ),
      ),
      // Body of the page, arranged in a Column
      body: SingleChildScrollView(
        // Use SingleChildScrollView to prevent overflow if content is long
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the start (left)
          children: [
            // Movie Image
            Image.network(
              widget.movie.backdrop_path,
              width: double.infinity, // Take full width
              // height: screenHeight * 0.5, // Take 30% of screen height
              fit: BoxFit.fill, // Cover the allocated space
              // Add a placeholder or error widget in case the image fails to load
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  // height: screenHeight * 0.3,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  // height: screenHeight * 0.3,
                  color: Colors.grey[300],
                  child: Center(
                    child: CircularProgressIndicator(
                      value:
                          loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                    ),
                  ),
                );
              },
            ),
            // Movie Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.movie.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Movie Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.movie.overview,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            // Add some bottom padding for better scrolling experience
            const SizedBox(height: 16.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Release Date: ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.movie.release_date,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            // Add some bottom padding for better scrolling experience
            const SizedBox(height: 16.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Popularity: ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.movie.popularity.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            // Add some bottom padding for better scrolling experience
            const SizedBox(height: 16.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Vote Average: ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.movie.vote_average.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            // Add some bottom padding for better scrolling experience
            const SizedBox(height: 16.0),
            Row(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Vote Count: ",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        widget.movie.vote_count.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(),
                ), // This will take up the remaining space
                FloatingActionButton(
                  onPressed: _toggleProgressed ? null: toggleProgressed, // Call the function when pressed
                  child: const Icon(Icons.bookmark, color: Colors.white),
                  backgroundColor: Colors.black,
                ),
              ],
            ),
            // Add some bottom padding for better scrolling experience
            const SizedBox(height: 16.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     FloatingActionButton(onPressed: () {}, child: const Icon(Icons.bookmark, color: Colors.white), backgroundColor: Colors.black),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
