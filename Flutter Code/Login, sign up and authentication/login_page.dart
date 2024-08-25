import 'package:flutter/material.dart';
import 'signup_page.dart'; // Import the SignUpPage
import 'sensors_page.dart'; // Import the SensorDashboard
import 'package:firebase_auth/firebase_auth.dart'; // Import the "firebase_auth" package
import 'auth.dart'; // Import the Auth class

class LoginPage extends StatelessWidget {
  final Auth _auth = Auth(); // Instantiate Auth class
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        // Use Auth class to sign in
        await _auth.signInWithEmailAndPassword(
          email: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Navigate to the SensorDashboard page on successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SensorDashboard(
              userName: _auth.currentUser!.email!, // Get email from currentUser
            ),
          ),
        );
      } on FirebaseAuthException catch (e) {
        // Handle Firebase-specific exceptions
        print("FirebaseAuthException: ${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message!)),
        );
      } catch (e) {
        // Handle all other exceptions
        print("Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    }
  }

  /*
  LinearGradient with the two, #0xFF776483 and #0xFF292643, colors for background from left to right.
  User has two text fields to enter their email and password which are checked by firebase authentication
  to move them to the sensors page if they're correct or displaying an error message other wise. They can
  select choose to create an account if they don't have one, as well.
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF776483), Color(0xFF292643)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Image.asset(
                      'assets/logo.png', // Replace with your logo asset
                      height: 150,
                    ),
                    const SizedBox(height: 20),
                    // App Title with Gradient Color
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFE99E75), Color(0xFF44426E)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Text(
                        'Avatar',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Email Address
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF776483),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                          hintStyle: const TextStyle(
                            color: Color(0xFFBBAAB8),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          color: Color(0xFFBBAAB8),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Password
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF776483),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            color: Color(0xFFBBAAB8),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        style: const TextStyle(
                          color: Color(0xFFBBAAB8),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Log In Button
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _handleLogin(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE99E75),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                              color: Color(0xFFE99E75),
                              width: 2,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 160),
                    // Create New Account Button
                    Container(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: const Color(0xFFE99E75),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side:
                                const BorderSide(color: Color(0xFFE99E75), width: 2),
                          ),
                        ),
                        child: const Text(
                          'Create New Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
