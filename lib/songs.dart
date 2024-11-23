import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'player.dart'; 

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final List<Map<String, String>> songs = [];
  final Map<int, bool> isFavorite = {};
  final AudioPlayer audioPlayer = AudioPlayer();
  int currentSongIndex = 0;
  bool isPlaying = false;
  Duration currentDuration = Duration.zero;
  Duration totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();

    audioPlayer.positionStream.listen((position) {
      setState(() {
        currentDuration = position;
      });
    });

    audioPlayer.durationStream.listen((duration) {
      setState(() {
        totalDuration = duration ?? Duration.zero;
      });
    });

    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        nextSong();
      }
    });
  }

  String truncateTitle(String title, int maxLength) {
  return title.length > maxLength ? '${title.substring(0, maxLength)}...' : title;
}

Future<void> playPause() async {
  final currentSong = songs[currentSongIndex];

  // Check if the song has a valid path
  if (currentSong.containsKey('path') && currentSong['path']!.isNotEmpty) {
    setState(() {
      isPlaying = !isPlaying;
    });
    if (isPlaying){
      // Set the audio source before playing
      try {
        audioPlayer.setAudioSource(AudioSource.file(currentSong['path']!));
        await audioPlayer.play();
      } catch (e) {
        print('Error playing audio: $e');
      }
    }
    else{
      await audioPlayer.pause();
    } 

  } else {
    print('Invalid song path!');
  }
}

Future<void> nextSong() async {
  setState(() {
    currentSongIndex = (currentSongIndex + 1) % songs.length;
    isPlaying = false; // Ensure previous state is reset
  });

  // Play the next song
  await playPause();
}

Future<void> previousSong() async {
  setState(() {
    currentSongIndex = (currentSongIndex - 1 + songs.length) % songs.length;
    isPlaying = false; // Ensure previous state is reset
  });

  // Play the previous song
  await playPause();
}

Future<void> addSong() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.audio,
    allowMultiple: true,
  );

  if (result != null) {
    bool songAlreadyExists = false;

    setState(() {
      for (var file in result.files) {
        // Check if the song already exists based on its path
        if (songs.any((song) => song['path'] == file.path)) {
          songAlreadyExists = true;
        } else {
          // Add the song if it doesn't already exist
          songs.add({
            'title': file.name,
            'path': file.path ?? '',
          });
        }
      }
    });

    // Show a dialog if any song was already available
    if (songAlreadyExists) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Song Already Exists'),
            content: const Text('Some of the songs you tried to add are already available in your playlist.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}


  void removeSong(int index) {
    setState(() {
      songs.removeAt(index);
      if (currentSongIndex == index && songs.isNotEmpty) {
        currentSongIndex %= songs.length;
      } else if (songs.isEmpty) {
        currentSongIndex = 0;
        isPlaying = false;
      }
    });
  }

  void toggleFavorite(int index) {
    setState(() {
      isFavorite[index] = !(isFavorite[index] ?? false);
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = songs.isNotEmpty ? songs[currentSongIndex] : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Music Player",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Center(
                child: Text(
                  'Music Player',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite_border_sharp),
              title: const Text('Liked songs'),
              onTap: () {
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Music Player"),
                    content: const Text('Music Player for Local System Done By Bharath.G AIML'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
              },
            ),
            const Spacer(),
            const Divider(),
          ],
        ),
      ),
      body: songs.isEmpty
          ? Center(
              child: ElevatedButton.icon(
                onPressed: addSong,
                icon: const Icon(Icons.add),
                label: const Text('Add Songs'),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      final song = songs[index];
                      final bool favorite = isFavorite[index] ?? false;
                      
                      return ListTile(
                        leading: const Icon(Icons.music_note),
                        title: Text(
                          truncateTitle(song['title'] ?? 'Unknown Title', 20), // Apply the truncateTitle function
                          style: const TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(song['artist'] ?? 'Unknown Artist'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                favorite ? Icons.favorite : Icons.favorite_border,
                                color: favorite ? Colors.red : Colors.black,
                              ),
                              onPressed: () {
                                toggleFavorite(index);
                              },
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'remove') {
                                  setState(() {
                                    songs.removeAt(index); // Remove the song from the list
                                    if (currentSongIndex == index && isPlaying) {
                                      audioPlayer.stop(); // Stop playback if the current song is removed
                                      isPlaying = false;
                                    }
                                    if (currentSongIndex > index) {
                                      currentSongIndex--; // Adjust index if a song before the current song is removed
                                    }
                                  });
                                }
                              },
                              icon: const Icon(Icons.more_vert_outlined,color: Colors.black,), // Menu icon
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'remove',
                                  child: Text('Remove Song'),
                                ),
                              ],
                            ),
                          ],
                        ),

                        
                        onTap: () {
                          setState(() {
                            currentSongIndex = index;
                          });
                          isPlaying = false;
                          playPause();
                        },

                      );
                    },
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: addSong,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Songs'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                ),
                BottomPlayerBar(
                  isFavorite: isFavorite,
                  currentSongIndex: currentSongIndex,
                  isPlaying: isPlaying,
                  toggleFavorite: toggleFavorite,
                  playPause: playPause,
                  nextSong: nextSong,
                  previousSong: previousSong,
                  currentSongTitle: currentSong?['title'] ?? 'No Song Selected',
                  currentSongArtist: '',
                  currentDuration: currentDuration,
                  totalDuration: totalDuration,
                  onSeek: (Duration newPosition) {
                    audioPlayer.seek(newPosition);
                  },
                ),
              ],
            ),
    );
  }
}