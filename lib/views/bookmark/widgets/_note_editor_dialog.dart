part of "../bookmark_view.dart";

class _NoteEditorDialog extends StatefulWidget {
  final String? initialNote;
  final Function(String) onSave;

  const _NoteEditorDialog({
    this.initialNote,
    required this.onSave,
  });

  @override
  State<_NoteEditorDialog> createState() => __NoteEditorDialogState();
}

class __NoteEditorDialogState extends State<_NoteEditorDialog> {
  late final TextEditingController _textController;
  late final ScrollController _scrollController;
  final int _characterLimit = 10000;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialNote);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSave() {
    widget.onSave(_textController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const BeveledRectangleBorder(),
      insetPadding: EdgeInsets.all(Paddings.lowHigh.value),
      actionsAlignment: MainAxisAlignment.start,
      backgroundColor: ColorConstants.offBlack,
      title: const Text(StringConstants.note),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Scrollbar(
                controller: _scrollController,
                thickness: 4,
                thumbVisibility: true,
                child: TextField(
                  cursorColor: Colors.white60,
                  scrollController: _scrollController,
                  controller: _textController,
                  autofocus: true,
                  maxLength: _characterLimit,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: ColorConstants.offBlack,
                    border: OutlineInputBorder(),
                    counterText: "",
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: ListenableBuilder(
                  listenable: _textController,
                  builder: (context, child) {
                    return Text(
                      "${_textController.text.length} ${StringConstants.of} $_characterLimit ${StringConstants.characters}",
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            shape: const BeveledRectangleBorder(),
          ),
          onPressed: _handleSave,
          child: const Text(StringConstants.save),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: const BeveledRectangleBorder(),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(StringConstants.cancel,
              style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}