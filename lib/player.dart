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
  final Duration currentDuration; // Current playback time
  final Duration totalDuration; // Total song duration
  final Function onSeek; // Callback for seeking

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
    required this.currentDuration,
    required this.totalDuration,
    required this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    final bool favorite = isFavorite[currentSongIndex] ?? false;

    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Timeline Slider with time markers
          Row(
            children: [
              Text(
                _formatDuration(currentDuration),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              Expanded(
                child: Slider(
                  value: currentDuration.inSeconds.toDouble(),
                  max: totalDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    onSeek(Duration(seconds: value.toInt())); // Notify parent widget of seek
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                ),
              ),
              Text(
                _formatDuration(totalDuration),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 5),
          // Song details and control buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentSongTitle.length > 15
                        ? '${currentSongTitle.substring(0, 15)}...'
                        : currentSongTitle,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    currentSongArtist.isEmpty == true? "Unknown Artist":currentSongArtist,
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
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds % 60);
    return '$minutes:$seconds';
  }
}

