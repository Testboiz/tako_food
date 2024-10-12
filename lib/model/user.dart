class UserModel {
  String nama;
  String email;
  String img;

  UserModel({
    required this.nama,
    required this.email,
    required this.img,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      nama: data['name'] ?? '',
      email: data['email'] ?? '',
      img: data['profile_pic'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'email': email,
      'image': img,
    };
  }
}
