import 'package:flutter/material.dart';
import 'package:tako_food/components/scaffold_components.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> list = <String>[
    'Daan Mogot',
    'Sunter',
    'Mangga Besar',
    'Mangga Dua'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldComponents.generateAppBar(context),
      bottomNavigationBar: ScaffoldComponents.generateNavigationBar(context),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Kode Referal"),
            const TextField(),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Submit"),
            ),
            const Text("Pilih Cabang"),
            DropdownButton<String>(
              value: list.first,
              onChanged: (String? value) {},
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ],
        ),
      )),
    );
  }
}
