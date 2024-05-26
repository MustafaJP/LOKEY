import 'package:flutter/material.dart';
import 'package:lokey/model/output_arguments.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class UserForm extends StatefulWidget {
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  String? selectedJobType;
  String? selectedMonth;
  List<TextEditingController> _monthlyExpensesControllers = [];

  List<String> jobTypes = [
    'Arts',
    'Social Science',
    'Dental',
    'Medicine',
    'Law',
    'Sciences',
    'Business',
    'Computing',
    'Engineering',
    'Music',
    'Real estate'
  ];

  List<String> months = List.generate(12, (index) => (index + 1).toString());

  List<Widget> _buildMonthlyExpensesFields(int count) {
    _monthlyExpensesControllers =
        List.generate(count, (index) => TextEditingController());
    List<Widget> fields = [];
    for (int i = 0; i < count; i++) {
      fields.add(
        TextFormField(
          controller: _monthlyExpensesControllers[i],
          decoration: InputDecoration(
            labelText: 'Enter your monthly expenses for month ${i + 1}:',
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      );
      fields.add(const SizedBox(height: 20));
    }
    return fields;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Get form data
      int annualIncome = int.parse(_annualIncomeController.text);
      int totalExpenses = 0;
      int numberOfMonths = int.parse(selectedMonth ?? '0');
      for (TextEditingController controller in _monthlyExpensesControllers) {
        totalExpenses += int.parse(controller.text);
      }
      int averageMonthlyExpenses = totalExpenses ~/ numberOfMonths;
      int emergencyFund = int.parse(
          _emergencyFundController.text); // Fetch user input for emergency fund
      String jobType = selectedJobType!;
      int dependencies = int.parse(_dependenciesController.text);

      // Prepare the API request body
      Map<String, dynamic> requestBody = {
        'Your Job': jobType,
        'Your Income': annualIncome.toString(),
        'Your monthly expenses': averageMonthlyExpenses.toString(),
        'Number of your dependents': dependencies.toString(),
        'How much do you wish to spend': emergencyFund.toString()
      };

      // Make API call
      String apiUrl =
          'https://predict-emergency-okxwdijwqq-as.a.run.app/predict_emergency_fund';
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          debugPrint('Response: ${response.body}');
          // Navigate to the '/output' route and pass the response data
          Navigator.pushNamed(
            context,
            '/output',
            arguments: OutputArguments(emergencyFund,
                response.body), // Pass user input as actualEmergencyFunds
          );
        } else {
          debugPrint('Failed to submit data: ${response.statusCode}');
        }
      } catch (e) {
        debugPrint('Error: $e');
      }
    }
  }

  final TextEditingController _annualIncomeController = TextEditingController();
  final TextEditingController _emergencyFundController =
      TextEditingController();
  final TextEditingController _dependenciesController = TextEditingController();

  @override
  void dispose() {
    _annualIncomeController.dispose();
    _emergencyFundController.dispose();
    _dependenciesController.dispose();
    for (TextEditingController controller in _monthlyExpensesControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _annualIncomeController,
                decoration: const InputDecoration(
                  labelText: 'Enter your annual income:',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedMonth, // Set the value of the dropdown
                onChanged: (value) {
                  setState(() {
                    selectedMonth = value; // Update the selected value
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Select number of monthly expenses (1-12):',
                ),
                items: months.map((String month) {
                  return DropdownMenuItem<String>(
                    value: month,
                    child: Text(month),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Field required' : null,
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: selectedMonth != null,
                child: Column(
                  children: [
                    ..._buildMonthlyExpensesFields(
                        int.parse(selectedMonth ?? '0')),
                  ],
                ),
              ),
              TextFormField(
                controller: _emergencyFundController,
                decoration: const InputDecoration(
                  labelText: 'Enter your current emergency fund:',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedJobType, // Set the value of the dropdown
                onChanged: (value) {
                  setState(() {
                    selectedJobType = value; // Update the selected value
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Select your job type:',
                ),
                items: jobTypes.map((String jobType) {
                  return DropdownMenuItem<String>(
                    value: jobType,
                    child: Text(jobType),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Field required' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _dependenciesController,
                decoration: const InputDecoration(
                  labelText: 'Enter your dependencies:',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
