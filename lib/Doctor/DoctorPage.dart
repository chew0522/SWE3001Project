import 'package:flutter/material.dart';
import 'DoctorInfoScreen.dart';

enum DoctorListType { doctors, favorite, rating }

class DoctorsScreen extends StatefulWidget {
  final String appBarTitle;
  final DoctorListType type;

  const DoctorsScreen({
    super.key,
    required this.appBarTitle,
    this.type = DoctorListType.doctors, 
  });

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  final List<Map<String, dynamic>> _doctors = [
    {
      'name': 'Dr. Ivan, Ph.D.',
      'specialty': 'Orthopedic',
      'rating': 5.0,
      'experience': 15,
      'consultations': 60,
      'focus': 'Treating muscular imbalances, joint pain, and other bone disorders.',
      'schedule': 'Mon-Sat / 9:00AM - 5:00PM',
      'profile_desc': 'Pain management and functional rehabilitation are central to improving quality of life. We emphasize patient-centered care through tailored treatment plans and collaborative recovery strategies.',
      'career_path_desc': 'Patient care begins with a deep understanding of discomfort and the patient\'s goals. Through evidence-based interventions and structured therapeutic practices, we aim to reduce physical strain and improve overall function.',
      'highlights': 'I am a very dedicated doctor.',
    },
    {
      'name': 'Dr. Raymond, Ph.D.',
      'specialty': 'Endocrinologist',
      'rating': 4.9,
      'experience': 10,
      'consultations': 90,
      'focus': 'Managing hormonal disorders, diabetes, and thyroid conditions.',
      'schedule': 'Mon-Fri / 10:00AM - 6:00PM',
      'profile_desc': 'Specializing in endocrine disorders, I focus on comprehensive diagnosis and personalized treatment plans to restore hormonal balance and improve patient well-being.',
      'career_path_desc': 'My career journey in endocrinology has been driven by a passion for understanding complex hormonal systems and applying cutting-edge research to clinical practice.',
      'highlights': 'Published numerous research papers on diabetes management.',
    },
    {
      'name': 'Dr. Desmond, M.D.',
      'specialty': 'Eye Specialist',
      'rating': 4.7,
      'experience': 8,
      'consultations': 40,
      'focus': 'Diagnosing and treating eye diseases, vision correction.',
      'schedule': 'Tue-Sat / 8:30AM - 4:30PM',
      'profile_desc': 'Committed to preserving and enhancing vision through advanced ophthalmic care. I provide thorough examinations and effective treatments for various eye conditions.',
      'career_path_desc': 'From medical school to specialized training in ophthalmology, my path has focused on mastering ocular health and surgical techniques to benefit my patients.',
      'highlights': 'Known for successful cataract surgeries.',
    },
    {
      'name': 'Dr. Logith, Ph.D.',
      'specialty': 'Cardiologist',
      'rating': 4.8,
      'experience': 12,
      'consultations': 150,
      'focus': 'Heart health, blood pressure, and cardiovascular diseases.',
      'schedule': 'Mon-Thu / 9:00AM - 5:00PM',
      'profile_desc': 'Dedicated to promoting cardiovascular wellness through preventative care, accurate diagnosis, and advanced treatment options for heart-related conditions.',
      'career_path_desc': 'My extensive training in cardiology has equipped me with the expertise to address a wide range of cardiac issues, focusing on long-term patient health.',
      'highlights': 'Expert in interventional cardiology procedures.',
    },
  ];

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
        title: Text(
          widget.appBarTitle,
          style: const TextStyle(
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
          Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        _buildFilterButton('A-Z', isSelected: true),
        const SizedBox(width: 10),
        _buildFilterButton('Rating', icon: Icons.star, iconColor: Colors.amber),
        const SizedBox(width: 10),
        _buildFilterButton('Location', icon: Icons.location_on_outlined),
        const SizedBox(width: 10),
        _buildFilterButton('Time', icon: Icons.access_time),
      ],
    ),
  ),
),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: _doctors.length,
              itemBuilder: (context, index) {
                final doctor = _doctors[index];
                return DoctorListItem(
                  doctor: doctor,
                  listType: widget.type, 
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, {bool isSelected = false, IconData? icon, Color? iconColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
      child: Row(
        mainAxisSize: MainAxisSize.min, 
        children: [
          if (icon != null) ...[
            Icon(icon, color: iconColor ?? (isSelected ? Colors.white : Colors.grey[700]), size: 18),
            const SizedBox(width: 5),
          ],
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF6C63FF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorListItem extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final DoctorListType listType; 

  const DoctorListItem({super.key, required this.doctor, required this.listType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorInfoScreen(doctor: doctor),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
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
            Row(
              children: [
                if (listType == DoctorListType.favorite || listType == DoctorListType.rating) 
                  const Row(
                    children: [
                      Icon(Icons.verified, color: Color(0xFF6C63FF), size: 16),
                      SizedBox(width: 5),
                      Text(
                        'Professional Doctor',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6C63FF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10), 
                    ],
                  ),
                Text(
                  doctor['name'],
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C63FF),
                  ),
                ),
                const Spacer(),
                if (listType == DoctorListType.rating) 
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        '${doctor['rating']}',
                        style: const TextStyle(fontSize: 14, color: Color(0xFF6C63FF)),
                      ),
                    ],
                  ),
              ],
            ),
            Text(
              doctor['specialty'],
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF8B85E1),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorInfoScreen(doctor: doctor),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6C63FF),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: const Text('Info'),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.info_outline, color: Color(0xFF8B85E1), size: 20),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(35, 35),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {},
                ),
                const SizedBox(width: 5),
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
      ),
    );
  }
}