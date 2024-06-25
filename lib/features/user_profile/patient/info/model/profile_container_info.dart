class ProfileContainerInfoModel {
  final String title;
  final String userInfo;
  final bool isEditable;
  final bool isPassword;
  ProfileContainerInfoModel({
    required this.isPassword,
    required this.isEditable,
    required this.title,
    required this.userInfo,
  });
}
