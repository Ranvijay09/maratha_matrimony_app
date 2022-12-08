class MyUser {
  //basic info
  final String uid;
  final String email;
  final String phoneNo;
  final String firstName;
  final String middleName;
  final String lastName;
  final String gender;
  final DateTime dob;
  final String maritalStatus;
  final String noOfChildren;
  final String childrenLivingStatus;
  final String subCast;
  final String highestEducation;
  final String educationStream;
  final String occupation;
  final String annualIncome;

  //address
  final String address;
  final String city;
  final String tehsil;
  final String district;
  final String state;

  //socio religious attributes
  final String gothra;
  final String rashi;
  final String horosMatch;
  final String manglik;
  final String birthState;
  final String birthDistrict;
  final String birthcity;
  final String birthTehsil;
  final String birthTime;

  //expectations from spouse
  final String spouseHighestEducation;
  final String spouseEducationStream;
  final String spouseOccupation;
  final String spouseDietPreference;
  final String spouseAnnualIncome;
  final int spouseAgeDifference;
  final String spouseMaritalStatus;
  final String spouseComplexion;
  final String spouseBodyType;
  final String spouseSmokingHabit;
  final String spouseDrinkingHabit;
  final String spouseOtherExpectations;

  //physical attributes
  final int height;
  final int weight;
  final String bloodGroup;
  final String complexion;
  final String physicalStatus;
  final String bodyType;
  final String diet;
  final String smoke;
  final String drink;

  //other
  final String photoUrl;
  final String varificationDocUrl;
  final bool isVerified;

  MyUser({
    required this.uid,
    required this.email,
    required this.phoneNo,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.gender,
    required this.dob,
    required this.maritalStatus,
    required this.noOfChildren,
    required this.childrenLivingStatus,
    required this.subCast,
    required this.highestEducation,
    required this.educationStream,
    required this.occupation,
    required this.annualIncome,

    //address
    required this.address,
    required this.city,
    required this.tehsil,
    required this.district,
    required this.state,

    //socio religious attributes
    required this.gothra,
    required this.rashi,
    required this.horosMatch,
    required this.manglik,
    required this.birthState,
    required this.birthDistrict,
    required this.birthTehsil,
    required this.birthcity,
    required this.birthTime,

    //expectations from spouse
    required this.spouseHighestEducation,
    required this.spouseEducationStream,
    required this.spouseOccupation,
    required this.spouseDietPreference,
    required this.spouseAnnualIncome,
    required this.spouseAgeDifference,
    required this.spouseMaritalStatus,
    required this.spouseComplexion,
    required this.spouseBodyType,
    required this.spouseSmokingHabit,
    required this.spouseDrinkingHabit,
    required this.spouseOtherExpectations,

    //physical attributes
    required this.height,
    required this.weight,
    required this.bloodGroup,
    required this.complexion,
    required this.physicalStatus,
    required this.bodyType,
    required this.diet,
    required this.smoke,
    required this.drink,

    //other
    required this.photoUrl,
    required this.varificationDocUrl,
    this.isVerified = false,
  });
}
