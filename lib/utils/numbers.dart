String roundNumber(int source, {int fractionDigits = 1}) {
  if (source < 1000) {
    return source.toString();
  } else if (source < 1000000) {
    return '${(source / 1000).toStringAsFixed(fractionDigits)}k';
  } else {
    return '${(source / 1000).toStringAsFixed(fractionDigits)}m';
  }
}
