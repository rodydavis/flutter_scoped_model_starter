// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactDetails _$ContactDetailsFromJson(Map<String, dynamic> json) {
  return ContactDetails(
      firstName: json['First_Name'] as String,
      lastName: json['Last_Name'] as String,
      email: json['Email_Address'] as String,
      address: json['Address'] == null
          ? null
          : Address.fromJson(json['Address'] as Map<String, dynamic>),
      homePhone: json['Home_Phone'] == null
          ? null
          : Phone.fromJson(json['Home_Phone'] as Map<String, dynamic>),
      cellPhone: json['Cell_Phone'] == null
          ? null
          : Phone.fromJson(json['Cell_Phone'] as Map<String, dynamic>),
      officePhone: json['Office_Phone'] == null
          ? null
          : Phone.fromJson(json['Office_Phone'] as Map<String, dynamic>),
      companyCategory: json['Company_Category'] == null
          ? null
          : CompanyCategory.fromJson(
              json['Company_Category'] as Map<String, dynamic>),
      contactGroups: (json['Contact_Groups'] as List)
          ?.map((e) => e == null
              ? null
              : ContactGroup.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      faxPhone: json['Fax_Phone'] == null
          ? null
          : Phone.fromJson(json['Fax_Phone'] as Map<String, dynamic>),
      secondCellPhone: json['Secondary_Cell_Phone'] == null
          ? null
          : Phone.fromJson(
              json['Secondary_Cell_Phone'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ContactDetailsToJson(ContactDetails instance) =>
    <String, dynamic>{
      'First_Name': instance.firstName,
      'Last_Name': instance.lastName,
      'Email_Address': instance.email,
      'Address': instance.address,
      'Cell_Phone': instance.cellPhone,
      'Office_Phone': instance.officePhone,
      'Home_Phone': instance.homePhone,
      'Fax_Phone': instance.faxPhone,
      'Secondary_Cell_Phone': instance.secondCellPhone,
      'Company_Category': instance.companyCategory,
      'Contact_Groups': instance.contactGroups
    };
