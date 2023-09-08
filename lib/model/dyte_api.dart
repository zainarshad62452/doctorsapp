import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'models.dart';

class DyteAPI {
  static const String orgId = 'b3e5d88e-a4d4-4e6e-8cb0-0aee867fd2b4';
  static const String apiKey = 'fee89cd2557fb4b3a9db';
  static Future<String> addParticipantToMeeting(
      String meetingId,
      String callerName,
      String callerID
      ) async {
    // var meetings = await getMeetings();
    var url = Uri.parse("https://api.dyte.io/v2/meetings/$meetingId/participants");
    var body = {
      "name": callerName,
      // "picture": "",
      "custom_participant_id": callerID,
      "preset_name": "group_call_participant"
    };

    var response = await http.post(
      url,
      headers: <String, String>{
        "Authorization": "Basic ${base64Encode(utf8.encode('$orgId:$apiKey'))}",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );
    var decodedResponse = jsonDecode(response.body) as Map;
    print(decodedResponse);
    var authToken = decodedResponse["data"]["token"];

    return authToken;
  }

  //makes the meeting create request
  static Future<Meeting> createMeeting(String meetingTitle) async {
    var url = Uri.parse("https://api.cluster.dyte.in/v2/meetings/");
    var response = await http.post(url,
        headers: <String, String>{
          "Authorization": "Basic ${base64Encode(utf8.encode('$orgId:$apiKey'))}",
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, dynamic>{
          'title': meetingTitle,
          // 'presetName': 'host',
          // 'authorization': <String, bool>{'waitingRoom': false, 'closed': false}
        }));

    if (response.statusCode != 200) {
      print("error");
    }

    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("////////////////////////////////////");
    print(decodedResponse);

    var data = decodedResponse["data"] as Map;

    var meeting = Meeting.fromJson(data);

    return meeting;
  }
  // static Future<List<Meeting>> getMeetings() async {
  //   var url = Uri.parse("https://api.cluster.dyte.in/v2/meetings");
  //   var response = await http.get(url);
  //
  //   if (response.statusCode != 200) {
  //     print(response.body);
  //   }
  //   var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  //
  //   var data = decodedResponse["data"] as Map;
  //   var meetingsJson = data["meetings"] as List<dynamic>;
  //   var meetings = MeetingList.fromJsonList(meetingsJson).meetings!;
  //
  //   return meetings;
  // }
}
