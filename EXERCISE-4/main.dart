import 'package:flutter/material.dart';

import 'joke.dart';

Color appColor = Colors.green[300] as Color;

void main() => runApp(MaterialApp(
      home: JokeApp(),
    ));

// The parent remembers which joke is the favorite
class JokeApp extends StatefulWidget {
  const JokeApp({super.key});

  @override
  State<JokeApp> createState() => _JokeAppState();
}

class _JokeAppState extends State<JokeApp> {
  int? favoriteIndex; // null means no favorite yet

  void setFavorite(int index) {
    setState(() {
      if (favoriteIndex == index) {
        favoriteIndex = null; // click again to remove
      } else {
        favoriteIndex = index; // new favorite
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text("Favorite Jokes"),
      ),
      body: ListView(
        children: [
          for (var i = 0; i < jokes.length; i++)
            FavoriteCard(
              joke: jokes[i],
              isFavorite: favoriteIndex == i,
              onFavoriteClick: () => setFavorite(i),
            ),
        ],
      ),
    );
  }
}

// The card only shows the joke and tells the parent when the heart is clicked
class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    super.key,
    required this.joke,
    required this.isFavorite,
    required this.onFavoriteClick,
  });

  final Joke joke;
  final bool isFavorite;
  final VoidCallback onFavoriteClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: .5, color: Colors.grey),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  joke.title,
                  style: TextStyle(
                      color: appColor, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10.0),
                Text(joke.description),
              ],
            ),
          ),
          IconButton(
            onPressed: onFavoriteClick,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}