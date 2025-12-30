import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:hisab/features/transactions/model/transaction_model.dart';
import 'package:jiffy/jiffy.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';

// --- App Theme Color Palette ---
const PdfColor primaryColor =
    PdfColor.fromInt(0xff007aff); // Your app theme color
const PdfColor gaveColor = PdfColors.red500;
const PdfColor gotColor = PdfColors.green500;
const PdfColor lightTextColor = PdfColors.white;
const PdfColor darkTextColor = PdfColor.fromInt(0xff333333);
const PdfColor lightBgColor =
    PdfColor.fromInt(0xffF7F7F7); // A very light grey for zebra striping
const PdfColor greyColor = PdfColors.grey600;

enum PdfDirection { ltr, rtl }

class TransactionPdfService {
  /// --- HELPER WIDGET FOR ARABIC/MIXED TEXT ---
  /// This widget checks for Arabic characters and wraps the text in a
  /// `RichText` with RTL direction if found, ensuring correct rendering
  /// even in an LTR document. Otherwise, it returns a standard `Text` widget.
  static pw.Widget _buildText(String text,
      {pw.TextStyle? style, pw.TextAlign? textAlign}) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    if (arabicRegex.hasMatch(text)) {
      return pw.RichText(
        // This forces RTL rendering for this specific span of text.
        textDirection: pw.TextDirection.rtl,
        textAlign: textAlign,
        text: pw.TextSpan(
          text: text,
          style: style,
        ),
      );
    }
    return pw.Text(text, style: style, textAlign: textAlign);
  }

  static Future<File> generateAndOpenReport({
    required PdfDirection direction,
    required String appName,
    required String appDescription,
    required String storeName,
    required String storeLocation,
    required String storeNumber,
    required String customerName,
    required List<TransactionModel> transactions,
  }) async {
    final pdf = pw.Document();
    final isRtl = direction == PdfDirection.rtl;

    final fontData =
        await rootBundle.load('assets/fonts/NotoSansArabic-Regular.ttf');
    final baseFont = pw.Font.ttf(fontData);

    final prefs = await SharedPreferences.getInstance();
    //path to assets
    final logoPath = prefs.getString('../assets/app_icon.png');
    pw.ImageProvider? logo;
    if (logoPath != null && File(logoPath).existsSync()) {
      logo = pw.MemoryImage(File(logoPath).readAsBytesSync());
    }

    final gave = _totalGave(transactions);
    final got = _totalGot(transactions);
    final balance = gave - got;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
            marginBottom: 50, marginTop: 40, marginLeft: 40, marginRight: 40),
        // Global direction is LTR as requested
        textDirection: pw.TextDirection.ltr,
        theme: pw.ThemeData.withFont(base: baseFont),
        footer: (context) => _buildFooter(context, appName, appDescription),
        build: (context) => [
          _buildHeader(
            storeName: storeName,
            storeLocation: storeLocation,
            logo: logo,
            isRtl: isRtl,
          ),
          _buildCustomerSummary(
            customerName: customerName,
            gave: gave,
            got: got,
            balance: balance,
          ),
          pw.SizedBox(height: 25),
          _buildText(
            LocaleKey.transactions.tr,
            style: const pw.TextStyle(
              fontSize: 16,
              color: darkTextColor,
            ),
          ),
          pw.Divider(color: PdfColors.grey300),
          pw.SizedBox(height: 5),
          _buildTransactionListHeader(isRtl: isRtl),
          ...transactions.asMap().entries.map((entry) {
            return _buildTransactionListItem(
              transaction: entry.value,
              isRtl: isRtl,
              isZebra: entry.key % 2 == 0,
            );
          }).toList(),
          pw.Container(
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                  top: pw.BorderSide(color: primaryColor, width: 1.5)),
            ),
          ),
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/transaction_report.pdf');
    await file.writeAsBytes(await pdf.save());
    await OpenFilex.open(file.path);
    return file;
  }

  static pw.Widget _buildHeader({
    required String storeName,
    required String storeLocation,
    required bool isRtl,
    pw.ImageProvider? logo,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 15),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
            bottom: pw.BorderSide(color: PdfColors.grey200, width: 2)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment:
                isRtl ? pw.CrossAxisAlignment.end : pw.CrossAxisAlignment.start,
            children: [
              _buildText(
                LocaleKey.transactionReport.tr,
                style: const pw.TextStyle(
                  fontSize: 24,
                  color: primaryColor,
                ),
              ),
              _buildText(
                storeName,
                style: const pw.TextStyle(
                  fontSize: 14,
                  color: darkTextColor,
                ),
              ),
              _buildText(
                storeLocation,
                style: const pw.TextStyle(
                  fontSize: 11,
                  color: greyColor,
                ),
              ),
            ],
          ),
          _buildLogo(logo: logo, storeName: storeName),
        ],
      ),
    );
  }

  static pw.Widget _buildLogo(
      {pw.ImageProvider? logo, required String storeName}) {
    if (logo != null) {
      return pw.Container(
        width: 60,
        height: 60,
        decoration: pw.BoxDecoration(
          shape: pw.BoxShape.circle,
          image: pw.DecorationImage(image: logo, fit: pw.BoxFit.cover),
        ),
      );
    }
    if (storeName.isNotEmpty) {
      return pw.Container(
        alignment: pw.Alignment.center,
        width: 60,
        height: 60,
        decoration: const pw.BoxDecoration(
          color: primaryColor,
          shape: pw.BoxShape.circle,
        ),
        // Use the helper for the first letter of the name
        child: _buildText(
          storeName[0].toUpperCase(),
          style: const pw.TextStyle(
            color: lightTextColor,
            fontSize: 16,
          ),
        ),
      );
    }
    return pw.SizedBox(width: 60, height: 60);
  }

  static pw.Widget _buildCustomerSummary({
    required String customerName,
    required double gave,
    required double got,
    required double balance,
  }) {
    final balanceColor = balance >= 0 ? gaveColor : gotColor;

    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 15),
      padding: const pw.EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: pw.BoxDecoration(
        color: lightBgColor,
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _buildText(
                LocaleKey.reportFor.tr,
                style: const pw.TextStyle(
                  color: greyColor,
                ),
              ),
              _buildText(
                customerName,
                style: const pw.TextStyle(
                  color: darkTextColor,
                ),
              ),
            ],
          ),
          pw.Divider(color: PdfColors.grey300),
          _buildText(
            LocaleKey.balance.tr,
            textAlign: pw.TextAlign.center,
            style: const pw.TextStyle(fontSize: 14, color: greyColor),
          ),
          pw.Text(
            balance.abs().toStringAsFixed(2),
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              color: balanceColor,
              fontSize: 25,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              pw.Column(
                children: [
                  _buildText(LocaleKey.gave.tr,
                      style: const pw.TextStyle(color: greyColor)),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    gave.toStringAsFixed(2),
                    style: const pw.TextStyle(
                      color: gaveColor,
                    ),
                  ),
                ],
              ),
              pw.Column(
                children: [
                  _buildText(LocaleKey.got.tr,
                      style: const pw.TextStyle(color: greyColor)),
                  pw.SizedBox(height: 2),
                  pw.Text(got.toStringAsFixed(2),
                      style: const pw.TextStyle(color: gotColor)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildTransactionListHeader({required bool isRtl}) {
    final flexValues = [2, 3, 2, 4];
    final headers = [
      LocaleKey.date.tr,
      LocaleKey.amount.tr,
      LocaleKey.type.tr,
      LocaleKey.description.tr
    ];
    final headerWidgets = <pw.Widget>[];
    for (int i = 0; i < headers.length; i++) {
      headerWidgets.add(
        pw.Expanded(
          flex: flexValues[i],
          child: _buildText(
            headers[i],
            textAlign: pw.TextAlign.center,
            style: const pw.TextStyle(
              color: lightTextColor,
            ),
          ),
        ),
      );
    }

    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 10),
      decoration: const pw.BoxDecoration(
        color: primaryColor,
        borderRadius: pw.BorderRadius.only(
            topLeft: pw.Radius.circular(6), topRight: pw.Radius.circular(6)),
      ),
      child: pw.Row(
          children: isRtl ? headerWidgets.reversed.toList() : headerWidgets),
    );
  }

  static pw.Widget _buildTransactionListItem({
    required TransactionModel transaction,
    required bool isRtl,
    required bool isZebra,
  }) {
    final typeColor = transaction.type == LocaleKey.gave ? gaveColor : gotColor;
    final date =
        Jiffy.parse(transaction.updatedAt!).format(pattern: 'dd/MMM/yy');

    final flexValues = [2, 3, 2, 4];
    final cells = [
      pw.Text(date, textAlign: pw.TextAlign.center),
      pw.Text(transaction.amount?.toStringAsFixed(2) ?? '0',
          textAlign: pw.TextAlign.center),
      _buildText(
          transaction.type == LocaleKey.gave
              ? LocaleKey.gave.tr
              : LocaleKey.got.tr,
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(color: typeColor)),
      _buildText(transaction.description ?? '', textAlign: pw.TextAlign.center),
    ];
    final cellWidgets = <pw.Widget>[];
    for (int i = 0; i < cells.length; i++) {
      cellWidgets.add(pw.Expanded(flex: flexValues[i], child: cells[i]));
    }

    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      color: isZebra ? lightBgColor : PdfColors.white,
      child:
          pw.Row(children: isRtl ? cellWidgets.reversed.toList() : cellWidgets),
    );
  }

  static pw.Widget _buildFooter(
      pw.Context context, String appName, String appDescription) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 10),
      decoration: const pw.BoxDecoration(
          border: pw.Border(
              top: pw.BorderSide(color: PdfColors.grey300, width: 1))),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          _buildText(
            '${LocaleKey.page.tr} ${context.pageNumber} / ${context.pagesCount}',
            style: const pw.TextStyle(fontSize: 9, color: greyColor),
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              _buildText(
                'Powered by $appName',
                style: const pw.TextStyle(color: greyColor),
              ),
              pw.SizedBox(height: 2),
              _buildText(
                appDescription,
                style: const pw.TextStyle(fontSize: 8, color: greyColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static double _totalGave(List<TransactionModel> list) => list
      .where((t) => t.type == LocaleKey.gave)
      .fold(0, (sum, t) => sum + (t.amount ?? 0));

  static double _totalGot(List<TransactionModel> list) => list
      .where((t) => t.type == LocaleKey.got)
      .fold(0, (sum, t) => sum + (t.amount ?? 0));
}
