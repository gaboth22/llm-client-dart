/// {@template llm_client}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract class LlmClient {
  /// Content is the input to pass to the model.
  /// This returns a future with the string response.
  ///
  /// In order to keep a conversation going and allow the model to understand
  /// previous input, we need to provide previous messages back to the model.
  Future<String> getCompletion({
    required List<LlmClientMessage> messages,
  }) async {
    return Future.value('');
  }
}

/// Defines a role in an [LlmClientMessage]
enum LlmClientMessageRole {
  /// The system role also known as the system message is included at the
  /// beginning of the message array. This message provides the initial
  /// instructions to the model. You can provide various information in the
  /// system role including:
  ///
  /// - A brief description of the assistant
  /// - Personality traits of the assistant
  /// - Instructions or rules you would like the assistant to follow
  /// - Data or information needed for the model, such as relevant questions
  ///   from an FAQ
  system,

  /// The user role which depicts a message sent by the user interacting with
  /// the assistant
  user,

  /// The assistant role which depicts a message sent by the LLM as completion
  /// and in response to a user message
  assistant,
}

/// An extension of the LlmClientMessageRole
extension LlmClientMessageRoleX on LlmClientMessageRole {
  /// The string value of the Enum
  String get value => toString().split('.')[1];
}

/// A message to be included as part of a conversation with the LLM
class LlmClientMessage {
  /// Constructor
  ///
  /// Takes in a role and a content
  const LlmClientMessage({required this.role, required this.content});

  /// Constructor
  ///
  /// Build a message with User role
  const LlmClientMessage.fromUser({required this.content})
      : role = LlmClientMessageRole.user;

  /// Constructor
  ///
  /// Build a message with User role
  const LlmClientMessage.fromSystem({required this.content})
      : role = LlmClientMessageRole.system;

  /// Defines the role of the message, whether it was sent by a user,
  /// system message or the llm/assistant
  final LlmClientMessageRole role;

  /// The content of the message
  final String content;

  /// JSON representation of the Message
  Map<String, dynamic> toJson() => {
        'role': role.value,
        'content': content,
      };
}
