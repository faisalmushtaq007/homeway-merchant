import 'package:flutter/material.dart';
import 'package:homemakers_merchant/shared/widgets/universal/infinity_scroll_pagination/src/widgets/helpers/default_status_indicators/footer_tile.dart';

class NewPageProgressIndicator extends StatelessWidget {
  const NewPageProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const FooterTile(
        child: CircularProgressIndicator(),
      );
}
