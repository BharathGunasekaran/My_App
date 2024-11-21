// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'player.dart';
// import 'login.dart';


// class MusicPlayerScreen extends StatefulWidget {
//   const MusicPlayerScreen({super.key});

//   @override
//   _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
// }

// class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
//   final List<Map<String, String>> songs = [
//     {'title': 'Aayiram Jannal Veedu', 'artist': 'Rahul Nambiar'},
//     {'title': 'Abhiyum Naanum', 'artist': 'Unknown'},
//     {'title': 'Adiyae Kolluthey', 'artist': 'Krish, Benny Dayal'},
//   ];

//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', false);
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Music Player", style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.white,
//       ),
//       drawer: Drawer(
//         child: Column(
//           children: [
//             DrawerHeader(
//               decoration: const BoxDecoration(color: Colors.black),
//               child: const Center(
//                 child: Text(
//                   'Music',
//                   style: TextStyle(color: Colors.white, fontSize: 30),
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.playlist_play),
//               title: const Text('Playlist'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.info),
//               title: const Text('About'),
//               onTap: () {
//                 showAboutDialog(
//                   context: context,
//                   applicationName: 'Music Player',
//                   applicationVersion: '1.0.0',
//                 );
//               },
//             ),
//             const Spacer(),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text('Logout'),
//               onTap: logout,
//             ),
//           ],
//         ),
//       ),
//       body: const Center(
//         child: Text('Music Player Content'),
//       ),
//     );
//   }
// }









import 'package:flutter/material.dart';
import 'package:music/player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final List<Map<String, String>> songs = [
    {'title': 'Aayiram Jannal Veedu', 'artist': 'Rahul Nambiar'},
    {'title': 'Abhiyum Naanum', 'artist': 'Unknown'},
    {'title': 'Adiyae Kolluthey', 'artist': 'Krish, Benny Dayal'},
    {'title': 'Adiyae Azhagae', 'artist': 'Unknown'},
    {'title': 'Akadanu Naanga', 'artist': 'S.P. Balasubramaniam'},
    {'title': 'Akhila Akhila', 'artist': 'Srinivas'},
    {'title': 'Akkam Pakkam', 'artist': 'Sadhana Sargam'},
  ];

  final Map<int, bool> isFavorite = {};
  int currentSongIndex = 0;
  bool isPlaying = false;

  void toggleFavorite(int index) {
    setState(() {
      isFavorite[index] = !(isFavorite[index] ?? false);
    });
  }

  void playPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void nextSong() {
    setState(() {
      currentSongIndex = (currentSongIndex + 1) % songs.length;
      isPlaying = true; // Automatically play the next song
    });
  }

  void previousSong() {
    setState(() {
      currentSongIndex = (currentSongIndex - 1 + songs.length) % songs.length;
      isPlaying = true; // Automatically play the previous song
    });
  }

  Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );
}


  @override
  Widget build(BuildContext context) {
    final currentSong = songs[currentSongIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Music", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Center(
                child: Text(
                  'Music',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.playlist_play),
              title: const Text('Playlist'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Music Player',
                  applicationVersion: '1.0.0',
                );
              },
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: logout,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                final bool favorite = isFavorite[index] ?? false;

                return ListTile(
                  leading: const Icon(Icons.music_note),
                  title: Text(song['title'] ?? 'Unknown Title'),
                  subtitle: Text(song['artist'] ?? 'Unknown Artist'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          favorite ? Icons.favorite : Icons.favorite_border,
                          color: favorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          toggleFavorite(index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 150,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.add),
                                      title: const Text('Add to Playlist'),
                                      onTap: () {},
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.info),
                                      title: const Text('Song Info'),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      currentSongIndex = index;
                      isPlaying = true; // Play the selected song
                    });
                  },
                );
              },
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
            currentSongTitle: currentSong['title'] ?? 'Unknown Title',
            currentSongArtist: currentSong['artist'] ?? 'Unknown Artist',
          ),
        ],
      ),
    );
  }
}






