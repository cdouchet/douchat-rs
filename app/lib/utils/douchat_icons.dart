class DouchatIcons {
  static final DouchatIcons instance = DouchatIcons._internal();

  DouchatIcons._internal();

  final String _basePath = "assets/icons";

  String get chatBubble => "$_basePath/chat_bubble.svg";

  String get addButton => "$_basePath/add_button.svg";
}