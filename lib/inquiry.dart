// ignore_for_file: unnecessary_import, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sacco_teller/api_service.dart';
import 'package:sacco_teller/constants.dart';

class ReportsSelectionPage extends StatelessWidget {
  const ReportsSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Select Report'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appBlack,
        titleTextStyle: const TextStyle(
          color: appWhite,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _reportItem(
                context, 'Balance Inquiry', Icons.monetization_on, const BalanceReportPage()),
            _reportItem(context, 'Ministatements', Icons.receipt,
                const MinistatementsReportPage()),
            _reportItem(context, 'Teller Summary', Icons.receipt_long_sharp,
                const TellerBalanceReportPage()),
            _reportItem(context, 'Teller Balance', Icons.account_balance,
                const TellerSummaryReportPage()),
            _reportItem(
                context, 'Payment Receipt', Icons.receipt_long, const PaymentReceiptPage()),
          ],
        ),
      ),
    );
  }

  Widget _reportItem(
      BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: primaryColor),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
      ),
    );
  }
}

class BalanceReportPage extends StatefulWidget {
  const BalanceReportPage({super.key});

  @override
  State<BalanceReportPage> createState() => _BalanceReportPageState();
}

class _BalanceReportPageState extends State<BalanceReportPage> {
  final _accountNumberController = TextEditingController();
  final ApiService _apiService = ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  String _report = '';

  void _fetchBalanceReport() async {
    final accountNumber = _accountNumberController.text;

    if (accountNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an account number')),
      );
      return;
    }

    try {
      final response = await _apiService.getBalanceReport(accountNumber);
      setState(() {
        _report = response['report'];
      });
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
        title: const Text('Balance Report', style: TextStyle(color: appWhite)),
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
              controller: _accountNumberController,
              decoration: const InputDecoration(labelText: 'Account Number'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchBalanceReport,
              child: const Text('Fetch Report'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_report),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MinistatementsReportPage extends StatefulWidget {
  const MinistatementsReportPage({super.key});

  @override
  State<MinistatementsReportPage> createState() =>
      _MinistatementsReportPageState();
}

class _MinistatementsReportPageState extends State<MinistatementsReportPage> {
  final _accountNumberController = TextEditingController();
  final ApiService _apiService = ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  String _report = '';

  void _fetchMiniStatements() async {
    final accountNumber = _accountNumberController.text;

    if (accountNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an account number')),
      );
      return;
    }

    try {
      final response = await _apiService.getMiniStatements(accountNumber);
      setState(() {
        _report = response['report'];
      });
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
        title: const Text('Mini Statements', style: TextStyle(color: appWhite)),
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
              controller: _accountNumberController,
              decoration: const InputDecoration(labelText: 'Account Number'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchMiniStatements,
              child: const Text('Fetch Statements'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_report),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TellerBalanceReportPage extends StatefulWidget {
  const TellerBalanceReportPage({super.key});

  @override
  State<TellerBalanceReportPage> createState() =>
      _TellerBalanceReportPageState();
}

class _TellerBalanceReportPageState extends State<TellerBalanceReportPage> {
  final ApiService _apiService = ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  String _report = '';

  void _fetchTellerBalanceReport() async {
    try {
      final response = await _apiService.getTellerBalanceReport();
      setState(() {
        _report = response['report'];
      });
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
        title: const Text('Teller Balance Report',
            style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _fetchTellerBalanceReport,
              child: const Text('Fetch Report'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_report),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class TellerSummaryReportPage extends StatefulWidget {
  const TellerSummaryReportPage({super.key});

  @override
  State<TellerSummaryReportPage> createState() =>
      _TellerSummaryReportPageState();
}

class _TellerSummaryReportPageState extends State<TellerSummaryReportPage> {
  final ApiService _apiService = ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  String _report = '';

  void _fetchTellerSummaryReport() async {
    try {
      final response = await _apiService.getTellerSummaryReport();
      setState(() {
        _report = response['report'];
      });
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
        title: const Text('Teller Summary Report',
            style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _fetchTellerSummaryReport,
              child: const Text('Fetch Report'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_report),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentReceiptPage extends StatefulWidget {
  const PaymentReceiptPage({super.key});

  @override
  State<PaymentReceiptPage> createState() => _PaymentReceiptPageState();
}

class _PaymentReceiptPageState extends State<PaymentReceiptPage> {
  final _transactionIdController = TextEditingController();
  final ApiService _apiService = ApiService(baseUrl: 'https://businesscentral.coretec.co.ke:8989/');

  String _receipt = '';

  void _fetchPaymentReceipt() async {
    final transactionId = _transactionIdController.text;

    if (transactionId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a transaction ID')),
      );
      return;
    }

    try {
      final response = await _apiService.getPaymentReceipt(transactionId);
      setState(() {
        _receipt = response['receipt'];
      });
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
        title: const Text('Payment Receipt', style: TextStyle(color: appWhite)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: appWhite,
      ),
      body:Container(
        color:Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _transactionIdController,
              decoration: const InputDecoration(labelText: 'Transaction ID'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchPaymentReceipt,
              child: const Text('Fetch Receipt'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_receipt),
              ),
            ),
          ],
        ),
       ),
      )
    ;
  }
}
