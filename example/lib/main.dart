// import 'package:flutter/material.dart';
// import 'package:auth_package/auth_package.dart';
//
// void main() => runApp(const DemoApp());
//
// class DemoApp extends StatelessWidget {
//   const DemoApp({super.key});
//   @override Widget build(BuildContext c) => MaterialApp(home: Scaffold(body: Center(child: Demo())));
// }
//
// class Demo extends StatefulWidget {
//   @override _DemoState createState() => _DemoState();
// }
// class _DemoState extends State<Demo> {
//   final repo = AuthRepoImpl(ApiService(baseUrl: 'https://api.example.com'));
//   String _output = '';
//
//   @override Widget build(BuildContext c) {
//     return Column(mainAxisSize: MainAxisSize.min, children: [
//       ElevatedButton(
//         onPressed: () async {
//           final res = await repo.generateOtp(phoneNumber: '+1234', countryCode: '+1');
//           res.fold(
//                 (f) => setState(() => _output = 'Error: \${f.errMessage}'),
//                 (r) => setState(() => _output = 'Sent: \${r.message}'),
//           );
//         },
//         child: const Text('Generate OTP'),
//       ),
//       const SizedBox(height: 12),Text(_output)
//     ]);
//   }
// }