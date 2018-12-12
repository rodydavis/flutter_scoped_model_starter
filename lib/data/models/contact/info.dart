import '../general/address.dart';
import '../general/company_category.dart';
import '../general/contact_groups.dart';
import '../general/phones.dart';

class ContactDetailsResult {
  String status;
  String message;
  ContactDetails result;

  ContactDetailsResult({this.status, this.message, this.result});

  ContactDetailsResult.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    result = json['Result'] != null
        ? new ContactDetails.fromJson(json['Result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.result != null) {
      data['Result'] = this.result.toJson();
    }
    return data;
  }
}

class ContactDetails {
  String firstName;
  String middleName;
  String lastName;
  String email;
  Address address;
  List<Phones> phones;
  String birthdate;
  String integrationId;
  CompanyCategory companyCategory;
  List<ContactGroups> contactGroups;

  ContactDetails(
      {this.firstName,
      this.middleName,
      this.lastName,
      this.email,
      this.address,
      this.phones,
      this.birthdate,
      this.integrationId,
      this.companyCategory,
      this.contactGroups});

  ContactDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['phones'] != null) {
      phones = new List<Phones>();
      json['phones'].forEach((v) {
        phones.add(new Phones.fromJson(v));
      });
    }
    birthdate = json['birthdate'];
    integrationId = json['integration_id'];
    companyCategory = json['company_category'] != null
        ? new CompanyCategory.fromJson(json['company_category'])
        : null;
    if (json['contact_groups'] != null) {
      contactGroups = new List<ContactGroups>();
      json['contact_groups'].forEach((v) {
        contactGroups.add(new ContactGroups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.phones != null) {
      data['phones'] = this.phones.map((v) => v.toJson()).toList();
    }
    data['birthdate'] = this.birthdate;
    data['integration_id'] = this.integrationId;
    if (this.companyCategory != null) {
      data['company_category'] = this.companyCategory.toJson();
    }
    if (this.contactGroups != null) {
      data['contact_groups'] =
          this.contactGroups.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactDetailsEditResult {
  String status;
  String message;
  ContactDetailsReturn result;

  ContactDetailsEditResult({this.status, this.message, this.result});

  ContactDetailsEditResult.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    result = json['Result'] != null
        ? new ContactDetailsReturn.fromJson(json['Result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.result != null) {
      data['Result'] = this.result.toJson();
    }
    return data;
  }
}

class ContactDetailsReturn {
  String contactID;
  String userID;
  String integrationID;
  double companyCategory;
  double lOSCategory;
  String contactSSNToken;
  String firstName;
  String middleName;
  String lastName;
  String suffix;
  String secondaryFirstName;
  String secondaryMiddleName;
  String secondaryLastName;
  String company;
  String address1;
  String address2;
  String city;
  String state;
  String zip;
  String homePhoneAreaCode;
  String homePhonePrefix;
  String homePhoneNumber;
  String officePhoneAreaCode;
  String officePhonePrefix;
  String officePhoneNumber;
  String officePhoneExt;
  String cellPhoneAreaCode;
  String cellPhonePrefix;
  String cellPhoneNumber;
  String faxAreaCode;
  String faxPrefix;
  String faxNumber;
  String secondaryCellAreaCode;
  String secondaryCellPrefix;
  String secondaryCellNumber;
  String website;
  String emailAddress;
  String secondaryEmailAddress;
  String salutation;
  String birthdate;
  String secondaryBirthdate;
  double contactPriority;
  int dTIRatio;
  int ficoScore;
  String loanNumber;
  String loanPurpose;
  String closingDate;
  double interestRate;
  double loanAmount;
  double appraisedValue;
  double purchasePrice;
  double lTVRatio;
  double monthlyPayment;
  double pIPayment;
  double loanTerm;
  double targetRefiRate;
  String loanType;
  String propertyType;
  String occupancy;
  String referralFirstName;
  String referralLastName;
  String referralType;
  String referralCompany;
  String referralEmail;
  String referralPhoneAreaCode;
  String referralPhonePrefix;
  String referralPhoneNumber;
  double contactStatus;
  String contactPIN;
  String contactPassword;
  bool optOutEmail;
  String dateOOEmail;
  bool optOutDirectMail;
  String dateOODirectMail;
  bool optOutConcierge;
  String dateOOConcierge;
  bool optOutPhoneCalls;
  String dateOOPhoneCalls;
  bool optOutByContact;
  String dateOOByContact;
  String dateCreated;
  String dateModified;
  String dateLastLogin;
  double action;

  ContactDetailsReturn(
      {this.contactID,
      this.userID,
      this.integrationID,
      this.companyCategory,
      this.lOSCategory,
      this.contactSSNToken,
      this.firstName,
      this.middleName,
      this.lastName,
      this.suffix,
      this.secondaryFirstName,
      this.secondaryMiddleName,
      this.secondaryLastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.zip,
      this.homePhoneAreaCode,
      this.homePhonePrefix,
      this.homePhoneNumber,
      this.officePhoneAreaCode,
      this.officePhonePrefix,
      this.officePhoneNumber,
      this.officePhoneExt,
      this.cellPhoneAreaCode,
      this.cellPhonePrefix,
      this.cellPhoneNumber,
      this.faxAreaCode,
      this.faxPrefix,
      this.faxNumber,
      this.secondaryCellAreaCode,
      this.secondaryCellPrefix,
      this.secondaryCellNumber,
      this.website,
      this.emailAddress,
      this.secondaryEmailAddress,
      this.salutation,
      this.birthdate,
      this.secondaryBirthdate,
      this.contactPriority,
      this.dTIRatio,
      this.ficoScore,
      this.loanNumber,
      this.loanPurpose,
      this.closingDate,
      this.interestRate,
      this.loanAmount,
      this.appraisedValue,
      this.purchasePrice,
      this.lTVRatio,
      this.monthlyPayment,
      this.pIPayment,
      this.loanTerm,
      this.targetRefiRate,
      this.loanType,
      this.propertyType,
      this.occupancy,
      this.referralFirstName,
      this.referralLastName,
      this.referralType,
      this.referralCompany,
      this.referralEmail,
      this.referralPhoneAreaCode,
      this.referralPhonePrefix,
      this.referralPhoneNumber,
      this.contactStatus,
      this.contactPIN,
      this.contactPassword,
      this.optOutEmail,
      this.dateOOEmail,
      this.optOutDirectMail,
      this.dateOODirectMail,
      this.optOutConcierge,
      this.dateOOConcierge,
      this.optOutPhoneCalls,
      this.dateOOPhoneCalls,
      this.optOutByContact,
      this.dateOOByContact,
      this.dateCreated,
      this.dateModified,
      this.dateLastLogin,
      this.action});

  ContactDetailsReturn.fromJson(Map<String, dynamic> json) {
    contactID = json['Contact_ID'];
    userID = json['User_ID'];
    integrationID = json['Integration_ID'];
    companyCategory = json['Company_Category'];
    lOSCategory = json['LOS_Category'];
    contactSSNToken = json['Contact_SSN_Token'];
    firstName = json['First_Name'];
    middleName = json['Middle_Name'];
    lastName = json['Last_Name'];
    suffix = json['Suffix'];
    secondaryFirstName = json['Secondary_First_Name'];
    secondaryMiddleName = json['Secondary_Middle_Name'];
    secondaryLastName = json['Secondary_Last_Name'];
    company = json['Company'];
    address1 = json['Address1'];
    address2 = json['Address2'];
    city = json['City'];
    state = json['State'];
    zip = json['Zip'];
    homePhoneAreaCode = json['Home_Phone_Area_Code'];
    homePhonePrefix = json['Home_Phone_Prefix'];
    homePhoneNumber = json['Home_Phone_Number'];
    officePhoneAreaCode = json['Office_Phone_Area_Code'];
    officePhonePrefix = json['Office_Phone_Prefix'];
    officePhoneNumber = json['Office_Phone_Number'];
    officePhoneExt = json['Office_Phone_Ext'];
    cellPhoneAreaCode = json['Cell_Phone_Area_Code'];
    cellPhonePrefix = json['Cell_Phone_Prefix'];
    cellPhoneNumber = json['Cell_Phone_Number'];
    faxAreaCode = json['Fax_Area_Code'];
    faxPrefix = json['Fax_Prefix'];
    faxNumber = json['Fax_Number'];
    secondaryCellAreaCode = json['Secondary_Cell_Area_Code'];
    secondaryCellPrefix = json['Secondary_Cell_Prefix'];
    secondaryCellNumber = json['Secondary_Cell_Number'];
    website = json['Website'];
    emailAddress = json['Email_Address'];
    secondaryEmailAddress = json['Secondary_Email_Address'];
    salutation = json['Salutation'];
    birthdate = json['Birthdate'];
    secondaryBirthdate = json['Secondary_Birthdate'];
    contactPriority = json['Contact_Priority'];
    dTIRatio = json['DTI_Ratio'];
    ficoScore = json['Fico_Score'];
    loanNumber = json['Loan_Number'];
    loanPurpose = json['Loan_Purpose'];
    closingDate = json['Closing_Date'];
    interestRate = json['Interest_Rate'];
    loanAmount = json['Loan_Amount'];
    appraisedValue = json['Appraised_Value'];
    purchasePrice = json['Purchase_Price'];
    lTVRatio = json['LTV_Ratio'];
    monthlyPayment = json['Monthly_Payment'];
    pIPayment = json['PI_Payment'];
    loanTerm = json['Loan_Term'];
    targetRefiRate = json['Target_Refi_Rate'];
    loanType = json['Loan_Type'];
    propertyType = json['Property_Type'];
    occupancy = json['Occupancy'];
    referralFirstName = json['Referral_First_Name'];
    referralLastName = json['Referral_Last_Name'];
    referralType = json['Referral_Type'];
    referralCompany = json['Referral_Company'];
    referralEmail = json['Referral_Email'];
    referralPhoneAreaCode = json['Referral_Phone_Area_Code'];
    referralPhonePrefix = json['Referral_Phone_Prefix'];
    referralPhoneNumber = json['Referral_Phone_Number'];
    contactStatus = json['Contact_Status'];
    contactPIN = json['Contact_PIN'];
    contactPassword = json['Contact_Password'];
    optOutEmail = json['Opt_Out_Email'];
    dateOOEmail = json['Date_OO_Email'];
    optOutDirectMail = json['Opt_Out_Direct_Mail'];
    dateOODirectMail = json['Date_OO_Direct_Mail'];
    optOutConcierge = json['Opt_Out_Concierge'];
    dateOOConcierge = json['Date_OO_Concierge'];
    optOutPhoneCalls = json['Opt_Out_Phone_Calls'];
    dateOOPhoneCalls = json['Date_OO_Phone_Calls'];
    optOutByContact = json['Opt_Out_By_Contact'];
    dateOOByContact = json['Date_OO_By_Contact'];
    dateCreated = json['Date_Created'];
    dateModified = json['Date_Modified'];
    dateLastLogin = json['Date_Last_Login'];
    action = json['Action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Contact_ID'] = this.contactID;
    data['User_ID'] = this.userID;
    data['Integration_ID'] = this.integrationID;
    data['Company_Category'] = this.companyCategory;
    data['LOS_Category'] = this.lOSCategory;
    data['Contact_SSN_Token'] = this.contactSSNToken;
    data['First_Name'] = this.firstName;
    data['Middle_Name'] = this.middleName;
    data['Last_Name'] = this.lastName;
    data['Suffix'] = this.suffix;
    data['Secondary_First_Name'] = this.secondaryFirstName;
    data['Secondary_Middle_Name'] = this.secondaryMiddleName;
    data['Secondary_Last_Name'] = this.secondaryLastName;
    data['Company'] = this.company;
    data['Address1'] = this.address1;
    data['Address2'] = this.address2;
    data['City'] = this.city;
    data['State'] = this.state;
    data['Zip'] = this.zip;
    data['Home_Phone_Area_Code'] = this.homePhoneAreaCode;
    data['Home_Phone_Prefix'] = this.homePhonePrefix;
    data['Home_Phone_Number'] = this.homePhoneNumber;
    data['Office_Phone_Area_Code'] = this.officePhoneAreaCode;
    data['Office_Phone_Prefix'] = this.officePhonePrefix;
    data['Office_Phone_Number'] = this.officePhoneNumber;
    data['Office_Phone_Ext'] = this.officePhoneExt;
    data['Cell_Phone_Area_Code'] = this.cellPhoneAreaCode;
    data['Cell_Phone_Prefix'] = this.cellPhonePrefix;
    data['Cell_Phone_Number'] = this.cellPhoneNumber;
    data['Fax_Area_Code'] = this.faxAreaCode;
    data['Fax_Prefix'] = this.faxPrefix;
    data['Fax_Number'] = this.faxNumber;
    data['Secondary_Cell_Area_Code'] = this.secondaryCellAreaCode;
    data['Secondary_Cell_Prefix'] = this.secondaryCellPrefix;
    data['Secondary_Cell_Number'] = this.secondaryCellNumber;
    data['Website'] = this.website;
    data['Email_Address'] = this.emailAddress;
    data['Secondary_Email_Address'] = this.secondaryEmailAddress;
    data['Salutation'] = this.salutation;
    data['Birthdate'] = this.birthdate;
    data['Secondary_Birthdate'] = this.secondaryBirthdate;
    data['Contact_Priority'] = this.contactPriority;
    data['DTI_Ratio'] = this.dTIRatio;
    data['Fico_Score'] = this.ficoScore;
    data['Loan_Number'] = this.loanNumber;
    data['Loan_Purpose'] = this.loanPurpose;
    data['Closing_Date'] = this.closingDate;
    data['Interest_Rate'] = this.interestRate;
    data['Loan_Amount'] = this.loanAmount;
    data['Appraised_Value'] = this.appraisedValue;
    data['Purchase_Price'] = this.purchasePrice;
    data['LTV_Ratio'] = this.lTVRatio;
    data['Monthly_Payment'] = this.monthlyPayment;
    data['PI_Payment'] = this.pIPayment;
    data['Loan_Term'] = this.loanTerm;
    data['Target_Refi_Rate'] = this.targetRefiRate;
    data['Loan_Type'] = this.loanType;
    data['Property_Type'] = this.propertyType;
    data['Occupancy'] = this.occupancy;
    data['Referral_First_Name'] = this.referralFirstName;
    data['Referral_Last_Name'] = this.referralLastName;
    data['Referral_Type'] = this.referralType;
    data['Referral_Company'] = this.referralCompany;
    data['Referral_Email'] = this.referralEmail;
    data['Referral_Phone_Area_Code'] = this.referralPhoneAreaCode;
    data['Referral_Phone_Prefix'] = this.referralPhonePrefix;
    data['Referral_Phone_Number'] = this.referralPhoneNumber;
    data['Contact_Status'] = this.contactStatus;
    data['Contact_PIN'] = this.contactPIN;
    data['Contact_Password'] = this.contactPassword;
    data['Opt_Out_Email'] = this.optOutEmail;
    data['Date_OO_Email'] = this.dateOOEmail;
    data['Opt_Out_Direct_Mail'] = this.optOutDirectMail;
    data['Date_OO_Direct_Mail'] = this.dateOODirectMail;
    data['Opt_Out_Concierge'] = this.optOutConcierge;
    data['Date_OO_Concierge'] = this.dateOOConcierge;
    data['Opt_Out_Phone_Calls'] = this.optOutPhoneCalls;
    data['Date_OO_Phone_Calls'] = this.dateOOPhoneCalls;
    data['Opt_Out_By_Contact'] = this.optOutByContact;
    data['Date_OO_By_Contact'] = this.dateOOByContact;
    data['Date_Created'] = this.dateCreated;
    data['Date_Modified'] = this.dateModified;
    data['Date_Last_Login'] = this.dateLastLogin;
    data['Action'] = this.action;
    return data;
  }
}

class ContactDeleteResult {
  String status;
  String message;
  String result;

  ContactDeleteResult({this.status, this.message, this.result});

  ContactDeleteResult.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    result = json['Result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    data['Result'] = this.result;
    return data;
  }
}
