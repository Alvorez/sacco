// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sacco_teller/applications.dart';
import 'package:sacco_teller/constants.dart';
import 'package:sacco_teller/customer.dart';
import 'package:sacco_teller/inquiry.dart';
import 'package:sacco_teller/transaction.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:sacco_teller/teller.dart'; 

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TellerPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(Icons.home, size: 30, color: appBlack),
          Icon(Icons.account_balance, size: 30, color: appBlack),
        ],
        index: _selectedIndex,
        height: 60.0,
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: _onItemTapped,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).hoverColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'msacco',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: const Color.fromARGB(221, 248, 245, 245)),
                  ),
                  subtitle: Text(
                    'Welcome',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: const Color.fromARGB(137, 244, 241, 241)),
                  ),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/navicon.png'),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          Container(
            color: appBlack,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              decoration: const BoxDecoration(color: appWhite),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CustomerRegistrationPage()),
                      );
                    },
                    child: itemDashboard(
                      'customer',
                      CupertinoIcons.person_crop_circle_badge_plus,
                      const Color.fromARGB(255, 16, 0, 67),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TransactionSelectionPage()),
                      );
                    },
                    child: itemDashboard(
                      'Transactions',
                      CupertinoIcons.calendar,
                      const Color.fromARGB(255, 16, 0, 67),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReportsSelectionPage()),
                      );
                    },
                    child: itemDashboard(
                      'Inquiry',
                      CupertinoIcons.graph_circle_fill,
                      const Color.fromARGB(255, 16, 0, 67),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ApplicationSelectionPage()),
                      );
                    },
                    child: itemDashboard(
                      'Applications',
                      CupertinoIcons.news_solid,
                      const Color.fromARGB(255, 16, 0, 67),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) => Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(color: background, shape: BoxShape.circle),
              child: Icon(iconData, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
      );
}

class PlaceholderWidget extends StatelessWidget {
  final String text;

  const PlaceholderWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 30),
      ),
    );
  }
}
