import 'package:flutter/material.dart';

void main() {
  runApp(const StudentApp());
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talabalar Ro‘yxati',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      home: const StudentFormScreen(),
    );
  }
}

// Talaba ma'lumotlari uchun model
class Student {
  final String firstName;
  final String lastName;
  final String group;
  final String major;

  Student({
    required this.firstName,
    required this.lastName,
    required this.group,
    required this.major,
  });
}

// 1-Sahifa: Ma'lumot kiritish formasi
class StudentFormScreen extends StatefulWidget {
  const StudentFormScreen({super.key});

  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _groupController = TextEditingController();
  final _majorController = TextEditingController();

  // Barcha ro'yxatga olingan talabalar ro'yxati
  final List<Student> _students = [];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _groupController.dispose();
    _majorController.dispose();
    super.dispose();
  }

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _students.add(
          Student(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            group: _groupController.text,
            major: _majorController.text,
          ),
        );
      });

      // Maydonlarni tozalash
      _firstNameController.clear();
      _lastNameController.clear();
      _groupController.clear();
      _majorController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Talaba muvaffaqiyatli ro'yxatga olindi!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Talabani Ro'yxatga Olish",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo.shade600,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt, color: Colors.white),
            onPressed: () {
              // Natijalar sahifasiga o'tish
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentListScreen(students: _students),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                "Talaba ma'lumotlarini kiriting:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 20),

              // Ism
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: "Ism",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Iltimos, ismni kiriting"
                    : null,
              ),
              const SizedBox(height: 15),

              // Familiya
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: "Familiya",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Iltimos, familiyani kiriting"
                    : null,
              ),
              const SizedBox(height: 15),

              // Guruh
              TextFormField(
                controller: _groupController,
                decoration: InputDecoration(
                  labelText: "Guruh (masalan: 21-04)",
                  prefixIcon: const Icon(Icons.group),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Iltimos, guruhni kiriting"
                    : null,
              ),
              const SizedBox(height: 15),

              // Yo'nalish
              TextFormField(
                controller: _majorController,
                decoration: InputDecoration(
                  labelText: "Yo'nalish (masalan: Kiberxavfsizlik)",
                  prefixIcon: const Icon(Icons.school),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Iltimos, yo'nalishni kiriting"
                    : null,
              ),
              const SizedBox(height: 30),

              // Saqlash tugmasi
              ElevatedButton.icon(
                onPressed: _submitData,
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text(
                  "Ro'yxatga olish",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Natijalar sahifasiga o'tish tugmasi
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StudentListScreen(students: _students),
                    ),
                  );
                },
                icon: Icon(Icons.visibility, color: Colors.indigo.shade600),
                label: Text(
                  "Ro'yxatni ko'rish (${_students.length} ta talaba)",
                  style: TextStyle(color: Colors.indigo.shade600, fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: Colors.indigo.shade600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2-Sahifa: Natijalarni ko'rsatish sahifasi
class StudentListScreen extends StatelessWidget {
  final List<Student> students;

  const StudentListScreen({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ro'yxatdan o'tgan Talabalar",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo.shade600,
        centerTitle: true,
      ),
      body: students.isEmpty
          ? const Center(
              child: Text(
                "Hali talabalar ro'yxatga olinmagan!",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo.shade100,
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: Colors.indigo.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      "${student.firstName} ${student.lastName}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "Guruh: ${student.group} | Yo'nalish: ${student.major}",
                      ),
                    ),
                    trailing: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
