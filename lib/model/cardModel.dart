import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class CardModel {
  String doctor;
  int cardBackground;
  var cardIcon;

  CardModel(this.doctor, this.cardBackground, this.cardIcon);
}

List<CardModel> cards = [
  new CardModel("Video Consulation", 0xFFec407a, TablerIcons.video),
  new CardModel("Find & Book Appointment", 0xFF5c6bc0, TablerIcons.search),
  new CardModel("Search Hospital", 0xFFfbc02d, TablerIcons.building_hospital),
  new CardModel("Nuritions", 0xFF1565C0, Icons.food_bank_outlined),
  new CardModel("Live Chat Support", 0xFF7625C0, TablerIcons.message),
];
List<CardModel> doctorCards = [
  new CardModel("Video Consulation", 0xFFec407a, TablerIcons.video),
  new CardModel("Appointments", 0xFF5c6bc0, Icons.file_copy_sharp),
  new CardModel("Search Hospital", 0xFFfbc02d, TablerIcons.building_hospital),
  new CardModel("Live Chat Support", 0xFF7625C0, TablerIcons.message),
  // new CardModel("Nuritions", 0xFF1565C0, Icons.food_bank_outlined),
];