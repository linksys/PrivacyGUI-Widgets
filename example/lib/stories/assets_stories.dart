part of '../storybook.dart';

Iterable<Story> imageStories() {
  return [
    
    Story(
      name: 'Assets/Images/General images',
      builder: (context) {
        final List<Named<ImageProvider>> images = CustomTheme.of(context)
            .images
            .props
            .whereType<Named<ImageProvider>>()
            .toList();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: _imageGridView(
            context,
            images,
            itemBuilder: (item) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image(
                    image: item.value,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const AppGap.regular(),
                AppText.labelSmall(item.name)
              ],
            ),
            childAspectRatio: 1.5,
            crossAxisCount: 3,
          ),
        );
      },
    ),
    Story(
      name: 'Assets/Images/General images - SVG',
      description: 'A custom Icon set (SVG) used in app',
      builder: (context) {
        final List<Named<SvgAssetLoader>> images = CustomTheme.of(context)
            .images
            .props
            .whereType<Named<SvgAssetLoader>>()
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: _imageGridView(
            context,
            images,
            itemBuilder: (item) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SvgPicture(
                    item.value,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const AppGap.regular(),
                AppText.labelSmall(item.name)
              ],
            ),
            childAspectRatio: 1.5,
            crossAxisCount: 3,
          ),
        );
      },
    ),
    Story(
      name: 'Assets/Images/Device images',
      description: 'Linksys device image set used in app',
      builder: (context) {
        final List<Named<ImageProvider>> images = CustomTheme.of(context)
            .images
            .devices
            .props
            .whereType<Named<ImageProvider>>()
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: _imageGridView(
            context,
            images,
            itemBuilder: (item) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image(
                    image: item.value,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const AppGap.regular(),
                AppText.labelSmall(item.name)
              ],
            ),
            childAspectRatio: 1.5,
            crossAxisCount: 3,
          ),
        );
      },
    ),
  ];
}

Widget _buildList<T>(List<Named<T>> list) {
  return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(4),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: const EdgeInsets.all(Spacing.regular),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: list[index] is Named<ImageProvider>
                    ? _buildImageSet(list[index].value as ImageProvider)
                    : _buildSvgSet(CustomTheme.of(context),
                        list[index].value as SvgAssetLoader),
              ),
              AppText.bodyMedium(list[index].name)
            ],
          )),
        );
      });
}

List<Widget> _buildImageSet(ImageProvider image) {
  return [
    AppAvatar.extraSmall(image: image),
    const AppGap.regular(),
    AppAvatar.small(image: image),
    const AppGap.regular(),
    AppAvatar.normal(image: image),
    const AppGap.regular(),
    AppAvatar.large(image: image),
    const AppGap.regular(),
    AppAvatar.extraLarge(image: image),
  ];
}

List<Widget> _buildSvgSet(CustomThemeData theme, SvgAssetLoader image) {
  return [
    SvgPicture(
      image,
      width: theme.avatar.extraSmall,
    ),
    const AppGap.regular(),
    SvgPicture(
      image,
      width: theme.avatar.small,
    ),
    const AppGap.regular(),
    SvgPicture(
      image,
      width: theme.avatar.normal,
    ),
    const AppGap.regular(),
    SvgPicture(
      image,
      width: theme.avatar.large,
    ),
    const AppGap.regular(),
    SvgPicture(
      image,
      width: theme.avatar.extraLarge,
    ),
  ];
}

GridView _imageGridView<T>(BuildContext context, List<T> data,
    {required Widget Function(T) itemBuilder,
    int crossAxisCount = 3,
    childAspectRatio = 4}) {
  return GridView.builder(
    shrinkWrap: true,
    padding: const EdgeInsets.all(20),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
    ),
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: itemBuilder(data[index]),
        ),
      );
    },
  );
}
