import 'package:flutter/material.dart';

/// ### Full Screen Loader
/// It is a full screen loader that will be used in the app.
///
///
class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Loading movies...',
      'Buying popcorn...',
      'Loading popular movies...',
      'Loading upcoming movies...',
      'Loading now playing movies...',
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step % messages.length];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Loading...'),
          const SizedBox(
            height: 10,
          ),
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading...');
              }

              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}
