import 'package:FarmerFriendly/main.dart';
import 'package:FarmerFriendly/presentation/widgets/signing_widgets.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.green, Colors.teal])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Arrowback(backcolor: kwhite),
                      Text(
                        'About the App',
                        style: TextStyle(
                            fontSize: 26,
                            color: kwhite,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.yellow[100],
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        const Text(
                          'FarmerFriendly App',
                          style: TextStyle(
                              fontSize: 24,
                              color: kblack,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Welcome to the FarmerFriendly App, your ultimate tool for seamlessly managing and optimizing your farm produce operations. This app is designed to empower farmers and administrators in the agricultural ecosystem, providing a user-friendly interface for handling vegetable prices, updating collection details, facilitating payments to farmers, and engaging in direct communication with customers.',
                          style: TextStyle(
                            fontSize: 16,
                            color: kblack,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Key Features:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kblack,
                          ),
                        ),
                        const Text(
                          '1. Vegetable Price Management: Easily set and adjust prices for a variety of homegrown vegetables. Monitor market trends, and ensure fair compensation for the hard work of our dedicated farmers.',
                          style: TextStyle(
                            fontSize: 16,
                            color: kblack,
                          ),
                        ),
                        const Text(
                          '2. Update Collection Details: Stay organized by updating and managing collection details efficiently. Track the origin, quantity, and quality of vegetables collected from farmers.',
                          style: TextStyle(
                            fontSize: 16,
                            color: kblack,
                          ),
                        ),
                        const Text(
                          '3. Customer Interaction: Enhance communication with customers through an integrated chat feature. Address inquiries, provide updates on available produce, and build a stronger connection between your farm and the end consumers.',
                          style: TextStyle(
                            fontSize: 16,
                            color: kblack,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Why Choose FarmerFriendly App:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kblack,
                          ),
                        ),
                        const Text(
                          '- User-Friendly Interface: Navigate through the app effortlessly with its intuitive design, making farm management tasks a breeze.',
                          style: TextStyle(
                            fontSize: 16,
                            color: kblack,
                          ),
                        ),
                        const Text(
                          '- Real-time Updates: Stay informed with real-time updates on market conditions, payment transactions, and customer interactions.',
                          style: TextStyle(
                            fontSize: 16,
                            color: kblack,
                          ),
                        ),
                        const Text(
                          '- Data Security: Your data is important to us. Rest assured that our app employs robust security measures to safeguard sensitive information.',
                          style: TextStyle(
                            fontSize: 16,
                            color: kblack,
                          ),
                        ),
                        const Text(
                          '- Supporting Sustainable Agriculture: By using the FarmerFriendly App, you contribute to promoting sustainable agriculture practices and supporting local farmers.',
                          style: TextStyle(
                            fontSize: 16,
                            color: kblack,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Get Started:',
                          style: TextStyle(
                              fontSize: 20,
                              color: kblack,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Download the FarmerFriendly App today and embark on a journey towards efficient farm produce management. Empower your farming community and connect with customers in a meaningful way.',
                          style: TextStyle(
                            fontSize: 16,
                            color: kblack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
