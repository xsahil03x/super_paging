/// Throws an [ArgumentError] with the [message] and [name] if the [value] is
/// null. Otherwise returns the not null value.
T requireNotNull<T>(T? value, [String? message, String? name]) {
  if (value == null) {
    throw ArgumentError(message, name);
  }
  return value;
}
