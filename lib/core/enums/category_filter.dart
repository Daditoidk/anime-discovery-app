
enum CategoryFilters {
  all,
  isekai,
  action,
  comedy,
  drama,
  fantasy,
  romance;

  String get capitalized {
    if (name.isEmpty) return name;
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }
}

