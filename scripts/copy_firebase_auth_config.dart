import "dart:io";

const String configFolderPath = "./scripts/firebase_auth_configs";
const String iosConfigFileName = "GoogleService-Info.plist";
const String iosConfigFilePath = "./$configFolderPath/$iosConfigFileName";
const String iosConfigDestination = "./ios/Runner/$iosConfigFileName";

void main() {
  File(iosConfigFilePath).copySync(iosConfigDestination);
}
