extension FirstNameOnly on String {
  String get firstNameOnly {
    return split(" ").first;
  }
}

extension LastNameOnly on String {
  String get lastNameOnly {
    List<String> parts = split(" ");
    return parts.length > 1 ? parts.last : "";
  }
}
