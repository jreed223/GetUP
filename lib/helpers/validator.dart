/// This function checks if input is a number

bool isNumber(String s) {
  if (s == null || s.isEmpty) {
    return false;
  }
  return int.tryParse(s) != null;
}
