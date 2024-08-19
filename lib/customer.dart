// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sacco_teller/constants.dart';
import 'package:sacco_teller/customcontroller.dart';
import 'package:sacco_teller/customtext.dart';
import 'package:sacco_teller/api_service.dart';

class CustomerRegistrationPage extends StatefulWidget {
  const CustomerRegistrationPage({super.key});

  @override
  _CustomerRegistrationPageState createState() =>
      _CustomerRegistrationPageState();
}

class _CustomerRegistrationPageState extends State<CustomerRegistrationPage> {
  final _customerIdController = TextEditingController();
  final _fullNamesController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _dateController = TextEditingController();
  String? _selectedGender;
  String? _selectedCounty;
  final ApiService _apiService = ApiService(
      baseUrl:
          'https://businesscentral.coretec.co.ke:8989/'); // Replace with your actual API base URL

  // ignore: unused_field
  DateTime? _selectedDate;

  void _selectDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
        _dateController.text = '${selectedDate.toLocal()}'
            .split(' ')[0]; // Format date as yyyy-mm-dd
      });
    }
  }

  void _registerCustomer() async {
    final customerId = _customerIdController.text;
    final fullNames = _fullNamesController.text;
    final phoneNumber = _phoneNumberController.text;
    final dateOfBirth = _dateController.text;
    final gender = _selectedGender ?? '';
    final county = _selectedCounty ?? '';

    if (customerId.isEmpty ||
        fullNames.isEmpty ||
        phoneNumber.isEmpty ||
        dateOfBirth.isEmpty ||
        gender.isEmpty ||
        county.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      final response = await _apiService.registerCustomer(
        customerId: customerId,
        fullNames: fullNames,
        phoneNumber: phoneNumber,
        gender: gender,
        dateOfBirth: dateOfBirth,
        county: county,
      );
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Customer registered successfully')),
        );
        // Navigate to another page or reset form
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to register customer')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Customer Registration'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appBlack,
        titleTextStyle: const TextStyle(
          color: appWhite,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/navicon.png",
                  height: 200,
                  width: 300,
                ),
                const CustomText(
                  "Customer Registration",
                  label: 'Registration Page',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 20.0),
                const CustomText(
                  "Customer ID",
                  label: 'Customer ID',
                  fontSize: 18.0,
                ),
                CustomTextWidget(
                  "Customer ID",
                  label: 'Customer ID',
                  hint: "Enter Customer ID",
                  icon: Icons.perm_identity,
                  controller: _customerIdController,
                ),
                const SizedBox(height: 10.0),
                const CustomText(
                  "Full Names",
                  label: 'Full Names',
                  fontSize: 18.0,
                ),
                CustomTextWidget(
                  "Full Names",
                  label: 'Full Names',
                  hint: "Enter Full Names",
                  icon: Icons.person,
                  controller: _fullNamesController,
                ),
                const SizedBox(height: 10.0),
                const CustomText(
                  "Phone Number",
                  label: 'Phone Number',
                  fontSize: 18.0,
                ),
                CustomTextWidget(
                  "Phone Number",
                  label: 'Phone Number',
                  hint: "Enter Phone Number",
                  icon: Icons.phone,
                  controller: _phoneNumberController,
                ),
                const SizedBox(height: 10.0),
                const CustomText(
                  "Gender",
                  label: 'Gender',
                  fontSize: 18.0,
                ),
                DropdownButton<String>(
                  value: _selectedGender,
                  hint: const Text('Select Gender'),
                  items: <String>['Male', 'Female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                ),
                const SizedBox(height: 10.0),
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                  ),
                  readOnly: true,
                  onTap: _selectDate,
                ),
                const SizedBox(height: 10.0),
                const CustomText(
                  "County",
                  label: 'County',
                  fontSize: 18.0,
                ),
                DropdownButton<String>(
                  value: _selectedCounty,
                  hint: const Text('Select County'),
                  items: <String>[
                    'Nairobi',
                    'Meru',
                    'Tharaka_Nithi',
                    'Kirinyaga',
                    'Muranga'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCounty = newValue;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _registerCustomer,
                  child: const Text('Register Customer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
