class MyUser
{
  String? firstName;
  String? lastName;
  String? email;
  String? profileImage;
  String? token;
  MyUser({this.email,this.firstName,this.lastName,this.profileImage,this.token});
  // User({required this.firstName,required this.lastName,required this.email,required this.photoUrl});
  MyUser.fromJson(Map<String,dynamic> map,String email)
  {
    this.token=map['token'];
    this.firstName=map['first_name'];
    this.lastName=map['last_name'];
    this.email=email;
    if(map.containsKey('profile_image')&&map['profile_image']!=null)
      this.profileImage=map['profile_image'];
  }
}