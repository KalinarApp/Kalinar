enum MessageType {
  welcome,
}

extension MessageTypeExtension on MessageType {
  MessageType isMessageType(String type) {
    return MessageType.values.byName(type);
  }
}
