// lib/record_health_metrics_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swe3001/Root/HomeScreen.dart'; // For date formatting, add to pubspec.yaml if not present

class RecordHealthMetricsScreen extends StatefulWidget {
  const RecordHealthMetricsScreen({super.key});

  @override
  State<RecordHealthMetricsScreen> createState() => _RecordHealthMetricsScreenState();
}

class _RecordHealthMetricsScreenState extends State<RecordHealthMetricsScreen> {
  final TextEditingController _bloodSugarController = TextEditingController();
  final TextEditingController _systolicBpController = TextEditingController();
  final TextEditingController _diastolicBpController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    _bloodSugarController.dispose();
    _systolicBpController.dispose();
    _diastolicBpController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6C63FF), // Purple color for picker header
              onPrimary: Colors.white, // Text color on primary
              surface: Colors.white, // Picker background
              onSurface: Colors.black, // Text color on background
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF6C63FF), // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to show time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6C63FF), // Purple color for picker header
              onPrimary: Colors.white, // Text color on primary
              surface: Colors.white, // Picker background
              onSurface: Colors.black, // Text color on background
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF6C63FF), // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveRecord() {
    // Here you would typically save the data to a database or state management
    final String bloodSugar = _bloodSugarController.text;
    final String systolicBp = _systolicBpController.text;
    final String diastolicBp = _diastolicBpController.text;
    final String notes = _notesController.text;
    final String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final String formattedTime = _selectedTime.format(context);

    // Basic validation
    if (bloodSugar.isEmpty && (systolicBp.isEmpty || diastolicBp.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter at least Blood Sugar or Blood Pressure readings.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Display a confirmation message
    String message = 'Health Record Saved!\n';
    if (bloodSugar.isNotEmpty) {
      message += 'Blood Sugar: $bloodSugar mg/dL\n';
    }
    if (systolicBp.isNotEmpty && diastolicBp.isNotEmpty) {
      message += 'Blood Pressure: $systolicBp/$diastolicBp mmHg\n';
    }
    message += 'Date: $formattedDate\n';
    message += 'Time: $formattedTime\n';
    if (notes.isNotEmpty) {
      message += 'Notes: $notes';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 4),
        backgroundColor: const Color(0xFF6C63FF),
      ),
    );

    // Optionally, clear fields or navigate back
    _bloodSugarController.clear();
    _systolicBpController.clear();
    _diastolicBpController.clear();
    _notesController.clear();
    setState(() {
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F7), // Consistent light grey background
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MedicalDashboardScreen()),
              (Route<dynamic> route) => false, 
            );
          },
        ),
        title: const Text(
          'Record Health Metrics',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Blood Sugar Section ---
            _buildSectionTitle('Blood Sugar'),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _bloodSugarController,
              labelText: 'Blood Sugar (mg/dL)',
              hintText: 'e.g., 120',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // --- Blood Pressure Section ---
            _buildSectionTitle('Blood Pressure (mmHg)'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _systolicBpController,
                    labelText: 'Systolic',
                    hintText: 'e.g., 120',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildTextField(
                    controller: _diastolicBpController,
                    labelText: 'Diastolic',
                    hintText: 'e.g., 80',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- Date and Time Section ---
            _buildSectionTitle('Date & Time of Reading'),
            const SizedBox(height: 10),
            _buildDateTimePicker(
              label: 'Date',
              value: DateFormat('yyyy-MM-dd').format(_selectedDate),
              icon: Icons.calendar_today_outlined,
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 15),
            _buildDateTimePicker(
              label: 'Time',
              value: _selectedTime.format(context),
              icon: Icons.access_time,
              onTap: () => _selectTime(context),
            ),
            const SizedBox(height: 20),

            // --- Notes Section ---
            _buildSectionTitle('Notes (Optional)'),
            const SizedBox(height: 10),
            _buildNotesField(),
            const SizedBox(height: 30),

            // --- Save Record Button ---
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
      style: const TextStyle(color: Colors.black87),
    );
  }

  Widget _buildDateTimePicker({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C63FF),
                  ),
                ),
              ],
            ),
            Icon(icon, color: const Color(0xFF6C63FF)),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesField() {
    return TextField(
      controller: _notesController,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Add any specific observations or comments...',
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(15),
      ),
      style: const TextStyle(color: Colors.black87),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveRecord,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C63FF), // Purple button
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Save Record',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}