// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sacco_teller/constants.dart';
import 'api_service.dart';

class TellerPage extends StatefulWidget {
  const TellerPage({super.key});

  @override
  State<TellerPage> createState() => _TellerPageState();
}

class _TellerPageState extends State<TellerPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoggedIn = false;
  final ApiService _apiService =
      ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  int _totalRegisteredUsers = 0;
  double _totalSaccoAccountBalance = 0.0;
  List<Map<String, dynamic>> _individualAccounts = [];

  void _login() async {
    const String testUsername = 'admin';
    const String testPassword = 'password123';

    if (_usernameController.text == testUsername &&
        _passwordController.text == testPassword) {
      setState(() {
        _isLoggedIn = true;
      });
      _fetchAccountInfo();
    } else {
      // Handle login failure
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  void _fetchAccountInfo() async {
    try {
      final accountInfo = await _apiService.fetchAccountInfo();
      setState(() {
        _totalRegisteredUsers = accountInfo['totalRegisteredUsers'];
        _totalSaccoAccountBalance = accountInfo['totalSaccoAccountBalance'];
        _individualAccounts =
            List<Map<String, dynamic>>.from(accountInfo['individualAccounts']);
      });
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Widget _loginForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _login,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  Widget _accountInfo() {
    return Column(
      children: [
        ListTile(
          title: const Text('Total Registered Users'),
          subtitle: Text('$_totalRegisteredUsers'),
        ),
        ListTile(
          title: const Text('Total SACCO Account Balance'),
          subtitle: Text('Ksh $_totalSaccoAccountBalance'),
        ),
        const Divider(),
        const Text('Individual Account Balances',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Divider(),
        ..._individualAccounts.map((account) {
          return ListTile(
            title: Text(account['name']),
            subtitle: Text('Ksh ${account['balance']}'),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Teller Login',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: Container(
        color: Colors.white,
        child: _isLoggedIn ? _accountInfo() : _loginForm(),
      ),
    );
  }
}
