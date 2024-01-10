timeFormat(int hour, int minute) {
  return "${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")}";
}
