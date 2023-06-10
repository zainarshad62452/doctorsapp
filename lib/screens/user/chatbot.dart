import 'package:doctorsapp/screens/user/myAppointments.dart';
import 'package:doctorsapp/screens/user/nearbyHospitalScreen.dart';
import 'package:doctorsapp/screens/user/nutritionsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  TextEditingController _messageController = TextEditingController();
  List<Widget> _chatMessages = [];

  void _sendMessage(String message) {
    setState(() {
      _chatMessages.add(UserMessage(text: message));
      String response = generateChatbotResponse(message);
      _chatMessages.add(BotMessage(text: response));
    });
    _messageController.clear();
  }

  String generateChatbotResponse(String message) {
    // Basic chatbot responses based on user messages
    message = message.toLowerCase();
    if (message.contains('hello') || message.contains('hi')) {
      return 'Hello! How can I assist you today?';
    } else if (message.contains('appointment')) {
      return 'Sure, I can help you book an appointment. Click the button below to go to appointment screen.';
    } else if (message.contains('video consultation')) {
      return 'Video consultations are available for certain cases. Click the button below to go to Video Consultation screen.';
    } else if (message.contains('nutrition') || message.contains('diet')) {
      return 'For nutrition-related queries, it is best to consult with a healthcare professional.Click the button below to go to Nutrition screen';
    } else if (message.contains('hospital')) {
      return 'I can find nearby hospitals for you.Click the button below to go to Nearby Hospital screen.';
    } else if (message.contains('vaccination') || message.contains('immunization')) {
      return 'Vaccinations are essential for children. Please consult with a pediatrician for the recommended vaccination schedule.';
    } else if (message.contains('developmental milestones')) {
      return 'Monitoring your child\'s developmental milestones is important. Here are some typical milestones by age:\n\n- 1 month: Lifts head when on tummy\n- 6 months: Sits with support\n- 12 months: Takes first steps\n\nPlease consult with a healthcare professional for personalized advice.';
    } else if (message.contains('emergency') || message.contains('urgent')) {
      return 'In case of emergencies or urgent medical situations, please contact your local emergency helpline or visit the nearest emergency department.';
    } else {
      return 'I apologize, but I cannot understand your request. How can I assist you today?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade700,
        title: Text('Children Health Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                return _chatMessages[_chatMessages.length - index - 1];
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      _sendMessage(message);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserMessage extends StatelessWidget {
  final String text;

  UserMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.tealAccent.shade700,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class BotMessage extends StatelessWidget {
  final String text;

  BotMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              getButton(text),
            ],
          ),
        ),
      ),
    );
  }

  Widget getButton(String text){
    if(text.toLowerCase().contains('video')){
      return MaterialButton(
        color: Colors.tealAccent.shade700,
        textColor: Colors.white,
        onPressed: () {
          Get.to(()=>MyAppointments(title: "Video Consultation",));
        },
        child: Text('Video Consulation'),
      );
    }else if(text.toLowerCase().contains('nutrition')){
      return MaterialButton(
        color: Colors.tealAccent.shade700,
        textColor: Colors.white,
        onPressed: () {
          Get.to(()=>NutritionsScreen());
        },
        child: Text('Nutrition'),
      );
    }else if(text.toLowerCase().contains('hospital')){
      return MaterialButton(
        color: Colors.tealAccent.shade700,
        textColor: Colors.white,
        onPressed: () {
          Get.to(()=>NearbyHospitalsPage());
        },
        child: Text('Nearby Hospitals'),
      );
    }else if(text.toLowerCase().contains('appointment')){
      return MaterialButton(
        color: Colors.tealAccent.shade700,
        textColor: Colors.white,
        onPressed: () {
          Get.to(()=>MyAppointments(title: "My Appointments",));
        },
        child: Text('Appointments'),
      );
    }else{
      return SizedBox();
    }


  }
}
