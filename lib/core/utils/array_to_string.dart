String arrayToString(List<String> array, String seperator) {
  if (array.isEmpty) {
    return "";
  }
  return array.join(seperator);
}
