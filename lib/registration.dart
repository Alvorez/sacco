// ignore_for_file: use_build_context_synchronously, duplicate_ignore, unused_import, file_names

import 'package:flutter/material.dart';
import 'package:sacco_teller/constants.dart';
import 'package:sacco_teller/login.dart';
import 'package:sacco_teller/customcontroller.dart';
import 'package:sacco_teller/customtext.dart';
import 'api_service.dart'; // Import your API service here

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Create controllers for each of the text fields
    final usernameController = TextEditingController();
    final phoneEmailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Welcome to Sacco Teller'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appBlack,
        titleTextStyle: const TextStyle(
          color: appWhite,
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Adjusted the padding
            child: Column(
              children: [
                // Created a widget for the text
                Image.asset(
                  "assets/navicon.png",
                  height: 200,
                  width: 300,
                ),
                const CustomText(
                  "Registration Screen",
                  label: 'Registration Page',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10.0),
                const CustomText(
                  "Username",
                  label: 'Username',
                  fontSize: 18.0,
                ),
                CustomTextWidget(
                  'Username',
                  label: 'Username',
                  hint: 'Enter Username',
                  icon: Icons.person,
                  controller: usernameController,
                ),
                const SizedBox(height: 10.0),
                const CustomText(
                  "Phone Number/Email",
                  label: 'Phone number/email',
                  fontSize: 18.0,
                ),
                CustomTextWidget(
                  'Phone Number/Email',
                  label: 'Phone number/email',
                  hint: 'Enter Phone number/Email',
                  icon: Icons.phone,
                  controller: phoneEmailController,
                ),
                const SizedBox(height: 10.0),
                const CustomText(
                  "Password",
                  label: 'Password',
                  fontSize: 18.0,
                ),
                CustomTextWidget(
                  'PASSWORD',
                  label: 'Password',
                  hint: 'Enter Password',
                  icon: Icons.lock,
                  hideText: true,
                  ispassword: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 10.0),
                const CustomText(
                  "Confirm Password",
                  label: 'Confirm Password',
                  fontSize: 18.0,
                ),
                CustomTextWidget(
                  'PASSWORD',
                  label: 'Confirm Password',
                  hint: 'Confirm Password',
                  icon: Icons.lock,
                  hideText: true,
                  ispassword: true,
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 10.0),
                const CustomText(
                  "We make saving easier",
                  label: 'Welcome to Sacco Teller',
                  fontSize: 18.0,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    final username = usernameController.text;
                    final phoneEmail = phoneEmailController.text;
                    final password = passwordController.text;
                    final confirmPassword = confirmPasswordController.text;

                    if (password == confirmPassword) {
                      try {
                        await registerUser(username, phoneEmail, password);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                        );
                      } catch (e) {
                        // Show error message if the registration fails
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Registration Failed'),
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
                    } else {
                      // Show error message if passwords don't match
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Password Mismatch'),
                            content: const Text(
                                'Passwords do not match. Please try again.'),
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
                  child: const Text('Register for an account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  registerUser(String username, String phoneEmail, String password) {}
}
