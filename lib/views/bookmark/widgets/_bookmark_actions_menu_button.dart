part of '../bookmark_view.dart';

class _BookmarkActionsMenuButton extends StatefulWidget {
  final VoidCallback? onRemove;
  final VoidCallback? onAddNote;
  final String? note;

  const _BookmarkActionsMenuButton(
      {required this.onRemove, required this.onAddNote, required this.note});

  @override
  State<_BookmarkActionsMenuButton> createState() => _BookmarkActionsMenuButtonState();
}

class _BookmarkActionsMenuButtonState extends State<_BookmarkActionsMenuButton> {
  late final MenuController _menuController;

  @override
  void initState() {
    _menuController = MenuController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hasNote = (widget.note != null && widget.note!.isNotEmpty);

    return MenuAnchor(
      controller: _menuController,
      builder: (context, controller, child) {
        return IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: controller.isOpen ? controller.close : controller.open,
        );
      },
      menuChildren: [
        MenuItemButton(
          onPressed: widget.onAddNote,
          child: Text(
            hasNote ? StringConstants.editNote : StringConstants.addNote,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        MenuItemButton(
          onPressed: widget.onRemove,
          child: const Text(
            StringConstants.remove,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}