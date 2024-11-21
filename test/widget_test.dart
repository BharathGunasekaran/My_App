import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Music Player smoke test', (WidgetTester tester) async {
    // Build the MusicPlayerApp and trigger a frame.
    await tester.pumpWidget(const MusicPlayerApp());

    // Verify if the app displays the title "Music Player" in the AppBar.
    expect(find.text('Music Player'), findsOneWidget);

    // Verify if the song list contains the first song.
    expect(find.text('Aayiram Jannal Veedu'), findsOneWidget);

    // Check if the play button is present.
    expect(find.byIcon(Icons.play_arrow_rounded), findsOneWidget);

    // Tap the play button and trigger a frame.
    await tester.tap(find.byIcon(Icons.play_arrow_rounded));
    await tester.pump();

    // Check if tapping the play button changes it to a pause button.
    expect(find.byIcon(Icons.pause), findsOneWidget);
  });
}



















// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:music/main.dart';


// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MusicPlayerApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }
