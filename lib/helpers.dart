import 'dart:math';

// Map of days of the week to their respective short form
final Map<int, String> daysOfWeek = {
  1: 'Mon',
  2: 'Tue',
  3: 'Wed',
  4: 'Thu',
  5: 'Fri',
  6: 'Sat',
  7: 'Sun',
};

// Create a random number between min and max
int randBetween(int min, int max) {
  return min + Random().nextInt(max - min);
}


// Format a number to a string with , every 3 digits (e.g. 1000 -> 1,000)
String formatNumber(int number) {
  return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}