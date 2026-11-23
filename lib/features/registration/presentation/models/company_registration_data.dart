class CompanyRegistrationData {
  const CompanyRegistrationData({
    required this.referenceCode,
    required this.companyName,
    required this.companyEmail,
    required this.contactPerson,
    required this.phone,
    required this.industryId,
    required this.companySizeId,
    required this.countryId,
    required this.notes,
  });

  final String referenceCode;
  final String companyName;
  final String companyEmail;
  final String contactPerson;
  final String phone;
  final String industryId;
  final String companySizeId;
  final String countryId;
  final String notes;
}

