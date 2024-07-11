class ChatResponseModel {
  final String response;

  ChatResponseModel({required this.response});

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(
      response: json['response'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'response': response,
    };
  }
}
