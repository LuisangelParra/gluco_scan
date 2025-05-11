import 'package:intl/intl.dart';

class LFormatter {
  LFormatter._();

  /// Formatea la fecha en español, ej. "5 de mayo de 2025"
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat("d 'de' MMMM 'de' y", 'es_CO').format(date);
  }

  /// Formato corto de fecha, ej. "05/05/2025"
  static String formatDateShort(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd/MM/yyyy', 'es_CO').format(date);
  }

  /// Formatea la hora en 24h, ej. "14:30"
  static String formatTime(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat.Hm('es_CO').format(date);
  }

  /// Fecha y hora juntas, ej. "05/05/2025 14:30"
  static String formatDateTime(DateTime? date) {
    return '${formatDateShort(date)} ${formatTime(date)}';
  }


  static String formatPhoneNumber(String phoneNumber) {
    // Assuming a 10-digit US phone number format (123) 456-7890
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)}-${phoneNumber.substring(7)}';
    }
    return phoneNumber;
  }

  /// Porcentaje, recibe 0.64 y devuelve "64%"
  static String formatPercentage(double value, {int fractionDigits = 0}) {
    final pct = value * 100;
    return '${pct.toStringAsFixed(fractionDigits)}%';
  }

  /// Progreso (alias de porcentaje)
  static String formatProgress(double value, {int fractionDigits = 0}) =>
      formatPercentage(value, fractionDigits: fractionDigits);

  /// Glucosa en mmol/L, ej. "5.1 mmol/L"
  static String formatGlucoseMmol(double mmolL, {int decimals = 1}) =>
      '${mmolL.toStringAsFixed(decimals)} mmol/L';

  /// Glucosa en mg/dl, ej. "100 mg/dl"
  static String formatGlucoseMgDl(double mgDl) =>
      '${mgDl.toStringAsFixed(0)} mg/dl';

  /// Ritmo cardíaco, ej. "78 bpm"
  static String formatHeartRate(int bpm) => '$bpm bpm';

  /// Peso en kilogramos, ej. "72.5 kg"
  static String formatWeight(double kg, {int decimals = 1}) =>
      '${kg.toStringAsFixed(decimals)} kg';

  /// Altura en metros, ej. "1.75 m"
  static String formatHeight(double meters, {int decimals = 2}) =>
      '${meters.toStringAsFixed(decimals)} m';
}
