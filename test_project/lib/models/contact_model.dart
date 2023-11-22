class ContactRequestModel {
  final String name;
  final String email;
  final String message;

  const ContactRequestModel({
    this.name = '',
    this.email = '',
    this.message = '',
  });

  ContactRequestModel copyWidth({
    String? name,
    String? email,
    String? message,
  }) {
    return ContactRequestModel(
      name: name ?? this.name,
      email: email ?? this.email,
      message: message ?? this.message,
    );
  }
}
