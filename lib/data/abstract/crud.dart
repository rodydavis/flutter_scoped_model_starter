abstract class CRUD {
  dynamic get details => _details;
  dynamic _details;

  bool _notFound;
  bool get notFound => _notFound;

  Future<bool> edit(dynamic data) {}

  Future<bool> delete() {}

  Future<bool> add(dynamic data) {}

  Future<bool> get() {}
}
