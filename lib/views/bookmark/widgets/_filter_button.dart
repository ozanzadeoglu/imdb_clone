part of "../bookmark_view.dart";

class _FilterButton<T extends Enum> extends StatelessWidget {
  final List<T> buttonTitles;
  final Function onPressed;
  final Function onUnselect;
  final T? selectedType;
  final String unselectedLabel;

  const _FilterButton(
      {required this.buttonTitles,
      required this.onPressed,
      required this.onUnselect,
      required this.selectedType, required this.unselectedLabel});

  @override
  Widget build(BuildContext context) {
    final buttonLabel = selectedType?.name ?? unselectedLabel;

    return FilledButton(
      onPressed: () {
        selectedType != null
            ? onUnselect()
            : showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return ListView.builder(
                    itemCount: buttonTitles.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              onPressed(buttonTitles[index]);
                            },
                            child: FilterBar<T>(
                              title: buttonTitles[index],
                              filterLength: 2,
                            ),
                          ),
                          const Divider(height: 2),
                        ],
                      );
                    },
                  );
                },
              );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(buttonLabel),
          selectedType != null
              ? SizedBox(
                  width: 4,
                  child: Icon(Icons.close),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}

class FilterBar<T extends Enum> extends StatelessWidget {
  final T title;
  final int filterLength;
  const FilterBar({super.key, required this.title, required this.filterLength});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: double.maxFinite,
      child: Center(
        child: Text(
          title.name.capitalizeFirstLetter(),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
