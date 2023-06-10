// Flutter imports:
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit/zego_uikit.dart';

import '../../config.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID,required this.userId,required this.username}) : super(key: key);
  final String callID;
  final String username;
  final String userId;
  static Future<void> ensureScreenSize([
    FlutterView? window,
    Duration duration = const Duration(milliseconds: 10),
  ]) async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    window ??= binding.window;

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
                    return ZegoUIKitPrebuiltCall(
                      controller: ZegoUIKitPrebuiltCallController(),
                      appID: kAppID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
                      appSign: kAppSign, /// Fill in the appSign that you get from ZEGOCLOUD Admin Console.
                      userID: userId,
                      userName: username,
                      callID: callID,
                      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
                      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                        ..onOnlySelfInRoom = (context) => Get.back(),
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