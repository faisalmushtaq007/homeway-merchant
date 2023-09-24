part of 'package:homemakers_merchant/app/features/dashboard/index.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessProfileBloc, BusinessProfileState>(
      bloc: context.read<BusinessProfileBloc>(),
      builder: (context, state) {
        BusinessProfileEntity? businessProfileEntity;
        if (state is GetBusinessProfileState) {
          businessProfileEntity = state.businessProfileEntity;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Hi, ',
                        style: context.headlineLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 0.9,
                          fontSize: 30,
                          color: Color.fromRGBO(255, 125, 113, 1),
                        ),
                      ),
                      TextSpan(
                        text: 'Nura',
                        style: context.headlineLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 0.9,
                          fontSize: 30,
                          //color: Color.fromRGBO(255, 125, 113, 1),
                        ),
                      ),
                    ],
                  ),
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  style: context.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 0.9,
                    fontSize: 30,
                    //color: Color.fromRGBO(255, 125, 113, 1),
                  ),
                ).translate(),
              ],
            ),
            const AnimatedGap(8, duration: Duration(milliseconds: 500)),
            Wrap(
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
              children: [
                Text(
                  'Welcome again.',
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  style: GoogleFonts.raleway(
                    textStyle: context.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      height: 0.9,
                      fontSize: 20,
                      //color: Color.fromRGBO(255, 125, 113, 1),
                    ),
                  ),
                ).translate(),
              ],
            ),
            const AnimatedGap(8, duration: Duration(milliseconds: 500)),
          ],
        );
      },
    );
  }
}
