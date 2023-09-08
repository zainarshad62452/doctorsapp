// Flutter imports:
import 'dart:ui';

import 'package:doctorsapp/config.dart';
import 'package:dyte_client/dyte.dart';
import 'package:dyte_client/dyteMeeting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../model/dyte_api.dart';

class AudioCallPage extends StatelessWidget {
   AudioCallPage({Key? key, required this.callID,required this.userId,required this.username}) : super(key: key);
  final String callID;
  final String username;
  final String userId;
  String authToken=" ";
  joinMeeting() async {
    authToken = await DyteAPI.addParticipantToMeeting(callID,username,userId);
  }
   Future<void> ensureScreenSize([
    FlutterView? window,
    Duration duration = const Duration(milliseconds: 10),
  ]) async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    window ??= binding.window;
    await joinMeeting();
    if (window.physicalGeometry.isEmpty) {
      return Future.delayed(duration, () async {
        binding.deferFirstFrame();
        await ensureScreenSize(window, duration);
        return binding.allowFirstFrame();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: Future.wait([ensureScreenSize(),]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return Material(
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return SizedBox(
                          width: width,
                          height: height,
                          child: DyteMeeting(
                            roomName: "$callID",
                            authToken: authToken,
                            onInit: (DyteMeetingHandler meeting) async {
                              var self = await meeting.self;
                            },
                          )
                      );
                    },),
                );
              }
          ),

        ],
      ),
    );
  }
}