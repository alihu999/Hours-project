Map<String, List<Map>> splitDataToTables(List<Map> allData) {
  Map<String, List<Map>> tables = {};

  for (Map element in allData) {
    if (tables.containsKey(element["date"]!.substring(5, 7))) {
      tables[element["date"]!.substring(5, 7)]!.add(element);
    } else {
      tables[element["date"]!.substring(5, 7)] = [element];
    }
  }
  return tables;
}
