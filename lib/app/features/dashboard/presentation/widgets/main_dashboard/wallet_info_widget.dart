part of 'package:homemakers_merchant/app/features/dashboard/index.dart';

class DashboardWalletInfoWidget extends StatelessWidget {
  const DashboardWalletInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(59, 61, 64, 1),
      child: BlocBuilder<WalletBloc, WalletState>(
        bloc: context.read<WalletBloc>(),
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AnimatedGap(
                  16,
                  duration: Duration(milliseconds: 100),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox.square(
                      dimension: 28,
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: Color.fromRGBO(17, 230, 38, 1),
                      ),
                    ),
                    Spacer(),
                    Text(
                      'All Stores',
                      style: context.labelMedium!.copyWith(
                        color: Color.fromRGBO(127, 129, 132, 1),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_up,
                      color: Color.fromRGBO(127, 129, 132, 1),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Earning',
                      style: context.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(17, 230, 38, 1),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '562 SAR',
                      style: context.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(17, 230, 38, 1),
                      ),
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Withdraw',
                          style: context.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(255, 90, 29, 1),
                          ),
                        )),
                  ],
                ),
                const AnimatedGap(
                  12,
                  duration: Duration(milliseconds: 100),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
