import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String doctorName;
  final String doctorSpecialty;
  final String selectedDate;
  final String selectedTime;
  final String patientType;
  final String fullName;
  final String age;
  final String gender;
  final String problem;

  const DetailsScreen({
    super.key,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.selectedDate,
    required this.selectedTime,
    required this.patientType,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.problem,
  });

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
          'Details',
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
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Appointment',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6C63FF),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildDoctorInfoCard(),
                  const SizedBox(height: 20),
                  _buildDateConfirmedSection(),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey, thickness: 0.5), // Separator
                  const SizedBox(height: 20),
                  _buildDetailRow('Booking For', patientType),
                  const SizedBox(height: 10),
                  _buildDetailRow('Full Name', fullName),
                  const SizedBox(height: 10),
                  _buildDetailRow('Age', age),
                  const SizedBox(height: 10),
                  _buildDetailRow('Gender', gender),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey, thickness: 0.5), // Separator
                  const SizedBox(height: 20),
                  const Text(
                    'Problem',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    problem.isNotEmpty ? problem : 'No problem described.',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildDoctorInfoCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0FF), // Light purple background
        borderRadius: BorderRadius.circular(20),
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
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFFCAD6FF),
            child: Icon(Icons.person_outline, color: Colors.blueGrey, size: 30),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C63FF),
                  ),
                ),
                Text(
                  doctorSpecialty,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8B85E1),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 5),
                    const Text('5', style: TextStyle(fontSize: 14, color: Color(0xFF6C63FF))), // Static rating for now
                    const SizedBox(width: 15),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Text('Q', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF6C63FF))),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text('60', style: TextStyle(fontSize: 14, color: Color(0xFF6C63FF))), // Static consultations
                    const Spacer(),
                    const Icon(Icons.favorite_border, color: Color(0xFF6C63FF), size: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateConfirmedSection() {
    return Container(
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
                'Month 24, Year', 
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                selectedDate + ' - ' + selectedTime,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C63FF),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 24),
                padding: const EdgeInsets.all(5),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Icon(Icons.close_rounded, color: Colors.red, size: 24),
                padding: const EdgeInsets.all(5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
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