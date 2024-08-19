// ignore_for_file: unused_local_variable, use_build_context_synchronously, unused_import, file_names

import 'package:flutter/material.dart';
import 'package:sacco_teller/constants.dart';
import 'package:sacco_teller/dashboard.dart';
import 'package:sacco_teller/registration.dart';
import 'package:sacco_teller/customcontroller.dart';
import 'package:sacco_teller/customtext.dart';
import 'api_service.dart'; // Import your API service here

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SACCO TELLER'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
        titleTextStyle: const TextStyle(
          color: appWhite,
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Column(
              children: [
                // Created a widget for the text
                Image.asset(
                  "assets/navicon.png",
                  height: 200,
                  width: 300,
                ),
                const CustomText(
                  'Login Page',
                  label: 'Login Screen',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10.0),
                const CustomText(
                  'Username',
                  label: 'Username',
                  fontSize: 18.0,
                ),
                CustomTextWidget(
                  'Username',
                  label: 'Username',
                  hint: 'Phone number/Email',
                  icon: Icons.person,
                  controller: usernameController,
                ),
                const SizedBox(height: 10.0),
                const CustomText(
                  'Password',
                  label: 'Password',
                  fontSize: 18.0,
                ),
                CustomTextWidget(
                  'PASSWORD',
                  label: 'Password',
                  hint: 'Password',
                  icon: Icons.lock,
                  hideText: true,
                  ispassword: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 10.0),
                const CustomText(
                  'Forgot password?',
                  label: 'Forgot password?',
                  fontSize: 18.0,
                ),
                const SizedBox(height: 10.0),
                MaterialButton(
                  onPressed: () async {
                    final username = usernameController.text;
                    final password = passwordController.text;

                    try {
                      await loginUser(username, password);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardPage(),
                        ),
                      );
                    } catch (e) {
                      // Show error message if the login fails
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Login Failed'),
                            content: Text(e.toString()),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  minWidth: 80,
                  height: 50,
                  color: appWhite,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Button to navigate to the registration page
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationPage(),
                      ),
                    );
                  },
                  child: const Text('Register for an account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

loginUser(String username, String password) {
}
