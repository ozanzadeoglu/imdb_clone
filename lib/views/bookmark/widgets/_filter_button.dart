part of "../bookmark_view.dart";

class _FilterButton<T extends Enum> extends StatelessWidget {
  final List<T> buttonTitles;
  final Function onPressed;
  final Function onUnselect;
  final T? selectedFilter;
  final String unselectedLabel;

  const _FilterButton(
      {required this.buttonTitles,
      required this.onPressed,
      required this.onUnselect,
      required this.selectedFilter,
      required this.unselectedLabel});

  @override
  Widget build(BuildContext context) {
    final double buttonSize = 48;
    final double filterBarSize = 48;

    final buttonLabel = selectedFilter?.name ?? unselectedLabel;
    final bool isSelected = selectedFilter != null;

    final ButtonStyle buttonStyle = OutlinedButton.styleFrom(
      backgroundColor: isSelected ? Colors.grey[300] : Colors.transparent,
      foregroundColor: isSelected ? Colors.black : Colors.white,
      side: isSelected
          ? BorderSide.none
          : BorderSide(color: Colors.grey.shade700, width: 1.5),
      shape: const StadiumBorder(),
      padding: const EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
      fixedSize: Size.fromHeight(buttonSize),
    );

    final buttonIcon = isSelected
        ? const CircleAvatar(
            radius: 12,
            backgroundColor: Colors.black,
            child: Icon(Icons.close, color: Colors.white, size: 16),
          )
        : const Icon(Icons.arrow_drop_down, size: 32);

    final buttonLabelStyle = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: isSelected ? Colors.black : Colors.white);

    return OutlinedButton.icon(
      icon: buttonIcon,
      style: buttonStyle,
      iconAlignment: IconAlignment.end,
      onPressed: () {
        selectedFilter != null
            ? onUnselect()
            : showModalBottomSheet(
                context: context,
                useSafeArea: true,
                shape: const ContinuousRectangleBorder(),
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: ColorConstants.offBlack,
                        height: filterBarSize,
                        width: double.maxFinite,
                        child: Center(child: Text(unselectedLabel)),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: ListView.builder(
                          itemCount: buttonTitles.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    onPressed(buttonTitles[index]);
                                  },
                                  child: SizedBox(
                                    height: filterBarSize,
                                    width: double.maxFinite,
                                    child: FilterBar<T>(
                                      title: buttonTitles[index],
                                    ),
                                  ),
                                ),
                                const Divider(height: 2),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
      },
      label: Text(buttonLabel.capitalizeFirstLetter(), style: buttonLabelStyle),
    );
  }
}

class FilterBar<T extends Enum> extends StatelessWidget {
  final T title;
  const FilterBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsetsGeometry.only(left: Paddings.low.value),
        child: Text(
          title.name.capitalizeFirstLetter(),
        ),
      ),
    );
  }
}
