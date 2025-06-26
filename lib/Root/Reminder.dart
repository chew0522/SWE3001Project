// lib/set_reminder_screen.dart
import 'package:flutter/material.dart';
import 'package:swe3001/Root/HomeScreen.dart';

class SetReminderScreen extends StatefulWidget {
  const SetReminderScreen({super.key});

  @override
  State<SetReminderScreen> createState() => _SetReminderScreenState();
}

class _SetReminderScreenState extends State<SetReminderScreen> {
  // --- Reminder Type State ---
  String _selectedReminderType = 'Medicine'; // Default to Medicine

  // --- Time Picker State ---
  TimeOfDay _selectedTime = TimeOfDay.now(); // Default to current time

  // --- Medicine Reminder Specific States ---
  final TextEditingController _medicineNameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();

  // --- Hydration Reminder Specific States ---
  String _hydrationInterval = 'Every 2 hours'; // Default hydration interval
  final List<String> _hydrationIntervals = [
    'Every 30 mins', 'Every 1 hour', 'Every 2 hours', 'Every 3 hours', 'Custom'
  ];
  final TextEditingController _hydrationAmountController = TextEditingController(); // For custom amount

  // --- Common Reminder Notes State ---
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _medicineNameController.dispose();
    _dosageController.dispose();
    _hydrationAmountController.dispose();
    _notesController.dispose();
    super.dispose();
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
          'Set Reminder',
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
            // --- Reminder Type Selector ---
            _buildSectionTitle('Reminder Type'),
            const SizedBox(height: 10),
            _buildReminderTypeSelector(),
            const SizedBox(height: 20),

            // --- Set Time ---
            _buildSectionTitle('Time'),
            const SizedBox(height: 10),
            _buildTimePicker(),
            const SizedBox(height: 20),

            // --- Conditional Reminder Details ---
            if (_selectedReminderType == 'Medicine')
              _buildMedicineReminderFields()
            else
              _buildHydrationReminderFields(),
            const SizedBox(height: 20),

            // --- Notes ---
            _buildSectionTitle('Notes (Optional)'),
            const SizedBox(height: 10),
            _buildNotesField(),
            const SizedBox(height: 30),

            // --- Save Reminder Button ---
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

  Widget _buildReminderTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildTypeButton(
            'Medicine',
            _selectedReminderType == 'Medicine',
            () {
              setState(() {
                _selectedReminderType = 'Medicine';
              });
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildTypeButton(
            'Hydration',
            _selectedReminderType == 'Hydration',
            () {
              setState(() {
                _selectedReminderType = 'Hydration';
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTypeButton(String type, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6C63FF) : Colors.white,
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
        child: Center(
          child: Text(
            type,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF6C63FF),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return GestureDetector(
      onTap: () => _selectTime(context),
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
            Text(
              _selectedTime.format(context),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6C63FF),
              ),
            ),
            const Icon(Icons.access_time, color: Color(0xFF6C63FF)),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineReminderFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Medicine Details'),
        const SizedBox(height: 10),
        _buildTextField(
          controller: _medicineNameController,
          hintText: 'e.g., Paracetamol',
          labelText: 'Medicine Name',
        ),
        const SizedBox(height: 15),
        _buildTextField(
          controller: _dosageController,
          hintText: 'e.g., 500 mg, 1 tablet',
          labelText: 'Dosage',
        ),
      ],
    );
  }

  Widget _buildHydrationReminderFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Hydration Details'),
        const SizedBox(height: 10),
        _buildDropdownField(
          labelText: 'Interval',
          value: _hydrationInterval,
          items: _hydrationIntervals,
          onChanged: (String? newValue) {
            setState(() {
              _hydrationInterval = newValue!;
            });
          },
        ),
        if (_hydrationInterval == 'Custom') ...[
          const SizedBox(height: 15),
          _buildTextField(
            controller: _hydrationAmountController,
            hintText: 'e.g., 200 ml, 1 glass',
            labelText: 'Amount (Custom)',
            keyboardType: TextInputType.text, // Could be number for ml, but text for 'glass'
          ),
        ],
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
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

  Widget _buildDropdownField({
    required String labelText,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF6C63FF)),
          elevation: 16,
          style: const TextStyle(color: Color(0xFF6C63FF), fontSize: 16, fontWeight: FontWeight.w500),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNotesField() {
    return TextField(
      controller: _notesController,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Add any specific instructions or details...',
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
        onPressed: () {
          // TODO: Implement reminder saving logic here
          // You would typically collect all the state variables:
          // _selectedReminderType, _selectedTime, _medicineNameController.text,
          // _dosageController.text, _hydrationInterval, _hydrationAmountController.text,
          // _notesController.text
          // And then pass them to a reminder service or save them locally.

          String message = 'Reminder set for $_selectedReminderType at ${_selectedTime.format(context)}.\n';
          if (_selectedReminderType == 'Medicine') {
            message += 'Medicine: ${_medicineNameController.text}, Dosage: ${_dosageController.text}\n';
          } else {
            message += 'Interval: $_hydrationInterval';
            if (_hydrationInterval == 'Custom') {
              message += ', Amount: ${_hydrationAmountController.text}\n';
            } else {
              message += '\n';
            }
          }
          if (_notesController.text.isNotEmpty) {
            message += 'Notes: ${_notesController.text}';
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Reminder Saved!\n$message'),
              duration: const Duration(seconds: 3),
            ),
          );

          // Optionally, pop back to the previous screen after saving
          // Navigator.pop(context);
        },
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
          'Save Reminder',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}