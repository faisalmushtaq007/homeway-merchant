part of 'package:homemakers_merchant/app/features/store/index.dart';

class MultiContactFormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MultiContactFormWidgetState();
  }
}

class _MultiContactFormWidgetState extends State<MultiContactFormWidget> {
  List<ContactFormItemWidget> contactForms = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Driver contact form'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoButton(
          color: context.colorScheme.primary,
          onPressed: () {
            onSave();
          },
          child: Text('Save'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: () {
          onAdd();
        },
      ),
      body: contactForms.isNotEmpty
          ? ListView.builder(
              itemCount: contactForms.length,
              itemBuilder: (_, index) {
                return contactForms[index];
              })
          : Center(child: Text('Tap on + to Add Contact')),
    );
  }

  void onSave() {
    bool allValid = true;

    contactForms.forEach((element) => allValid = (allValid && element.isValidated()));

    if (allValid) {
      List<String> names = contactForms.map((e) => e.storeOwnDeliveryPartnerEntity.driverName).toList();
      debugPrint('$names');
    } else {
      debugPrint('Form is Not Valid');
    }
  }

  //Delete specific form
  void onRemove(StoreOwnDeliveryPartnersInfo contact) {
    setState(() {
      int index = contactForms.indexWhere((element) => element.storeOwnDeliveryPartnerEntity.driverID == contact.driverID);
      contactForms.removeAt(index);
    });
  }

  void onAdd() {
    setState(() {
      StoreOwnDeliveryPartnersInfo _contactModel = StoreOwnDeliveryPartnersInfo(driverID: contactForms.length);
      contactForms.add(ContactFormItemWidget(
        index: contactForms.length,
        storeOwnDeliveryPartnerEntity: _contactModel,
        onRemove: () => onRemove(_contactModel),
        key: Key(''),
      ));
    });
  }
}
