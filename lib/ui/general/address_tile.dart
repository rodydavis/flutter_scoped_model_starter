import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

import '../../constants.dart';
import '../../data/models/general/address.dart';
import '../../keys.dart';
import '../../utils/openMaps.dart';

class AddressTile extends StatelessWidget {
  final String label, address;
  final IconData icon;

  AddressTile({
    @required this.address,
    this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (address == null || address.isEmpty) {
      return ListTile(
          leading: Icon(icon ?? Icons.map),
          title: Text(
            label ?? 'Address',
            textScaleFactor: textScaleFactor,
          ),
          subtitle: Text(
            "No Address Found",
            textScaleFactor: textScaleFactor,
          ));
    }
    return ListTile(
      leading: Icon(icon ?? Icons.map),
      title: Text(
        label ?? 'Address',
        textScaleFactor: textScaleFactor,
      ),
      subtitle: Text(
        address,
        textScaleFactor: textScaleFactor,
      ),
      onTap: () => openMaps(context,
          address.toString().replaceAll('\n', ' ').replaceAll(',', '')),
    );
  }
}

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class AddressInputTile extends StatefulWidget {
  final String label;
  final Address address;
  final ValueChanged<Address> addressChanged;

  AddressInputTile({
    this.addressChanged,
    this.address,
    this.label,
  });

  @override
  _AddressInputTileState createState() => _AddressInputTileState();
}

class _AddressInputTileState extends State<AddressInputTile> {
  Mode _mode = Mode.fullscreen;

  TextEditingController _street, _apartment, _city, _state, _zip;
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  @override
  void initState() {
    _street = TextEditingController(text: widget?.address?.street ?? "");
    _apartment = TextEditingController(text: widget?.address?.apartment ?? "");
    _city = TextEditingController(text: widget?.address?.city ?? "");
    _state = TextEditingController(text: widget?.address?.state ?? "");
    _zip = TextEditingController(text: widget?.address?.zip ?? "");
    super.initState();
  }

  Address get address {
    var _address = Address(
      street: _street?.text ?? "",
      apartment: _apartment?.text ?? "",
      city: _city?.text ?? "",
      state: _state?.text ?? "",
      zip: _zip?.text ?? "",
    );
    // if (_address.raw().isEmpty) return null;
    return _address;
  }

  void onError(PlacesAutocompleteResponse response) {
    print(response);
  }

  Future<void> _handlePressButton(BuildContext context) async {
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: "en",
    );

    if (p != null) {
      print(p.description);

      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);

      for (var _item in detail?.result?.addressComponents) {
        if (_item?.types?.contains("street_number") ?? false) {
          _street.text = _item.longName;
        }
        if (_item?.types?.contains("route") ?? false) {
          _street.text += " " + _item.longName;
        }
        if (_item?.types?.contains("locality") ?? false) {
          _city.text = _item.longName;
        }
        if (_item?.types?.contains("administrative_area_level_1") ?? false) {
          _state.text = _item.shortName;
        }
        if (_item?.types?.contains("postal_code") ?? false) {
          _zip.text = _item.shortName;
        }
      }

      setState(() {});

      widget.addressChanged(address);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isEditing)
      return ListTile(
        leading: IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _handlePressButton(context)),
        title: Text(
          widget?.label ?? "Address",
          style: Theme.of(context).textTheme?.body1,
        ),
        subtitle: address == null || address.raw().trim().isEmpty
            ? Text("No Address Added")
            : Text(address.toString()),
        trailing: Icon(address == null || address.raw().trim().isEmpty
            ? Icons.add
            : Icons.edit),
        onTap: () {
          setState(() {
            _isEditing = !_isEditing;
          });
        },
      );
    return ListTile(
      title: Form(
        autovalidate: true,
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Street"),
              controller: _street,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Apartment"),
              controller: _apartment,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "City"),
              controller: _city,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "State"),
              controller: _state,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Zip"),
              controller: _zip,
            ),
          ],
        ),
        onChanged: () {
          widget.addressChanged(address);
        },
      ),
      trailing: Icon(Icons.close),
      onTap: () {
        setState(() {
          _isEditing = !_isEditing;
        });
      },
    );
  }
}
