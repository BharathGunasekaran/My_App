import 'package:flutter/material.dart';
import 'package:music/player.dart';

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

  // Track the favorite state for each song
  final Map<int, bool> isFavorite = {};

  @override
  Widget build(BuildContext context) {
    return Container(

    child:Scaffold(
      appBar: AppBar(
        title: const Text("Music Player",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  
                  final song = songs[index];
                  final bool favorite = isFavorite[index] ?? false;
                  
                  return ListTile(
                    
                    leading: const Icon(
                      Icons.music_note,
                    ),
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
                            setState(() {
                              isFavorite[index] = !favorite;
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            // Handle more options click
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
                                        onTap: () {
                                          // Add to playlist logic
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.info),
                                        title: const Text('Song Info'),
                                        onTap: () {
                                          // Show song info
                                        },
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
                  );
                },
              ),
            ),
            BottomPlayerBar(),
          ],
        ),
        
      ),
      drawer: const Drawer(), // Add the side menu here if necessary
    ),
  );
  }
}
