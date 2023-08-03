// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:helloworld/api_service/api.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoPlayerScreen extends StatefulWidget {
//   int id;
//
//   VideoPlayerScreen({required this.id});
//
//   //const VideoPlayerScreen({Key? key, required int id}) : super(key: key);
//
//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializePlayer();
//   }
//
//   Future<void> _initializePlayer() async {
//
//     int id =widget.id;
//     print("if${id}");
//     var res = await Api().getData('/api/video_single_view/'+id.toString());
//     var body = json.decode(res.body);
//     String video = body['data']['video'];
//     print(video);
//     _controller = VideoPlayerController.network(Api().url + video);
//     _initializeVideoPlayerFuture = _controller.initialize();
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_controller.value.isInitialized) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Video Player'),
//         ),
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Player'),
//       ),
//       body: Center(
//         child: AspectRatio(
//           aspectRatio: _controller.value.aspectRatio,
//           child: VideoPlayer(_controller),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _controller.value.isPlaying ? _controller.pause() : _controller.play();
//           });
//         },
//         child: Icon(
//           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//         ),
//       ),
//     );
//   }
// }
//
//







// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:helloworld/api_service/api.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoPlayerScreen extends StatefulWidget {
//
//
//   int id;
//
//   VideoPlayerScreen({required this.id});
//
//   //const VideoPlayerScreen({Key? key, required int id}) : super(key: key);
//
//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _initializePlayer();
//     _controller=VideoPlayerController as VideoPlayerController ;
//   }
//   late VideoPlayerController _controller;
//
//   //late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//
//
//   Future<void> _initializePlayer() async {
//
//     int id =widget.id;
//     print("if${id}");
//     var res = await Api().getData('/api/video_single_view/'+id.toString());
//     var body = json.decode(res.body);
//     String video = body['data']['video'];
//     print(video);
//     _controller = VideoPlayerController.network(Api().url + video);
//     _initializeVideoPlayerFuture = _controller.initialize();
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_controller.value.isInitialized) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Video Player'),
//         ),
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Player'),
//       ),
//       body: Center(
//         child: AspectRatio(
//           aspectRatio: _controller.value.aspectRatio,
//           child: VideoPlayer(_controller),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _controller.value.isPlaying ? _controller.pause() : _controller.play();
//           });
//         },
//         child: Icon(
//           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//         ),
//       ),
//     );
//   }
// }
//
