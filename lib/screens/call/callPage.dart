// Flutter imports:
import 'dart:ui';

import 'package:dyte_client/dyte.dart';
import 'package:dyte_client/dyteMeeting.dart';
import 'package:flutter/material.dart';
import '../../config.dart';
import '../../model/dyte_api.dart';

class CallPage extends StatelessWidget {
   CallPage({Key? key, required this.callID,required this.userId,required this.username}) : super(key: key);
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
    joinMeeting();
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
                          authToken: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdJZCI6ImIzZTVkODhlLWE0ZDQtNGU2ZS04Y2IwLTBhZWU4NjdmZDJiNCIsIm1lZXRpbmdJZCI6ImJiYjliNWE3LTIyZGQtNDUxZS05NTRmLWY2M2M2M2ZmZWM3MyIsInBhcnRpY2lwYW50SWQiOiJhYWEwNmI3My01MGZkLTQ4M2QtYWE5YS01MThlOTc1NjI3ZjAiLCJwcmVzZXRJZCI6IjZhYzBkMTBlLTQwYjMtNDRmNy1iZTA5LThjMTBiMjllOTU3MSIsImlhdCI6MTY5NDIwOTQyNywiZXhwIjoxNzAyODQ5NDI3fQ.BQFuxAqpTLfLZcmCmA5zBaLvrRBO_a4lKP1-QAgWYDa0ySe8ipv2d-wZXFxL2t4I_NvweA5PGsnZoNBq2rSMVcZO3vVzP0twlSo45YZ0OZ_WIWLKWv0Tf5-_sgbZxS6mfODvg4GXABGajxFxOVwZnBVkeIMQI2AX2PLkc8dXWmAHXGmTYecU7Q0IjkN1xG0cg0oAz1THcFTJc8014m64atmIymydAVF34mYotyUopdV-AzaftTKSUnbJp9eUVGd34xXk4bBAWLrLu35JxlMDGLOpjN16rAxHjYo2gqNndScXa3VJLAoNrG_dsniHXM5k7llkcGY9T_nMYCFLtawjfQ",
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