// import 'package:flutter/material.dart';
// import 'package:getup_csc450/widgets/line_echart.dart';

// class TestPage extends StatefulWidget {
//   const TestPage({super.key});

//   @override
//   State<TestPage> createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   int num = 0;

//   ///Used to increase number and set new state
//   void incrementNum() {
//     setState(() {
//       num++;
//     });
//   }

//   ///Used to decrease number and set new state
//   void decrementNum() {
//     setState(() {
//       num = num - 1;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 56, 123, 248),
//         title: const Text('num Increment'),
//       ),
//       body: Center(
//         ///Laying text and button vertically on the page
//         child: Column(
//           //Centers column vertically on y axis
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const LineEchart(),

//             ///This passes a variable into the string
//             Text("This is my number: $num"),

//             ///This lays the button side by side
//             Row(
//               ///Centers row horizontally on x axis
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => incrementNum(),
//                   child: const Icon(
//                     Icons.add,
//                     color: Colors.redAccent,
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => decrementNum(),
//                   child: const Icon(
//                     Icons.text_decrease,
//                     color: Colors.redAccent,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
