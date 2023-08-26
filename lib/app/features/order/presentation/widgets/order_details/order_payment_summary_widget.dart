part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderPaymentSummary extends StatelessWidget {
  const OrderPaymentSummary({required this.orderEntity, super.key});

  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(orderEntity.payment.paymentID),
      margin: EdgeInsetsDirectional.only(
        bottom: 8,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 12, end: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          children: [
            const AnimatedGap(
              12,
              duration: Duration(milliseconds: 100),
            ),
            Directionality(
              key: const Key('subTotal-key'),
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              child: RowItem.text(
                'SubTotal',
                orderEntity.payment.amount.toString() + ' SAR',
                titleStyle: context.bodyMedium!.copyWith(fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
                descriptionStyle: context.bodyMedium!.copyWith(fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
              ),
            ),
            Divider(thickness: 0.25),
            Directionality(
              key: const Key('delivery-charge-key'),
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              child: RowItem.text(
                'Delivery Charge',
                orderEntity.payment.deliveryAmount.toString() + ' SAR',
                titleStyle: context.bodyMedium!.copyWith(fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
                descriptionStyle: context.bodyMedium!.copyWith(fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
              ),
            ),
            Divider(thickness: 0.25),
            Directionality(
              key: const Key('service-charge-key'),
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              child: RowItem.text(
                'Service Charge',
                orderEntity.payment.serviceAmount.toString() + ' SAR',
                titleStyle: context.bodyMedium!.copyWith(fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
                descriptionStyle: context.bodyMedium!.copyWith(fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
              ),
            ),
            Divider(thickness: 0.25),
            Directionality(
              key: const Key('tax-key'),
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              child: RowItem.text(
                'Tax',
                orderEntity.payment.tax.toString() + ' SAR',
                titleStyle: context.bodyMedium!.copyWith(fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
                descriptionStyle: context.bodyMedium!.copyWith(fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
              ),
            ),
            Divider(thickness: 1.5),
            Directionality(
              key: const Key('total-key'),
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              child: RowItem.text(
                'Total',
                (orderEntity.payment.amount + orderEntity.payment.deliveryAmount + orderEntity.payment.serviceAmount + orderEntity.payment.tax).toString() +
                    ' SAR',
                titleStyle: context.bodyLarge!.copyWith(fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
                descriptionStyle: context.bodyLarge!.copyWith(fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
              ),
            ),
            const AnimatedGap(
              12,
              duration: Duration(milliseconds: 100),
            ),
          ],
        ),
      ),
    );
  }
}
