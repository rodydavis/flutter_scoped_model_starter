abstract class RemoteData {
  void cancel() {}

  Future refresh() async {}

  Future load() async {}

  bool _fetching;
  bool get fetching => _fetching;

  String _error;
  String get error => _error;
}
