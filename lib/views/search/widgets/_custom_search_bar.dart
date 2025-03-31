part of '../search_view.dart';

class _CustomSearchBar extends StatefulWidget {
  const _CustomSearchBar();

  @override
  State<_CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<_CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<SearchViewController>();
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIconColor: ColorConstants.thamarBlack,
              prefixIcon: Icon(Icons.search),
            ),
            controller: controller.textController,
            focusNode: controller.textFieldFocusNode,
            keyboardType: TextInputType.name,
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: kToolbarHeight,
            child: TextButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              onPressed: controller.clearTextFieldText,
              child: Text(StringConstants.cancel,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: ColorConstants.iconYellow)),
            ),
          ),
        ),
      ],
    );
  }
}