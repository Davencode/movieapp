import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060D59), // Colore di sfondo
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo dell'app
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('images/LogoAPP.png', scale: 6.0),
                ],
              ),
              const SizedBox(height: 40),

              // Contenitore per la parte del profilo
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  children: [
                    // Foto del profilo
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile_picture.png'),
                    ),
                    const SizedBox(height: 20),

                    // Nome dell'utente
                    const Text(
                      'Davide Belardi',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Flutter Developer | Mobile App Developer',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),

                    // Sezione contatti
                    const Text(
                      'Contatti',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      title: const Text('Email'),
                      subtitle: const Text('davidebelardi1994@email.com'),
                      leading: const Icon(Icons.email),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Telefono'),
                      subtitle: const Text('+123 456 7890'),
                      leading: const Icon(Icons.phone),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Bottone per scaricare il CV
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('CV scaricato!')),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Download my resume'),
                      SizedBox(width: 10),
                      Icon(Icons.file_download)
                    ],
                  ),
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
