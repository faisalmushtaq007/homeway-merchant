import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_makers_customer_cli/app/core/commons/widgets/map/google_map_place/google_map_place.dart';
import 'package:home_makers_customer_cli/app/core/theme/app_colors.dart';
import '../../address_list_index.dart';

class AddressListPage extends GetView<AddressListController> {
  AddressListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressListController>(
      init: AddressListController(),
      id: "address_list",
      builder: (c) {
        return WillPopScope(
          onWillPop: () async {
            c.backButton();
            return true;
          },
          child: Scaffold(
            //appBar: AppBar(title: const Text('Choose delivery location')),
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Stack(
                        children: [
                          Animarker(
                            curve: Curves.ease,
                            mapId: c.mapcontroller.future
                                .then<int>((value) => value.mapId),
                            //Grab Google Map Id
                            markers: c.markers.values.toSet(),
                            rippleRadius: 0.12,
                            rippleColor: Colors.teal,
                            rippleDuration: Duration(milliseconds: 2500),
                            useRotation: false,
                            shouldAnimateCamera: true,
                            key: Key(c.markedIdOfCurrentUser),
                            child: GoogleMap(
                              scrollGesturesEnabled: true,
                              initialCameraPosition: c.cameraPosition!,
                              onMapCreated: c.mapCreated,
                              //onCameraMoveStarted: c.onCameraMoveStarted,
                              //onCameraIdle: c.onCameraIdle,
                              onCameraMove: c.onCameraMove,
                              //minMaxZoomPreference: MinMaxZoomPreference(14, 100),
                              tiltGesturesEnabled: true,
                              rotateGesturesEnabled: true,
                              onTap: c.onTapOnMap,
                              zoomGesturesEnabled: true,
                              zoomControlsEnabled: true,
                              gestureRecognizers: Set()
                                ..add(Factory<EagerGestureRecognizer>(
                                    () => EagerGestureRecognizer()))
                                ..add(
                                  Factory<OneSequenceGestureRecognizer>(
                                    () => new EagerGestureRecognizer(),
                                  ),
                                ),
                              key: const Key('address-picker-map'),
                            ),
                          ),
                          Positioned(
                            top: 60,
                            left: MediaQuery.of(context).size.width * 0.05,
                            child: Container(
                              child: SearchGooglePlacesWidget(
                                apiKey:
                                    'AIzaSyB6wUuIm0xLJbTFm6qPiwKgULJupJ8IE8s',
                                // The language of the autocompletion
                                language: 'en',
                                // The position used to give better recommendations. In this case we are using the user position
                                radius: 30000,
                                location: c.defaultLatLng,
                                onSelected: c.onSelected,
                                onSearch: (Place place) {},
                                onNewSearch: c.onNewSearch,
                                onNewSelected: c.onNewSelected,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                await c.fetchUserLocation();
                                return;
                              },
                              icon: Icon(Icons.gps_fixed_outlined),
                              label: Text(
                                'Use current location',
                              ),
                              style: OutlinedButton.styleFrom(
                                //foregroundColor: Get.theme.primaryColor,
                                backgroundColor: Colors.white,
                                foregroundColor: kMainColor,
                                //minimumSize: Size(88, 36),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                side: BorderSide(color: kMainColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text('Select Delivery location',
                              style: Theme.of(context).textTheme.titleSmall),
                          SizedBox(
                            height: 12,
                          ),
                          Flexible(
                            child: Text(
                              '${c.displayName}',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                            onPressed: c.navigateToCompleteAddressScreen,
                            child: Text(
                              'Confirm Location',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kMainColor,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

