import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        hintColor: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.blue,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        hintColor: Colors.orange,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.black,
        ),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => ProfilePage(toggleTheme: _toggleTheme),
        '/edit': (context) => EditProfilePage(),
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  final VoidCallback toggleTheme;

  ProfilePage({required this.toggleTheme});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = 'John Doe';
  String _dateOfBirth = 'January 5th, 2024';
  String _medicalHistory = 'No known allergies. Hypertension.';
  String _vaccinationStatus = 'Fully vaccinated';
  String _symptoms = 'None';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: [
            IconButton(
              icon: Icon(Icons.brightness_6),
              onPressed: widget.toggleTheme,
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Profile'),
              Tab(text: 'Symptom Checker'),
              Tab(text: 'Health Recommendations'),
              Tab(text: 'Vaccination Centers'),
              Tab(text: 'Educational Resources'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            profileTab(context),
            symptomCheckerTab(),
            healthRecommendationsTab(),
            vaccinationCentersTab(),
            educationalResourcesTab(),
          ],
        ),
      ),
    );
  }

  Widget profileTab(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Image.asset(
              'images/profile.jpg',
              height: 200,
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Name:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 8.0),
                Text(_name),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text('Date of Birth:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 8.0),
                Text(_dateOfBirth),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text('Medical History:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 8.0),
                Expanded(child: Text(_medicalHistory)),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text('Vaccination Status:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 8.0),
                Text(_vaccinationStatus),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text('Symptoms:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 8.0),
                Expanded(child: Text(_symptoms)),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/edit').then((value) {
                  setState(() {
                    if (value != null && value is Map<String, String>) {
                      _name = value['name']!;
                      _dateOfBirth = value['dateOfBirth']!;
                      _medicalHistory = value['medicalHistory']!;
                      _vaccinationStatus = value['vaccinationStatus']!;
                    }
                  });
                });
              },
              child: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 16.0),

          ],
        ),
      ),
    );
  }

  Widget symptomCheckerTab() {
    List<Map<String, String>> symptoms = [
      {'symptom': 'Fever', 'description': 'An elevated body temperature.', 'treatment': 'Over-the-counter medications like acetaminophen or ibuprofen can help reduce fever. In some cases, treating the underlying cause (infection) with antibiotics or other medications might be necessary.'},
      {'symptom': 'Fatigue', 'description': 'Feeling constantly tired or lacking energy.', 'treatment': 'Addressing the underlying cause is key. This could involve treating conditions like anemia or sleep disorders, improving diet and exercise habits, or managing stress.'},
      {'symptom': 'Headache', 'description': 'Pain or discomfort in the head.', 'treatment': 'Over-the-counter pain relievers like acetaminophen or ibuprofen can often help. Identifying and addressing triggers like stress, dehydration, or lack of sleep is also important.'},
      {'symptom': 'Cough', 'description': 'A forceful expulsion of air from the lungs.', 'treatment': 'Treatment depends on the cause. For coughs due to the common cold or flu, over-the-counter cough suppressants or expectorants might be helpful. Inhalers can be used for asthma or allergies. Antibiotics won\'t help a viral infection, but can be necessary for a bacterial infection.'},
      {'symptom': 'Sore Throat', 'description': 'Pain or scratchiness in the throat.', 'treatment': 'Over-the-counter pain relievers like lozenges or throat sprays can provide temporary relief. Gargling with warm salt water can also be soothing. Antibiotics are only necessary for bacterial infections like strep throat.'},
      {'symptom': 'Nausea and Vomiting', 'description': 'Feeling sick to your stomach and throwing up.', 'treatment': 'Staying hydrated is crucial. Over-the-counter medications can help with nausea. In some cases, medication might be needed to stop vomiting. Treatment for the underlying cause is important.'},
      {'symptom': 'Diarrhea', 'description': 'Loose, watery stools that occur more frequently than usual.', 'treatment': 'Staying hydrated with fluids containing electrolytes is essential. Over-the-counter medications like loperamide can help reduce diarrhea frequency. Treating the underlying cause (infection, food poisoning) is important.'},
      {'symptom': 'Painful Urination', 'description': 'Burning or stinging sensation when urinating.', 'treatment': 'Antibiotics are typically prescribed for urinary tract infections (UTIs), the most common cause. Increasing fluid intake and using pain relievers might also be recommended.'},
      {'symptom': 'Skin Rash', 'description': 'A red, itchy, or bumpy area on the skin.', 'treatment': 'Treatment depends on the cause. This might involve topical medications like creams or ointments, oral medications (antibiotics for some infections), or lifestyle changes (managing allergies, avoiding irritants).'},
      {'symptom': 'Joint Pain', 'description': 'Pain or discomfort in the joints.', 'treatment': 'While there is no cure for arthritis, treatments can help manage pain and inflammation. These include pain relievers, physical therapy, injections, and in some cases, surgery. For other causes like tendinitis or bursitis, rest, ice, and anti-inflammatory medications can be helpful.'},
    ];

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Symptom Checker',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Image.asset('images/symptom checker.png', height: 200),
            SizedBox(height: 8.0),
            Text('Select a symptom to get diagnosis and treatment options.'),
            SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: symptoms.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(symptoms[index]['symptom']!),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(symptoms[index]['symptom']!),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 16.0),
                              Text(
                                  'Description: ${symptoms[index]['description']}\n\nTreatment: ${symptoms[index]['treatment']}'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _symptoms = symptoms[index]['symptom']!;
                                });
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget healthRecommendationsTab() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Health Recommendations',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Receive personalized health recommendations.'),
            SizedBox(height: 16.0),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Diet Plan:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'Maintain a balanced diet including a variety of foods from all food groups: fruits, vegetables, proteins, whole grains, and dairy. Avoid excessive sugar, salt, and saturated fats.'),
                  SizedBox(height: 8.0),
                  Image.asset('images/diet.png', height: 150),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Water Intake:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'Aim to drink at least 8 glasses of water daily to stay hydrated. Adjust your intake based on activity level, climate, and health conditions.'),
                  SizedBox(height: 8.0),
                  Image.asset('images/drink water.png', height: 150),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sleep:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'Get 7-9 hours of quality sleep each night. Establish a consistent sleep schedule and create a restful environment. Avoid caffeine and electronic devices before bed.'),
                  SizedBox(height: 8.0),
                  Image.asset('images/good sleep.png', height: 150),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Physical Activity:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'Engage in at least 150 minutes of moderate aerobic activity or 75 minutes of vigorous activity per week. Include muscle-strengthening exercises on 2 or more days a week.'),
                  SizedBox(height: 8.0),
                  Image.asset('images/exercise.png', height: 150),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mental Health:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'Practice stress management techniques such as mindfulness, meditation, and deep breathing exercises. Stay connected with loved ones and seek professional help if needed.'),
                  SizedBox(height: 8.0),
                  Image.asset('images/stress management.png', height: 150),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preventive Care:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'Stay up to date with vaccinations and regular health screenings. Follow your healthcare provider’s advice and take prescribed medications as directed.'),
                  SizedBox(height: 8.0),
                  Image.asset('images/vaccination.png', height: 150),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'For more health tips, visit: https://www.healthline.com',
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }

  Widget vaccinationCentersTab() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vaccination Centers',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Find nearby vaccination centers.'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Logic to open Google Maps can be added here
              },
              child: Text('Open in Google Maps'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 16.0),
            Image.asset('images/google maps.png', height: 200),
            SizedBox(height: 16.0),
            Text(
              'Google Maps: https://maps.google.com',
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }

  Widget educationalResourcesTab() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Educational Resources',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Explore materials, blogs, and articles on health tips.'),
            SizedBox(height: 16.0),
            Image.asset('images/articles.png', height: 200),
            SizedBox(height: 16.0),
            Text(
              'Health Blogs and Articles:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'WebMD: https://www.webmd.com',
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
            SizedBox(height: 8.0),
            Text(
              'Mayo Clinic: https://www.mayoclinic.org',
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
            SizedBox(height: 8.0),
            Text(
              'Healthline: https://www.healthline.com',
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _medicalHistoryController = TextEditingController();
  final TextEditingController _vaccinationStatusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Profile',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Image.asset('images/edit profile.png', height: 200),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _dateOfBirthController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _medicalHistoryController,
                decoration: InputDecoration(labelText: 'Medical History'),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _vaccinationStatusController,
                decoration: InputDecoration(labelText: 'Vaccination Status'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'dateOfBirth': _dateOfBirthController.text,
                    'medicalHistory': _medicalHistoryController.text,
                    'vaccinationStatus': _vaccinationStatusController.text,
                  });
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}