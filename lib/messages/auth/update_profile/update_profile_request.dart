class UpdateProfileRequest
{
  final String firstName;
  final String lastName;
  UpdateProfileRequest({required this.firstName,required this.lastName});
  Map<String,dynamic> toJson()
  {
    return 
    {
      'first_name':this.firstName,
      'last_name':this.lastName
    };
  }
}