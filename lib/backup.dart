// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
//
// void main() {
//   runApp(MaterialApp(
//     home: InvoicePage(),
//   ));
// }
//
// class InvoicePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Invoice'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await generateInvoicePDF(context);
//           },
//           child: Text('Download Invoice'),
//         ),
//       ),
//     );
//   }
//
//   Future<void> generateInvoicePDF(BuildContext context) async {
//     final pdf = pw.Document();
//
//     final storeName = 'My Store';
//     final items = ['Item 1', 'Item 2', 'Item 3'];
//     final productCost = 50.0;
//     final transportCost = 10.0;
//     final totalCost = productCost + transportCost;
//
//     // Add content to the PDF
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Center(
//             child: pw.Column(
//               mainAxisAlignment: pw.MainAxisAlignment.center,
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text(
//                   'Store: $storeName',
//                   style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
//                 ),
//                 pw.SizedBox(height: 10),
//                 pw.Text(
//                   'Product Cost: \$${productCost.toStringAsFixed(2)}',
//                   style: pw.TextStyle(fontSize: 16),
//                 ),
//                 pw.SizedBox(height: 10),
//                 pw.Text(
//                   'Transport Cost: \$${transportCost.toStringAsFixed(2)}',
//                   style: pw.TextStyle(fontSize: 16),
//                 ),
//                 pw.SizedBox(height: 10),
//                 pw.Divider(),
//                 pw.SizedBox(height: 10),
//                 pw.Text(
//                   'Items:',
//                   style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
//                 ),
//                 pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: items
//                       .map((item) => pw.Padding(
//                     padding: pw.EdgeInsets.symmetric(vertical: 4.0),
//                     child: pw.Text(item),
//                   ))
//                       .toList(),
//                 ),
//                 pw.SizedBox(height: 10),
//                 pw.Divider(),
//                 pw.SizedBox(height: 10),
//                 pw.Text(
//                   'Total Cost: \$${totalCost.toStringAsFixed(2)}',
//                   style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//
//     // Save the PDF to a file
//     final output = await getTemporaryDirectory();
//     final file = File("${output.path}/invoice.pdf");
//     await file.writeAsBytes(await pdf.save());
//
//     // Show a snackbar or alert that the PDF is downloaded
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Invoice downloaded successfully'),
//       ),
//     );
//   }
// }
