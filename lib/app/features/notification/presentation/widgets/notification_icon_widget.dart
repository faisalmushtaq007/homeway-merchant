part of 'package:homemakers_merchant/app/features/notification/index.dart';
class NotificationIconWidget extends StatelessWidget {
  const NotificationIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final notification =
        await context.push(Routes.NOTIFICATIONS);
        return;
      },
      icon: Badge(
        alignment: AlignmentDirectional.topEnd,
        //padding: EdgeInsets.all(4),
        backgroundColor: context.colorScheme.secondary,
        isLabelVisible: true,
        largeSize: 16,
        textStyle: const TextStyle(fontSize: 14),
        textColor: Colors.yellow,
        label: Text(
          '10',
          style: context.labelSmall!
              .copyWith(color: context.colorScheme.onPrimary),
          //Color.fromRGBO(251, 219, 11, 1)
        ),
        child: Icon(Icons.notifications,
            color: context.colorScheme.primary),
      ),
    );
  }
}
