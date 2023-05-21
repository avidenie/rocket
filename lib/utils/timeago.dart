String timeAgo(DateTime date, {DateTime? clock}) {
  final localClock = clock ?? DateTime.now();
  final elapsed =
      localClock.millisecondsSinceEpoch - date.millisecondsSinceEpoch;

  final num seconds = elapsed / 1000;
  final num minutes = seconds / 60;
  final num hours = minutes / 60;
  final num days = hours / 24;
  final num months = days / 30;
  final num years = days / 365;

  if (seconds < 45) {
    return 'now';
  } else if (seconds < 90) {
    return '1m';
  } else if (minutes < 45) {
    return '${minutes.round()}m';
  } else if (minutes < 90) {
    return '1h';
  } else if (hours < 24) {
    return '${hours.round()}h';
  } else if (hours < 48) {
    return '1d';
  } else if (days < 30) {
    return '${days.round()}d';
  } else if (days < 60) {
    return '1mo';
  } else if (days < 365) {
    return '${months.round()}mo';
  } else if (years < 2) {
    return '1y';
  } else {
    return '${years.round()}y';
  }
}
