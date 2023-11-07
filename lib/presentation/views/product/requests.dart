import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucumber_app/presentation/views/home/home_screen.dart';
import 'package:cucumber_app/presentation/views/product/in_sale_vegs.dart';
import 'package:cucumber_app/presentation/views/product/products.dart';
import 'package:cucumber_app/presentation/widgets/contact_form_widgets.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PendingVeggies extends StatefulWidget {
  const PendingVeggies({super.key});

  @override
  State<PendingVeggies> createState() => _PendingVeggiesState();
}

class _PendingVeggiesState extends State<PendingVeggies> {
  int _currentIndex = 2;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddProducts(),
              ));
          break;
        case 1:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InSale(),
              ));
          break;
        case 2:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PendingVeggies(),
              ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const Center(child: Text('User not logged in.'));
    }
    final email = FirebaseAuth.instance.currentUser!.email;

    // String currentUsername = currentUser.displayName ?? '';
    return SafeArea(
      child: Scaffold(
        backgroundColor: kwhite,
        body: Column(
          children: [
            lheight,
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ));
                    },
                    icon: const Icon(Icons.arrow_back_ios,
                        size: 25, color: darkgreen)),
                const Captions(
                    captionColor: darkgreen, captions: 'Under Review'),
              ],
            ),
            sheight,
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('pending_approval')
                    .where('email', isEqualTo: email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text('No vegetables available.'));
                  } else {
                    var pendingApproval = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: pendingApproval.length,
                      itemBuilder: (context, index) {
                        var vegetable = pendingApproval[index];
                        var name = vegetable['name'];
                        var price = vegetable['price'];

                        return Card(
                          child: ListTile(
                            leading: Container(
                              decoration: const BoxDecoration(color: kwhite),
                              width: 70,
                              height: 70,
                              child: Image.asset('assets/images.jpeg'),
                            ),
                            title: Text(name),
                            subtitle: Text('$price per Kg'),
                            trailing: IconButton(
                                onPressed: () {
                                  //showAlertDialog(context);
                                },
                                icon: const Icon(Icons.edit)),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: lightgreen,
            selectedItemColor: kwhite,
            selectedFontSize: 20,
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: 'Products'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), label: 'In Sales'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.approval), label: 'Requests')
            ]),
      ),
    );
  }

  void showAlertDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Details'),
        content: const Text(''),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('pending_approvals').doc();
            },
            child: const Text('Delete'),
          ),
          TextButton(onPressed: () {}, child: const Text('Save Changes'))
        ],
      ),
    );
  }
}
