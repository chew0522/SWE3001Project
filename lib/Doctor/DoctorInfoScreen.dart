import 'package:flutter/material.dart';
import 'package:swe3001/Schedule/ScheduleScreen.dart'; 

class DoctorInfoScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorInfoScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F7), // Consistent light grey background
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen (DoctorsScreen)
          },
        ),
        title: const Text(
          'Doctor Info',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0, // No shadow
        toolbarHeight: 80, // Taller AppBar as per design
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0FF), 
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${doctor['experience']} years',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6C63FF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
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
                              doctor['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6C63FF),
                              ),
                            ),
                            Text(
                              doctor['specialty'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8B85E1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity, 
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Focus:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6C63FF),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          doctor['focus'],
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetricColumn(
                        icon: Icons.star,
                        value: '${doctor['rating']}',
                        label: 'Rating',
                        iconColor: Colors.amber,
                        valueColor: const Color(0xFF6C63FF),
                      ),
                      _buildMetricColumn(
                        icon: Icons.question_mark_rounded,
                        value: '${doctor['consultations']}',
                        label: 'Consultations',
                        iconColor: const Color(0xFF6C63FF),
                        valueColor: const Color(0xFF6C63FF),
                      ),
                      _buildMetricColumn(
                        icon: Icons.access_time,
                        value: doctor['schedule'],
                        label: 'Schedule',
                        iconColor: const Color(0xFF6C63FF),
                        valueColor: const Color(0xFF6C63FF),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => ScheduleScreen(
                            doctorName: doctor['name'], doctorSpecialty: doctor['specialty'])));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C63FF), 
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      child: const Text('Schedule'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionHeader('Profile'),
            const SizedBox(height: 10),
            Text(
              doctor['profile_desc'],
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildSectionHeader('Career Path'),
            const SizedBox(height: 10),
            Text(
              doctor['career_path_desc'],
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildSectionHeader('Highlights'),
            const SizedBox(height: 10),
            Text(
              doctor['highlights'],
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricColumn({
    required IconData icon,
    required String value,
    required String label,
    required Color iconColor,
    required Color valueColor,
  }) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade800,
      ),
    );
  }
}