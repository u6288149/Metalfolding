import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'models/profile_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _bio;

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Settings'),
          content: const Text('Settings not implemented.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  ProfileModel? _profile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userData = await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _profile = ProfileModel(
          uid: userData['uid'],
          email: userData['email'],
          firstName: userData['firstName'],
          lastName: userData['lastName'],
        );
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      'My Profile',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0E2433)),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'First Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0E2433)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _profile?.firstName ?? '',
                    style: const TextStyle(fontSize: 16, color: Color(0xFF0E2433)),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Last Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0E2433)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _profile?.lastName ?? '',
                    style: const TextStyle(fontSize: 16, color: Color(0xFF0E2433)),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0E2433)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _profile?.email ?? '',
                    style: const TextStyle(fontSize: 16, color: Color(0xFF0E2433)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            // Implement editing user profile logic
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit Profile'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF528AAE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Implement editing settings logic
                          },
                          icon: const Icon(Icons.settings),
                          label: const Text('Edit Settings'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF528AAE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
