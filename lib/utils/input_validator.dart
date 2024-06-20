String? inputValidator(String? value, String label) {
  if (value == null) {
    return "$label tidak boleh kosong";
  }
  if (value.isEmpty) {
    return "$label tidak boleh kosong";
  }
  return null;
}
