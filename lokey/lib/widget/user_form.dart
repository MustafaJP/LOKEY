import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  String? selectedJobType;
  String? selectedMonth;

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

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

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
                  labelText: 'Select number of months (1-12):',
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
              TextFormField(
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
                  if (_formKey.currentState!.validate()) {
                    const SnackBar(content: Text('Processing Data'));
                    //submit it to API
                    Navigator.pushNamed(context, '/output');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}