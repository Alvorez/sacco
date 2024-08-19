// ignore_for_file: unused_element, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  final http.Client httpClient;

  ApiService(
      {this.baseUrl = 'https://businesscentral.coretec.co.ke:8989/',
      http.Client? client})
      : httpClient = client ?? http.Client();

  // Get Balance Report
  Future<Map<String, dynamic>> getBalanceReport(String accountNumber) async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/balanceReport?accountNumber=$accountNumber'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch balance report');
    }
  }

  // Get Mini Statements
  Future<Map<String, dynamic>> getMiniStatements(String accountNumber) async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/miniStatements?accountNumber=$accountNumber'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch mini statements');
    }
  }

  // Get Teller Balance Report
  Future<Map<String, dynamic>> getTellerBalanceReport() async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/tellerBalanceReport'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch teller balance report');
    }
  }

  // Get Teller Summary Report
  Future<Map<String, dynamic>> getTellerSummaryReport() async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/tellerSummaryReport'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch teller summary report');
    }
  }

  // Get Payment Receipt
  Future<Map<String, dynamic>> getPaymentReceipt(String transactionId) async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/paymentReceipt?transactionId=$transactionId'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch payment receipt');
    }
  }

  // User Login
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  // Register Customer
  Future<Map<String, dynamic>> registerCustomer({
    required String customerId,
    required String fullNames,
    required String phoneNumber,
    required String gender,
    required String dateOfBirth,
    required String county,
  }) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/register-customer'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'customer_id': customerId,
        'full_names': fullNames,
        'phone_number': phoneNumber,
        'gender': gender,
        'date_of_birth': dateOfBirth,
        'county': county,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register customer');
    }
  }

  // Register User
  Future<dynamic> registerUser(
    String username,
    String phoneEmail,
    String password,
  ) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'phone_email': phoneEmail,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      print('User registered successfully');
    } else {
      throw Exception('Failed to register user: ${response.body}');
    }
  }

  // Investment
  Future<dynamic> invest(double investmentAmount, String investmentDetails) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/invest'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'investment_amount': investmentAmount,
        'investment_details': investmentDetails,
      }),
    );
    if (response.statusCode == 200) {
      print('Investment successful');
    } else {
      throw Exception('Failed to invest: ${response.body}');
    }
  }

  // Withdraw
  Future<dynamic> withdraw(accountNumber, double amount) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/withdraw'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'account_number': accountNumber,
        'amount': amount,
      }),
    );
    if (response.statusCode == 200) {
      print('Withdrawal successful');
    } else {
      throw Exception('Failed to withdraw: ${response.body}');
    }
  }

  // Check Balance
  Future<Map<String, dynamic>> checkBalance(String accountNumber) async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/checkBalance?accountNumber=$accountNumber'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to check balance');
    }
  }

  // Deposit
  Future<dynamic> deposit(String accountNumber, double amount) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/deposit'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'account_number': accountNumber,
        'amount': amount,
      }),
    );
    if (response.statusCode == 200) {
      print('Deposit successful');
    } else {
      throw Exception('Failed to deposit: ${response.body}');
    }
  }

  // Get Mini Statement
  Future<Map<String, dynamic>> getMiniStatement(String accountNumber) async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/miniStatement?accountNumber=$accountNumber'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get mini statement');
    }
  }

  // Pay Bill
  Future<dynamic> payBill(
      String accountNumber, String billDetails, double amount) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/payBill'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'account_number': accountNumber,
        'bill_details': billDetails,
        'amount': amount,
      }),
    );
    if (response.statusCode == 200) {
      print('Bill payment successful');
    } else {
      throw Exception('Failed to pay bill: ${response.body}');
    }
  }

  // Purchase Airtime
  Future<dynamic> purchaseAirtime(String phoneNumber, double amount) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/purchaseAirtime'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'phone_number': phoneNumber,
        'amount': amount,
      }),
    );
    if (response.statusCode == 200) {
      print('Airtime purchase successful');
    } else {
      throw Exception('Failed to purchase airtime: ${response.body}');
    }
  }

  // Transfer Funds
  Future<dynamic> transferFunds(
      String sourceAccount, String destinationAccount, double amount) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/transferFunds'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'source_account': sourceAccount,
        'destination_account': destinationAccount,
        'amount': amount,
      }),
    );
    if (response.statusCode == 200) {
      print('Funds transferred successfully');
    } else {
      throw Exception('Failed to transfer funds: ${response.body}');
    }
  }

  // Fetch Account Info
  Future<Map<String, dynamic>> fetchAccountInfo() async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/accountInfo'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch account info');
    }
  }

  // Apply for Sacco Membership
  Future<dynamic> applyForSaccoMembership(String name, String email, String phone,
      String address, String idNumber) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/applyForSaccoMembership'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'id_number': idNumber,
      }),
    );
    if (response.statusCode == 200) {
      print('Sacco membership application successful');
    } else {
      throw Exception('Failed to apply for Sacco membership: ${response.body}');
    }
  }

  // Apply for Standing Order
  Future<dynamic> applyForStandingOrder(String name, String accountNumber,
      String amount, String frequency) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/applyForStandingOrder'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'account_number': accountNumber,
        'amount': amount,
        'frequency': frequency,
      }),
    );
    if (response.statusCode == 200) {
      print('Standing order application successful');
    } else {
      throw Exception('Failed to apply for standing order: ${response.body}');
    }
  }

  // Apply for ATM Card
  Future<dynamic> applyForATMCard(
      String name, String accountNumber, String address) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/applyForATMCard'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'account_number': accountNumber,
        'address': address,
      }),
    );
    if (response.statusCode == 200) {
      print('ATM card application successful');
    } else {
      throw Exception('Failed to apply for ATM card: ${response.body}');
    }
  }
}
