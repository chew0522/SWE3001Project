import 'package:flutter/material.dart';
import 'package:swe3001/Schedule/ScheduleDetail.dart'; 

class ScheduleScreen extends StatefulWidget {
  final String doctorName; 
  final String doctorSpecialty;

  const ScheduleScreen({
    super.key,
    required this.doctorName,
    required this.doctorSpecialty,
  });

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _selectedDateIndex = 2; 
  int? _selectedTimeIndex; 
  String _selectedPatientType = 'Yourself'; 
  String _fullName = 'Sashvhant'; 
  String _age = '60'; 
  String _selectedGender = 'Female'; 
  final TextEditingController _problemController = TextEditingController();

  final List<Map<String, String>> _dates = [
    {'dayNum': '22', 'dayText': 'MON'},
    {'dayNum': '23', 'dayText': 'TUE'},
    {'dayNum': '24', 'dayText': 'WED'},
    {'dayNum': '25', 'dayText': 'THU'},
    {'dayNum': '26', 'dayText': 'FRI'},
    {'dayNum': '27', 'dayText': 'SAT'},
  ];

  final List<String> _timeSlots = [
    '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM', '11:00 AM',
    '11:30 AM', '12:00 M', '12:30 M', '1:00 PM', '1:30 PM',
    '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM', '4:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _selectedTimeIndex = _timeSlots.indexOf('1:00 PM');
  }

  @override
  void dispose() {
    _problemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F7), 
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Schedule',
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Month', 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  _buildDateSelector(),
                  const SizedBox(height: 20),

                  const Text(
                    'Available Time',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildTimeSlotsGrid(),
                  const SizedBox(height: 20),

                  const Text(
                    'Patient Details',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildPatientTypeSelector(),
                  const SizedBox(height: 15),

                  _buildTextField(
                    label: 'Full Name',
                    initialValue: _fullName,
                    onChanged: (value) => setState(() => _fullName = value),
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    label: 'Age',
                    initialValue: _age,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() => _age = value),
                  ),
                  const SizedBox(height: 15),

                  _buildGenderSelector(),
                  const SizedBox(height: 20),

                  const Text(
                    'Describe your problem',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildProblemDescriptionField(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          _buildScheduleButton(),
          const SizedBox(height: 10), 
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(), 
    );
  }

  Widget _buildDateSelector() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _dates.length + 2, // Add 2 for the arrow icons
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildArrowButton(Icons.arrow_back_ios);
          }
          if (index == _dates.length + 1) {
            return _buildArrowButton(Icons.arrow_forward_ios);
          }
          final dateIndex = index - 1;
          final isSelected = dateIndex == _selectedDateIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDateIndex = dateIndex;
              });
            },
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 5),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _dates[dateIndex]['dayNum']!,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    _dates[dateIndex]['dayText']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildArrowButton(IconData icon) {
    return Container(
      width: 40,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.grey),
      alignment: Alignment.center,
    );
  }

  Widget _buildTimeSlotsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Disable grid scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, 
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.0, 
      ),
      itemCount: _timeSlots.length,
      itemBuilder: (context, index) {
        final isSelected = index == _selectedTimeIndex;
        final bool isHighlightedInImage = (index == _timeSlots.indexOf('10:00 AM') || index == _timeSlots.indexOf('1:00 PM'));

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedTimeIndex = index;
            });
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF6C63FF)
                  : (isHighlightedInImage && _selectedTimeIndex == null) 
                      ? const Color(0xFFE0E0FF) 
                      : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: isSelected
                  ? Border.all(color: const Color(0xFF6C63FF))
                  : Border.all(color: Colors.transparent),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              _timeSlots[index],
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? Colors.white
                    : const Color(0xFF6C63FF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPatientTypeSelector() {
    return Row(
      children: [
        _buildPatientTypeButton('Yourself', _selectedPatientType == 'Yourself'),
        const SizedBox(width: 10),
        _buildPatientTypeButton('Another Person', _selectedPatientType == 'Another Person'),
      ],
    );
  }

  Widget _buildPatientTypeButton(String type, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPatientType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6C63FF) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          type,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6C63FF),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? initialValue,
    TextInputType keyboardType = TextInputType.text,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: TextEditingController(text: initialValue),
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          ),
          style: const TextStyle(color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Row(
      children: [
        _buildGenderButton('Male', _selectedGender == 'Male'),
        const SizedBox(width: 10),
        _buildGenderButton('Female', _selectedGender == 'Female'),
        const SizedBox(width: 10),
        _buildGenderButton('Other', _selectedGender == 'Other'),
      ],
    );
  }

  Widget _buildGenderButton(String gender, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6C63FF) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          gender,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6C63FF),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildProblemDescriptionField() {
    return TextField(
      controller: _problemController,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Enter Your Problem Here...',
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(15),
      ),
      style: const TextStyle(color: Colors.black87),
    );
  }

  Widget _buildScheduleButton() {
    final date = _dates[_selectedDateIndex];
  final selectedDate = '${date['dayNum'] ?? '00'} ${date['dayText'] ?? '???'}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  doctorName: widget.doctorName,
                  doctorSpecialty: widget.doctorSpecialty,
                  selectedDate: selectedDate,
                  selectedTime: _selectedTimeIndex != null ? _timeSlots[_selectedTimeIndex!] : 'Not Selected',
                  patientType: _selectedPatientType,
                  fullName: _fullName,
                  age: _age,
                  gender: _selectedGender,
                  problem: _problemController.text,
                ),
              ),
            );
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
            'Schedule',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          currentIndex: 0, 
          onTap: (index) {},
          selectedItemColor: const Color(0xFF6C63FF),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              label: 'Calendar',
            ),
          ],
        ),
      ),
    );
  }
}