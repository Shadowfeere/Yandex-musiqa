import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class CustomAudioWidget extends StatefulWidget {
  const CustomAudioWidget({
    super.key,
    required this.musicName,
    required this.filePahth,
    required AnimationController animationController,
  }) : _animationController = animationController;

  final String musicName;
  final String filePahth;

  final AnimationController _animationController;

  @override
  State<CustomAudioWidget> createState() => _CustomAudioWidgetState();
}

class _CustomAudioWidgetState extends State<CustomAudioWidget> {
  late AudioPlayer _audioPlayer;
  Source? source; // * audio
  Duration hozirgivaxt = Duration(seconds: 0);
  Duration ummiyVaxt = Duration(seconds: 0);
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setSourceDeviceFile(widget.filePahth).then((v) {
      source = _audioPlayer.source;
    });
    _audioPlayer.getDuration().then((value) {
      ummiyVaxt = value!;
      setState(() {});
    });
    _audioPlayer.onPositionChanged.listen((value) {
      hozirgivaxt = value;
      print('Umumiy voxt $hozirgivaxt');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Row(
          children: [
            Text(
              widget.musicName,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.share),
            SizedBox(width: 10),
            Icon(Icons.more_horiz),
          ],
        ),
        SizedBox(height: 30),
        Text(hozirgivaxt.inSeconds.toString(),style: TextStyle(fontSize: 14),),
        // Slider(
        //   min: 0.0,
        //   max: ummiyVaxt.inSeconds.toDouble(),
        //   value: hozirgivaxt.inSeconds.toDouble(),
        //   onChanged: (value) {
        //     _audioPlayer.seek(Duration(seconds: value.toInt()));
        //     setState(() {});
        //   },
        //   padding: EdgeInsets.zero,
        // ),
        SizedBox(height: 30),
        Row(
          children: [
            Image.asset(
              "assets/images/like-no.png",
              height: 24,
              fit: BoxFit.cover,
            ),
            Spacer(),
            Image.asset(
              "assets/images/left.png",
              height: 24,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            pley_paus(
              widget: widget,
              audioPlayer: _audioPlayer,
              source: source,
            ),
            SizedBox(width: 10),
            Image.asset(
              "assets/images/right.png",
              height: 24,
              fit: BoxFit.cover,
            ),

            Spacer(),
            Image.asset(
              "assets/images/like-yes.png",
              height: 24,
              fit: BoxFit.cover,
            ),
          ],
        ),
        // ListTile(
        //   subtitle: Text(widget.musicName),
        //   title: Text(ummiyVaxt.inSeconds.toString()),
        //   leading: Text("Leding"),
        // ),
      ],
    );
  }
}

class pley_paus extends StatelessWidget {
  const pley_paus({
    super.key,
    required this.widget,
    required AudioPlayer audioPlayer,
    required this.source,
  }) : _audioPlayer = audioPlayer;

  final CustomAudioWidget widget;
  final AudioPlayer _audioPlayer;
  final Source? source;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (widget._animationController.status == AnimationStatus.completed) {
          _audioPlayer.pause();
          widget._animationController.reverse();
        } else {
          _audioPlayer.play(source!);
          widget._animationController.forward();
        }
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        size: 50,color: Color(0xffffffff),
        progress: widget._animationController,
      ),
    );
  }
}
