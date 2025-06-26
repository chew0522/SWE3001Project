// lib/all_appointments_screen.dart
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:swe3001/Root/HomeScreen.dart';

// --- Data Model ---
enum AppointmentStatus { complete, upcoming, cancelled }

class Appointment {
  final String doctorName;
  final String specialty;
  final double? rating; // Nullable for upcoming/cancelled
  final AppointmentStatus status;
  final String? date; // For upcoming appointments
  final String? time; // For upcoming appointments
  final String? note; // For upcoming/cancelled
  final Color cardColor; // Custom color for the card

  Appointment({
    required this.doctorName,
    required this.specialty,
    this.rating,
    required this.status,
    this.date,
    this.time,
    this.note,
    this.cardColor = const Color(0xFFE0E0FF), // Default light purple
  });
}

// --- AllAppointmentsScreen Widget ---
class AllAppointmentsScreen extends StatefulWidget {
  const AllAppointmentsScreen({super.key});

  @override
  State<AllAppointmentsScreen> createState() => _AllAppointmentsScreenState();
}

class _AllAppointmentsScreenState extends State<AllAppointmentsScreen> {
  AppointmentStatus _selectedStatus = AppointmentStatus.upcoming; // Default to Upcoming

  // Sample Data (mimicking the image)
  final List<Appointment> _allAppointments = [
    // --- Upcoming Appointments ---
    Appointment(
      doctorName: 'Dr. Ivan, M.D.',
      specialty: 'Dermato-Endocrinology',
      status: AppointmentStatus.upcoming,
      date: 'Sunday, 12 June',
      time: '9:30 AM - 10:00 AM',
      note: 'Routine Checkup',
      cardColor: const Color(0xFFE0E0FF),
    ),
    Appointment(
      doctorName: 'Dr. Desmond, Ph.D.',
      specialty: 'Dermato-Genetics',
      status: AppointmentStatus.upcoming,
      date: 'Friday, 20 June',
      time: '2:30 PM - 3:00 PM',
      note: 'Follow-up',
      cardColor: const Color(0xFFE0E0FF),
    ),
    Appointment(
      doctorName: 'Dr. Raymond, Ph.D.',
      specialty: 'Cosmetic Bioengineering',
      status: AppointmentStatus.upcoming,
      date: 'Tuesday, 15 June',
      time: '9:30 AM - 10:00 AM',
      note: 'Initial Consultation',
      cardColor: const Color(0xFFE0E0FF),
    ),
    // --- Complete Appointments ---
    Appointment(
      doctorName: 'Dr. Ivan, M.D.',
      specialty: 'Orthopedic',
      rating: 5.0,
      status: AppointmentStatus.complete,
      cardColor: const Color(0xFFE0E0FF),
    ),
    Appointment(
      doctorName: 'Dr. Desmond, Ph.D.',
      specialty: 'Eye Specialist',
      rating: 4.0,
      status: AppointmentStatus.complete,
      cardColor: const Color(0xFFE0E0FF),
    ),
    Appointment(
      doctorName: 'Dr. Raymond, Ph.D.',
      specialty: 'Orthopedic',
      rating: 5.0,
      status: AppointmentStatus.complete,
      cardColor: const Color(0xFFE0E0FF),
    ),
    Appointment(
      doctorName: 'Dr. Olivia Turner, M.D',
      specialty: 'Dermatologist',
      rating: 4.5,
      status: AppointmentStatus.complete,
      cardColor: const Color(0xFFE0E0FF),
    ),
    // --- Cancelled Appointments ---
    Appointment(
      doctorName: 'Dr. Ivan, M.D.',
      specialty: 'Dermato-Endocrinology',
      status: AppointmentStatus.cancelled,
      cardColor: const Color(0xFFE0E0FF),
    ),
    Appointment(
      doctorName: 'Dr. Desmond, Ph.D.',
      specialty: 'Dermato-Genetics',
      status: AppointmentStatus.cancelled,
      cardColor: const Color(0xFFE0E0FF),
    ),
    Appointment(
      doctorName: 'Dr. Raymond, Ph.D.',
      specialty: 'Cosmetic Bioengineering',
      status: AppointmentStatus.cancelled,
      cardColor: const Color(0xFFE0E0FF),
    ),
    Appointment(
      doctorName: 'Dr. Logith, Ph.D.',
      specialty: 'Cardiologist',
      status: AppointmentStatus.cancelled,
      cardColor: const Color(0xFFE0E0FF),
    ),
  ];

  List<Appointment> get _filteredAppointments {
    return _allAppointments.where((appt) => appt.status == _selectedStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F7), 
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MedicalDashboardScreen()),
              (Route<dynamic> route) => false, 
            );
          },
        ),
        title: const Text('All Appointment'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF0F4F7), // Match body background
        elevation: 0,
        toolbarHeight: 80, // Adjust height as needed
      ),
      body: Column(
        children: [
          _buildStatusSelection(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _filteredAppointments.length,
              itemBuilder: (context, index) {
                final appointment = _filteredAppointments[index];
                return AppointmentCard(appointment: appointment);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(5),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: AppointmentStatus.values.map((status) {
            final isSelected = status == _selectedStatus;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedStatus = status;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF6C63FF) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      status.toString().split('.').last.capitalize(), // "Complete", "Upcoming" etc.
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// --- AppointmentCard Widget ---
class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: appointment.cardColor,
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
          Text(
            appointment.doctorName,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6C63FF),
            ),
          ),
          Text(
            appointment.specialty,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF8B85E1),
            ),
          ),
          const SizedBox(height: 10),
          _buildCardSpecificContent(),
        ],
      ),
    );
  }

  Widget _buildCardSpecificContent() {
    switch (appointment.status) {
      case AppointmentStatus.complete:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 18),
                const SizedBox(width: 5),
                Text(
                  '${appointment.rating}',
                  style: const TextStyle(fontSize: 14, color: Color(0xFF6C63FF)),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6C63FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 0,
                    ),
                    child: const Text('Re-Book'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 0,
                    ),
                    child: const Text('Add Review'),
                  ),
                ),
              ],
            ),
          ],
        );
      case AppointmentStatus.upcoming:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF8B85E1)),
                const SizedBox(width: 5),
                Text(
                  appointment.date!,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF6C63FF)),
                ),
                const SizedBox(width: 15),
                const Icon(Icons.access_time, size: 16, color: Color(0xFF8B85E1)),
                const SizedBox(width: 5),
                Expanded( // Use Expanded to prevent text overflow
                  child: Text(
                    appointment.time!,
                    style: const TextStyle(fontSize: 14, color: Color(0xFF6C63FF)),
                  ),
                ),
              ],
            ),
            if (appointment.note != null) ...[
              const SizedBox(height: 8),
              DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: Colors.grey.shade400,
                dashGapLength: 4.0,
                dashGapColor: Colors.transparent,
              ),
              const SizedBox(height: 8),
              Text(
                appointment.note!,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6C63FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 0,
                    ),
                    child: const Text('Details'),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.check_circle_outline, color: Color(0xFF6C63FF)),
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(40, 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(width: 5),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.red),
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(40, 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ],
        );
      case AppointmentStatus.cancelled:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 18),
                const SizedBox(width: 5),
                // Ratings might not be applicable for cancelled, but showing as per image
                Text(
                  '${appointment.rating ?? '-'}', // Display rating if available, else '-'
                  style: const TextStyle(fontSize: 14, color: Color(0xFF6C63FF)),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 10),
            Center( // Center the button as per image
              child: SizedBox(
                width: double.infinity, // Take full width
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 0,
                  ),
                  child: const Text('Add Review'), // As per image, though "Re-Book" might be more logical
                ),
              ),
            ),
          ],
        );
    }
  }
}

// Extension to capitalize strings
extension StringCasingExtension on String {
  String capitalize() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}