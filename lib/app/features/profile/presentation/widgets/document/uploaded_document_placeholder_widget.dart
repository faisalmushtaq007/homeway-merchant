part of 'package:homemakers_merchant/app/features/profile/index.dart';

class UploadedDocumentPlaceholderWidget extends StatelessWidget {
  const UploadedDocumentPlaceholderWidget(
      {super.key,
      this.title = 'Upload document',
      this.subTitle = 'Capture document from camera or Browse and choose the document from Gallery that you want to upload.'});

  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.40,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/document_upload.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const AnimatedGap(
          30,
          duration: Duration(milliseconds: 400),
        ),
        Text(
          title!,
          style: context.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
        ),
        const AnimatedGap(
          15,
          duration: Duration(milliseconds: 400),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Text(
            subTitle!,
            textAlign: TextAlign.center,
            style: context.labelLarge,
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
          ),
        ),
        const AnimatedGap(
          15,
          duration: Duration(milliseconds: 400),
        ),
      ],
    );
  }
}
