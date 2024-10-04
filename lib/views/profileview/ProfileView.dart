import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/colors.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  String name = '';
  String phone = '';
  String address = '';
  String city = '';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // Save profile data to SharedPreferences
  Future<void> _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('address', _addressController.text);
    await prefs.setString('city', _cityController.text);

    setState(() {
      name = _nameController.text;
      phone = _phoneController.text;
      address = _addressController.text;
      city = _cityController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile Saved!')),
    );
  }

  // Load profile data from SharedPreferences
  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      phone = prefs.getString('phone') ?? '';
      address = prefs.getString('address') ?? '';
      city = prefs.getString('city') ?? '';

      _nameController.text = name;
      _phoneController.text = phone;
      _addressController.text = address;
      _cityController.text = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: CustomColors.primarycolor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input fields for the profile
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0), // Set the desired radius
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0), // Set the desired radius
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0), // Set the desired radius
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0), // Set the desired radius
                ),
              ),
            ),

            const SizedBox(height: 16),
            // Save button
            ElevatedButton(
              onPressed: _saveProfileData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF07A2A4),  // Set the background color
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),// Set the text (foreground) color
              ),
              child: Text('Save Profile'),
            ),
            const SizedBox(height: 20),
            // Display saved profile data
            Text(
              'Saved Profile:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Name: $name'),
            Text('Phone: $phone'),
            Text('Address: $address'),
            Text('City: $city'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}
