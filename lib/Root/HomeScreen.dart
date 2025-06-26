import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
// Make sure to import your new appointment screen
import 'package:swe3001/Root/Appointment.dart';
import 'package:swe3001/Doctor/DoctorPage.dart';
import 'package:swe3001/Root/RecordHealthMetric.dart';
import 'package:swe3001/Root/Reminder.dart'; //

class MedicalDashboardScreen extends StatefulWidget {
  const MedicalDashboardScreen({super.key});

  @override
  State<MedicalDashboardScreen> createState() => _MedicalDashboardScreenState();
}

class _MedicalDashboardScreenState extends State<MedicalDashboardScreen> {
  int _selectedIndex = 0; // Current bottom nav bar index
  int _selectedDateIndex = 2; // Index for "11 WED"

  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Ivan, M.D.',
      'specialty': 'Orthopedic',
      'rating': '5',
      'consultations': '60',
    },
    {
      'name': 'Dr. Desmond, Ph.D.',
      'specialty': 'Eye specialist',
      'rating': '4.5',
      'consultations': '40',
    },
    {
      'name': 'Dr. Logith, Ph.D.',
      'specialty': 'Cardiologist',
      'rating': '5',
      'consultations': '150',
    },
    {
      'name': 'Dr. Raymond, M.D.',
      'specialty': 'Endocrinologist',
      'rating': '4.8',
      'consultations': '90',
    },
  ];

  // Define the list of widgets for each tab
  late final List<Widget> _pages; //

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      _buildDashboardBody(), //
      const RecordHealthMetricsScreen(),
      const SetReminderScreen(),
      const AllAppointmentsScreen(), //
    ];
  }

  // In _MedicalDashboardScreenState class

Widget _buildDashboardBody() {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // MARK: Header Section
        _buildHeader(),
        const SizedBox(height: 20),

        // MARK: Navigation/Filter Bar
        _buildFilterAndSearchBar(),
        const SizedBox(height: 20),

        // MARK: Date Selector
        _buildDateSelector(),
        const SizedBox(height: 20),

        // MARK: Appointment Card
        _buildAppointmentCard(),
        const SizedBox(height: 20),

        // MARK: Doctors List
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: doctors.map((doctor) {
              return DoctorCard(
                name: doctor['name']!,
                specialty: doctor['specialty']!,
                rating: double.parse(doctor['rating']!),
                consultations: int.parse(doctor['consultations']!),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F7), // Light background color
      body: SafeArea(
        // Use IndexedStack to switch between pages based on _selectedIndex
        child: IndexedStack(
          index: _selectedIndex, //
          children: _pages, //
        ),
      ),
      // MARK: Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Your existing _buildHeader, _buildFilterAndSearchBar, _buildFilterButton,
  // _buildDateSelector, _buildAppointmentCard, _buildTimeSlot methods go here...
  // (Copy-paste them from your original code)
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/default.png'), // Your profile image
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Hi, WelcomeBack',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2260FF),
                ),
              ),
              Text(
                'User',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFCAD6FF)
            ),
            child: IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 4,),
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFCAD6FF)
            ),
            child: IconButton(
              icon: const Icon(Icons.settings_outlined, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterAndSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFilterButton(
            'Doctors', 
            Icons.local_hospital, 
            true, 
            (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DoctorsScreen(appBarTitle: 'Doctors'),
                ),
              );
            }),
          SizedBox(width: 8,),
          _buildFilterButton('Favorite', Icons.favorite_border, true, (){}),
          SizedBox(width: 8,),
          _buildFilterButton('SOS', Icons.person, true, (){}),
          const Spacer(), 
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
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
            child: const Icon(Icons.tune, color: Color(0xFF6C63FF)),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
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
            child: const Icon(Icons.search, color: Color(0xFF6C63FF)),
          ),
        ],
      ),
    );
  }

Widget _buildFilterButton(String text, IconData icon, bool isSelected, VoidCallback onTap) {
  return GestureDetector( 
    onTap: onTap, 
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
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
          child: Icon(
            icon,
            color: isSelected ? Colors.white : const Color(0xFF6C63FF),
            size: 24,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? const Color(0xFF6C63FF) : Colors.grey,
          ),
        ),
      ],
    ),
  );
}

  Widget _buildDateSelector() {
    final List<Map<String, String>> dates = [
      {'dayNum': '9', 'dayText': 'MON'},
      {'dayNum': '10', 'dayText': 'TUE'},
      {'dayNum': '11', 'dayText': 'WED'},
      {'dayNum': '12', 'dayText': 'THU'},
      {'dayNum': '13', 'dayText': 'FRI'},
      {'dayNum': '14', 'dayText': 'SAT'},
    ];

    return SizedBox(
      height: 90, // Height for the horizontal ListView
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          final isToday = index == _selectedDateIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDateIndex = index;
              });
            },
            child: Container(
              width: 60,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isToday ? const Color(0xFF6C63FF) : Colors.white,
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
                    dates[index]['dayNum']!,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isToday ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    dates[index]['dayText']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: isToday ? Colors.white : Colors.grey,
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

  Widget _buildAppointmentCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
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
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              '11 Wednesday - Today',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 5),
          _buildTimeSlot('9 AM'),
          _buildTimeSlot('10 AM',
              hasAppointment: true,
              doctorName: 'Dr. Ivan, M.D.',
              description: 'Treatment for leg pain.'),
          _buildTimeSlot('11 AM'),
          _buildTimeSlot('12 AM'),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(String time, {bool hasAppointment = false, String? doctorName, String? description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60, // Align time vertically
            child: Text(
              time,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!hasAppointment)
                  const DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: Colors.grey,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0FF), // Light purple background
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctorName!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6C63FF),
                                ),
                              ),
                              Text(
                                description!,
                                style: const TextStyle(fontSize: 13, color: Color(0xFF6C63FF)),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.check_circle_outline, color: Color(0xFF6C63FF), size: 20),
                        const SizedBox(width: 5),
                        const Icon(Icons.close_rounded, color: Colors.red, size: 20), // Close icon
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
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
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index; // Update the selected index
            });
          },
          selectedItemColor: const Color(0xFF6C63FF),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed, // To show all items
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_note),
              label: 'Record',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.alarm_add_outlined),
              label: 'Reminder',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              label: 'Calendar', // This will now show AllAppointmentsScreen
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final double rating;
  final int consultations;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.consultations,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0FF), // Light purple background for cards
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
            name,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6C63FF),
            ),
          ),
          Text(
            specialty,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF8B85E1), // Slightly darker purple
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 5),
              Text(
                '$rating',
                style: const TextStyle(fontSize: 14, color: Color(0xFF6C63FF)),
              ),
              const SizedBox(width: 15),
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Center(
                  child: Text(
                    'Q',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6C63FF),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '$consultations',
                style: const TextStyle(fontSize: 14, color: Color(0xFF6C63FF)),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.question_mark_rounded, color: Colors.white, size: 20),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF8B85E1),
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(35, 35),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 5),
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white, size: 20),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF8B85E1),
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(35, 35),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}