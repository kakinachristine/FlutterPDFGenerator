import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReceiptPage(),
    );
  }
}

class ReceiptPage extends StatelessWidget {
  Future<void> _createPDF() async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    if (directory != null) {
      final String dir = directory.path;
      final String path = '$dir/receipt.pdf';
      final File file = File(path);

      // Create PDF document
      final pdfLib.Document doc = pdfLib.Document();

      // Customer and order details
      final customerDetails = [
        'Receipt Number: XXXX',
        'Customer Name: John Doe',
        'Date: February 27, 2024',
        'Order No: XXXX',
        'To: John Doe',
        'Place: Your Place',
      ];

      // Add content to PDF document
      doc.addPage(
        pdfLib.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) => [
            pdfLib.Center(
              child: pdfLib.Text(
                'Receipt',
                style: pdfLib.TextStyle(fontSize: 24, fontWeight: pdfLib.FontWeight.bold),
              ),
            ),
            pdfLib.SizedBox(height: 10),
            pdfLib.Column(
              crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
              children: [
                for (var detail in customerDetails)
                  pdfLib.Text(detail),
                pdfLib.SizedBox(height: 20),
                _buildTable(),
                pdfLib.SizedBox(height: 20),
                pdfLib.Text(
                  'Payment Terms: Mpesa/Airtel Money/Bank Transfer',
                  style: pdfLib.TextStyle(fontWeight: pdfLib.FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      );

      // Save PDF document to file
      await file.writeAsBytes(await doc.save());

      // Print debug information
      print('PDF file path: $path');
      print('File exists: ${await file.exists()}');

      // Open the PDF file
      _openFile(path);
    } else {
      // Handle case where directory is null
      print('Unable to access storage directory');
    }
  }



  // Method to open the PDF file
  void _openFile(String path) {
    OpenFile.open(path);
  }

  // Method to build the table
  pdfLib.Widget _buildTable() {
    return pdfLib.Table.fromTextArray(

      data: <List<String>>[
        <String>['Product', 'Quantity', 'Unit Price', 'Cost'],
        <String>['Product 1', '2', '\$10', '\$20'],
        <String>['Product 2', '1', '\$15', '\$15'],
        <String>['Transport Cost', '-', '-', '\$5'],
        <String>['Total Cost', '-', '-', '\$40'],
      ],
      cellHeight: 30,
      cellAlignments: {
        0: pdfLib.Alignment.centerLeft,
        1: pdfLib.Alignment.center,
        2: pdfLib.Alignment.center,
        3: pdfLib.Alignment.center,
      },
      headerAlignments: {
        0: pdfLib.Alignment.center,
        1: pdfLib.Alignment.center,
        2: pdfLib.Alignment.center,
        3: pdfLib.Alignment.center,
      },
      headerDecoration: pdfLib.BoxDecoration(color: PdfColors.grey300),
      tableWidth: pdfLib.TableWidth.max,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Receipt Details
            Center(
              child: Text(
                'Receipt',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            // Button to download PDF
            ElevatedButton(
              onPressed: _createPDF,
              child: Text('Download Receipt as PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
