// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sacco_teller/api_service.dart';
import 'package:sacco_teller/constants.dart';

class ApplicationSelectionPage extends StatelessWidget {
  const ApplicationSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Select Application Type',
            style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
        titleTextStyle: const TextStyle(
          color: appWhite,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _applicationItem(
                context,
                'Apply for Sacco Membership',
                CupertinoIcons.person_add,
                const SaccoApplicationPage(),
              ),
              const SizedBox(height: 20.0),
              _applicationItem(
                context,
                'Apply for ATM Card',
                CupertinoIcons.creditcard,
                const ATMApplicationPage(),
              ),
              const SizedBox(height: 20.0),
              _applicationItem(
                context,
                'Apply for Standing Order',
                CupertinoIcons.doc_text_fill,
                const StandingOrderApplicationPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _applicationItem(
      BuildContext context, String title, IconData icon, Widget page) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0), backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: appWhite),
          const SizedBox(width: 10.0),
          Text(
            title,
            style: const TextStyle(fontSize: 18.0, color: appWhite),
          ),
        ],
      ),
    );
  }
}

class SaccoApplicationPage extends StatefulWidget {
  const SaccoApplicationPage({super.key});

  @override
  State<SaccoApplicationPage> createState() => _SaccoApplicationPageState();
}

class _SaccoApplicationPageState extends State<SaccoApplicationPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _idNumberController = TextEditingController();
  final ApiService _apiService =
      ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  void _applyForSaccoMembership() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    final address = _addressController.text;
    final idNumber = _idNumberController.text;

    try {
      final response = await _apiService.applyForSaccoMembership(
        name,
        email,
        phone,
        address,
        idNumber,
      );
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Sacco membership application submitted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit application')),
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
        title: const Text('Sacco Membership Application',
            style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _idNumberController,
              decoration: const InputDecoration(labelText: 'ID Number'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _applyForSaccoMembership,
                child: const Text('Apply'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ATMApplicationPage extends StatefulWidget {
  const ATMApplicationPage({super.key});

  @override
  State<ATMApplicationPage> createState() => _ATMApplicationPageState();
}

class _ATMApplicationPageState extends State<ATMApplicationPage> {
  final _nameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final ApiService _apiService =
      ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  void _applyForATMCard() async {
    final name = _nameController.text;
    final accountNumber = _accountNumberController.text;
    final address = _addressController.text;

    try {
      final response =
          await _apiService.applyForATMCard(name, accountNumber, address);
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('ATM card application submitted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit application')),
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
        title: const Text('ATM Card Application',
            style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _accountNumberController,
              decoration: const InputDecoration(labelText: 'Account Number'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _applyForATMCard,
                child: const Text('Apply'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StandingOrderApplicationPage extends StatefulWidget {
  const StandingOrderApplicationPage({super.key});

  @override
  State<StandingOrderApplicationPage> createState() =>
      _StandingOrderApplicationPageState();
}

class _StandingOrderApplicationPageState
    extends State<StandingOrderApplicationPage> {
  final _nameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final _frequencyController = TextEditingController();
  final ApiService _apiService =
      ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  void _applyForStandingOrder() async {
    final name = _nameController.text;
    final accountNumber = _accountNumberController.text;
    final amount = _amountController.text;
    final frequency = _frequencyController.text;

    try {
      final response = await _apiService.applyForStandingOrder(
        name,
        accountNumber,
        amount,
        frequency,
      );
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Standing order application submitted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit application')),
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
        title: const Text('Standing Order Application',
            style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _accountNumberController,
              decoration: const InputDecoration(labelText: 'Account Number'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              controller: _frequencyController,
              decoration: const InputDecoration(labelText: 'Frequency'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _applyForStandingOrder,
                child: const Text('Apply'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
