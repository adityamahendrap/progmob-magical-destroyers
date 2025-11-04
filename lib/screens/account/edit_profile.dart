import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lelang_app/widgets/full_width_button.dart';
import 'package:lelang_app/widgets/twin_buttons.dart';
import 'package:lelang_app/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:lelang_app/widgets/app_bar_with_back_button.dart';
import 'package:lelang_app/widgets/app_snack_bar.dart';
import 'package:lelang_app/widgets/full_width_button_bottom_bar.dart';
import 'package:lelang_app/widgets/input/text_input.dart' as input;
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

final List<String> genders = [
  'Male',
  'Female',
];

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _countrySearchController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  List countries = [];

  String? _tempBirthday;
  String? selectedGender;

  String initialCountry = 'ID';
  PhoneNumber number = PhoneNumber(isoCode: 'ID');

  @override
  void initState() {
    super.initState();
    loadJson();
    _nameController.text = 'Aditya Mahendra';
  }

  Future<void> loadJson() async {
    final String jsonString =
        await rootBundle.loadString('lib/configs/constants/countries.json');
    final data = jsonDecode(jsonString);
    setState(() {
      countries = data;
    });
  }

  void _showBirthdayDatePicker() {
    bottomSheetFitContentWrapper(
      context: context,
      content: _birthdayDatePicker(),
    );
  }

  String? _checkName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  bool _validateInput() {
    return _checkName(_nameController.text) == null;
  }

  void save() async {
    if (!_validateInput()) {
      AppSnackBar.error("Failed", "Please fill the form correctly");
      return;
    }

    AppSnackBar.success("Success", "Profile updated");
  }

  @override
  Widget build(BuildContext context) {
    _birthdayController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWithBackButton(title: 'Edit Profile', centerTitle: true),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Form(
                    child: Column(
                      children: [
                        input.TextInput(
                          title: 'Name',
                          hintText: 'Name',
                          prefixIcon: Icons.person_outline,
                          controller: _nameController,
                          validator: _checkName,
                        ),
                        SizedBox(height: 20),
                        _birthdayInput(),
                        SizedBox(height: 20),
                        _genderInput(),
                        SizedBox(height: 20),
                        _countryInput(),
                        SizedBox(height: 20),
                        _phoneNumberInput(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          FullWidthButtonBottomBar(
            context: context,
            text: 'Save',
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _birthdayDatePicker() {
    return Column(
      children: [
        SfDateRangePicker(
          backgroundColor: Colors.white,
          // view: DateRangePickerView.century,
          initialSelectedDate: DateTime.now(),
          maxDate: DateTime.now(),
          headerStyle: DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
            backgroundColor: Colors.white,
            textStyle: TextStyle(
              color: ColorPlanet.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          selectionMode: DateRangePickerSelectionMode.single,
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            _tempBirthday = DateFormat('dd/MM/yyyy').format(args.value);
          },
        ),
        SizedBox(height: 10),
        TwinButtons(
          textOkButton: "OK",
          textCancelButton: "Cancel",
          onPressedOkButton: () {
            _birthdayController.text = _tempBirthday!;
            Get.back();
          },
          onPressedCancelButton: () {
            Get.back();
          },
        ),
      ],
    );
  }

  Widget _birthdayInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: input.TextInput(
            title: 'Birthday',
            hintText: 'Birthday',
            prefixIcon: Icons.cake_outlined,
            controller: _birthdayController,
            readOnly: true,
            onTap: _showBirthdayDatePicker,
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => _showBirthdayDatePicker(),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorPlanet.primary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _genderInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField2<String>(
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          hint: const Text(
            'Select Your Gender',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          items: genders
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 14),
                    ),
                  ))
              .toList(),
          validator: (value) {},
          onChanged: (value) {},
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_drop_down, color: Colors.black45),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            padding: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 38, // default is 48
          ),
        ),
      ],
    );
  }

  Widget _countryInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Country',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField2<String>(
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          hint: const Text(
            'Select Your Country',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          items: countries
              .map((item) => DropdownMenuItem<String>(
                    value: item['name'],
                    child: Text(
                      item['name'],
                      style: TextStyle(fontSize: 14),
                    ),
                  ))
              .toList(),
          validator: (value) {},
          onChanged: (value) {},
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_drop_down, color: Colors.black45),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            scrollbarTheme: ScrollbarThemeData(
              trackColor: MaterialStateProperty.all(ColorPlanet.primary),
              thumbColor: MaterialStateProperty.all(ColorPlanet.primary),
            ),
            padding: EdgeInsets.symmetric(vertical: 12),
            maxHeight: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 38, // default is 48
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: _countrySearchController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: _countrySearchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.search, color: Colors.black),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search for a country',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(101, 241, 241, 241),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.value.toString().contains(searchValue) ||
                  item.value.toString().toLowerCase().contains(searchValue) ||
                  item.value.toString().toUpperCase().contains(searchValue);
            },
          ),
        ),
      ],
    );
  }

  Widget _phoneNumberInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            print(number.phoneNumber);
          },
          onInputValidated: (bool value) {
            print(value);
          },
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.DROPDOWN,
            useBottomSheetSafeArea: false,
            setSelectorButtonAsPrefixIcon: true,
            trailingSpace: false,
            useEmoji: true,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          initialValue: number,
          textFieldController: _phoneNumberController,
          formatInput: true,
          inputDecoration: InputDecoration(
            prefix: SizedBox(width: 10),
            hintText: 'Phone Number',
            hintStyle: TextStyle(color: Color(0xff9E9E9E)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            filled: true,
            fillColor: Color.fromARGB(101, 241, 241, 241),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          onSaved: (PhoneNumber number) {
            print('On Saved: $number');
          },
        ),
      ],
    );
  }
}
