// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cucumber_app/presentation/views/home/sidebar_drawer.dart';
// import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
// import 'package:cucumber_app/utils/constants/constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomeScreenSidebar extends StatelessWidget {
//   const HomeScreenSidebar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final User? user = FirebaseAuth.instance.currentUser;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: lightgreen,
//           title: const Text('Cucumber'),
//         ),
//         drawer: const CustomDrawer(),
//         body: Column(
//           children: [
//             FutureBuilder<DocumentSnapshot>(
//               future: FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(user?.uid)
//                   .get(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error ${snapshot.error}'));
//                 } else if (!snapshot.hasData) {
//                   return const Center(child: Text("user not found"));
//                 } else {
//                   var userData = snapshot.data!.data() as Map<String, dynamic>;
//                   var username = userData['username'];
//                   return Column(
//                     children: [
//                       Captions(captionColor: kblack, captions: 'Hi , $username')
//                     ],
//                   );
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
