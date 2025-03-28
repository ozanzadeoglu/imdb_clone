part of '../tv_series_seasons_view.dart';

class _SeasonContainer extends StatelessWidget {
  final int index;

  const _SeasonContainer({required this.index});

  Border? _changeBorderBottomIfSelected(int selectedItem) {
    return index == selectedItem
        ? const Border(
            bottom: BorderSide(color: ColorConstants.iconYellow, width: 2),
          )
        : const Border(
            bottom: BorderSide(color: ColorConstants.kettleman, width: 2),
          );
  }

  TextStyle? _changeTextStyleIfSelected(int selectedItem) {
    return index == selectedItem
        ? const TextStyle(color: ColorConstants.iconYellow)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    //used context.select so it only rebuilds if selectedItem changes.
    final selectedItem = context.select<TvSeriesSeasonsController, int>(
        (viewModel) => viewModel.selectedItem);
    final controller = context.read<TvSeriesSeasonsController>();

    return GestureDetector(
      onTap: () {
        controller.changeSelectedBox(index);
        controller.pageController.jumpToPage(index);
      },
      child: Container(
        decoration: BoxDecoration(
          border: _changeBorderBottomIfSelected(selectedItem),
        ),
        width: controller.calculateSeasonBoxWidth(context),
        alignment: Alignment.center,
        child: Text(
          (index + 1).toString(),
          style: _changeTextStyleIfSelected(selectedItem),
        ),
      ),
    );
  }
}