import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class VideoPlayerScreens extends StatefulWidget {
  final int id;

  VideoPlayerScreens({required this.id});

  @override
  _VideoPlayerScreensState createState() => _VideoPlayerScreensState();
}

class _VideoPlayerScreensState extends State<VideoPlayerScreens> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {

    int id =widget.id;
    print("if${id}");
    var res = await Api().getData('/api/video_single_view/'+id.toString());
    var body = json.decode(res.body);
    setState(() {
      String video = body['data']['video'];
      print(video);
      /* _controller = VideoPlayerController.network(Api().url + video);
    _initializeVideoPlayerFuture = _controller.initialize();
    setState(() {});*/
      _controller = VideoPlayerController.network(Api().url + video);
      _initializeVideoPlayerFuture = _controller.initialize();
      _controller.setLooping(true);
      _controller.play();
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
