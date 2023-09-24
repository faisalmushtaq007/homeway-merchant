part of 'package:homemakers_merchant/app/features/store/index.dart';

class ContactFormItemWidget extends StatefulWidget {
  ContactFormItemWidget(
      {required Key key,
      required this.storeOwnDeliveryPartnerEntity,
      required this.onRemove,
      required this.index})
      : super(key: key);

  final int index;
  final StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnerEntity;
  final Function onRemove;
  final state = _ContactFormItemWidgetState();

  @override
  State<StatefulWidget> createState() => state;

  final TextEditingController _driverNameController = TextEditingController();
  final TextEditingController _driverContactNumberController =
      TextEditingController();
  final TextEditingController _drivingLicenseNumberController =
      TextEditingController();
  FocusNode _driverNameFocusNode = FocusNode();
  FocusNode _driverContactNumberFocusNode = FocusNode();
  FocusNode _drivingLicenseNumberFocusNode = FocusNode();
  bool isValidated() => state.validate();
}

class _ContactFormItemWidgetState extends State<ContactFormItemWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Contact - ${widget.index}',
                      style: context.titleMedium!
                          .copyWith(color: context.colorScheme.primary),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                //Clear All forms Data
                                widget.storeOwnDeliveryPartnerEntity
                                    .driverName = '';
                                widget.storeOwnDeliveryPartnerEntity
                                    .driverMobileNumber = '';
                                widget.storeOwnDeliveryPartnerEntity
                                    .drivingLicenseNumber = '';
                                widget._driverNameController.clear();
                                widget._driverContactNumberController.clear();
                                widget._drivingLicenseNumberController.clear();
                              });
                            },
                            child: Text(
                              'Clear',
                            )),
                        TextButton(
                            onPressed: () => widget.onRemove(),
                            child: Text(
                              'Remove',
                            )),
                      ],
                    ),
                  ],
                ),
                StoreTextFieldWidget(
                  controller: widget._driverNameController,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  focusNode: widget._driverNameFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (_) => fieldFocusChange(
                      context,
                      widget._driverNameFocusNode,
                      widget._driverContactNumberFocusNode),
                  decoration: InputDecoration(
                    hintText: 'Enter driver name',
                    labelText: 'Driver Name',
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixText: 'min',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter driver name';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => widget
                      .storeOwnDeliveryPartnerEntity.driverName = value ?? '',
                  onSaved: (value) => widget
                      .storeOwnDeliveryPartnerEntity.driverName = value ?? '',
                ),
                const AnimatedGap(8, duration: Duration(milliseconds: 500)),
                StoreTextFieldWidget(
                  controller: widget._driverContactNumberController,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  focusNode: widget._driverContactNumberFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (_) => fieldFocusChange(
                      context,
                      widget._driverContactNumberFocusNode,
                      widget._drivingLicenseNumberFocusNode),
                  decoration: InputDecoration(
                    hintText: 'Enter driver contact number',
                    labelText: 'Driver Contact Number',
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixText: 'min',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter driver contact number';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => widget.storeOwnDeliveryPartnerEntity
                      .driverMobileNumber = value ?? '',
                  onSaved: (value) => widget.storeOwnDeliveryPartnerEntity
                      .driverMobileNumber = value ?? '',
                ),
                const AnimatedGap(8, duration: Duration(milliseconds: 500)),
                StoreTextFieldWidget(
                  controller: widget._driverContactNumberController,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  focusNode: widget._drivingLicenseNumberFocusNode,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  //onFieldSubmitted: (_) => fieldFocusChange(context, focusList[7], focusList[8]),
                  decoration: InputDecoration(
                    hintText: 'Enter driving license number',
                    labelText: 'Driving License Number',
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixText: 'min',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter driving license number';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => widget.storeOwnDeliveryPartnerEntity
                      .drivingLicenseNumber = value ?? '',
                  onSaved: (value) => widget.storeOwnDeliveryPartnerEntity
                      .drivingLicenseNumber = value ?? '',
                ),
                const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validate() {
    //Validate Form Fields
    final bool validate = formKey.currentState!.validate();
    if (validate) formKey.currentState!.save();
    return validate;
  }
}
