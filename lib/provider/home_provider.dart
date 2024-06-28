// // import 'package:capstone_project/screens/pengingat_merawat_tanaman/plant_reminder_screen.dart';
// // import 'package:capstone_project/screens/pengingat_merawat_tanaman/time_reminder_screen.dart';
// // import 'package:capstone_project/services/menanam_tanaman/plant_api.dart';
// import 'package:flutter/material.dart';

// class HomeProvider extends ChangeNotifier{
//   //SEARCH
//   // String _searchQuery = '';

//   // String get searchQuery => _searchQuery;

//   // void updateSearchQuery(String query) {
//   //   _searchQuery = query;
//   //   notifyListeners();
//   // }

//   // bool seeAllPlantType = false;
 
//   // void allPlantNavigatorOnTap(BuildContext context) async{
//   //   Navigator.push(
//   //     context,
//   //     MaterialPageRoute(builder: (context) => const PlantReminder()),
//   //   );
//   //   notifyListeners();
//   // }

//   // bool setSeeAllPlantTypeFalse(){
//   //   notifyListeners();
//   //   return seeAllPlantType = false;
//   // }

//   //see all plant
//   // ignore: non_constant_identifier_names
//   // String PlantReminderAppBarText = 'Tanaman Anda';
//   // ignore: non_constant_identifier_names
//   String TimeMenyiramAppBarText = 'REMINDER';
  
//   int idPlant = 0;

//   void seeDetaiReminder({
//     required BuildContext context,
//     int? id,
//     // required int idPlant,
//   }) async{
//       // ignore: unnecessary_this
//       this.idPlant = id!;
//       // ignore: avoid_print
//       print('id : $id');
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const TimeReminder()),
//       );
//     notifyListeners();
//   }

//   //detail plant by id
//   String detailPlantAppBarText = 'Reminder';
//   Color aboutPlantColor = const Color(0xffDCEEE8);
//   Future detailPlant() async{
//     try{
//       // ignore: unnecessary_this
//       await PlantApi().getPlantById(id: this.idPlant);
//       notifyListeners();
//     }catch(e){}
//     notifyListeners();
//   }
// }