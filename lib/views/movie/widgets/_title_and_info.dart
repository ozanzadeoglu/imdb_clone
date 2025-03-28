part of "../movie_details_view.dart";

class _TitleAndInfo extends StatelessWidget {
  const _TitleAndInfo({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title!,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Row(
          children: [
            GreyInfoLabel(data: movie.status),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Paddings.lowlow.value,
                  horizontal: Paddings.medium.value),
              child: GreyInfoLabel(data: movie.releaseDate?.extractYear()),
            ),
          ],
        ),
      ],
    );
  }
}
