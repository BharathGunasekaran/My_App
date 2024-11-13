import 'package:flutter/material.dart';

class BottomPlayerBar extends StatelessWidget {
  final Map<int, bool> isFavorite;
  final int currentSongIndex;
  final bool isPlaying;
  final Function toggleFavorite;
  final Function playPause;
  final Function nextSong;
  final Function previousSong;
  final String currentSongTitle;
  final String currentSongArtist;

  const BottomPlayerBar({
    super.key,
    required this.isFavorite,
    required this.currentSongIndex,
    required this.isPlaying,
    required this.toggleFavorite,
    required this.playPause,
    required this.nextSong,
    required this.previousSong,
    required this.currentSongTitle,
    required this.currentSongArtist,
  });

  @override
  Widget build(BuildContext context) {
    final bool favorite = isFavorite[currentSongIndex] ?? false;

    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentSongTitle,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                currentSongArtist,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.white),
                onPressed: () {
                  previousSong();
                },
              ),
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {
                  playPause();
                },
              ),
              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.white),
                onPressed: () {
                  nextSong();
                },
              ),
              IconButton(
                icon: Icon(
                  favorite ? Icons.favorite : Icons.favorite_border,
                  color: favorite ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  toggleFavorite(currentSongIndex);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

