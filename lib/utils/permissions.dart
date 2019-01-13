import 'package:permission/permission.dart';

Future<List<Permissions>> getPermissions() async {
  final results = await Permission.getPermissionStatus([
    // -- Permissions Needed For App --
    PermissionName.Contacts,
  ]);
  return results;
}

Future requestPermissions(List<PermissionName> permissions) async {
  final result = await Permission.requestPermissions(permissions);
  return result;
}

Future<bool> requestPermission(PermissionName permission) async {
  final result = await Permission.requestSinglePermission(permission);
  if (result == PermissionStatus.allow) return true;
  return false;
}

void openDeviceSettings() => Permission.openSettings();
