enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
    this.text = '',
     this.messageType,
     this.messageStatus,
     this.isSender
  });
}

List demoChatMessages = [
  ChatMessage(
    text: "Xin chào Thắng,",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    text: "Có phải bạn muốn mua Tay Cầm PS4?",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  // ChatMessage(
  //   text: "Đúng rồi",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: true,
  // ),
  // ChatMessage(
  //   text: "Giá món đồ bạn muốn mua là 64.99\$.\nBạn muốn thanh toán ngay bây giờ? ",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: false,
  // ),
  // ChatMessage(
  //   text: "Đúng vậy",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: true,
  // ),
  // ChatMessage(
  //   text: "Đọc câu sau để xác thực thanh \ntoán: \"Mã xác nhận của tôi là 2368\"",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: false,
  // ),
  // ChatMessage(
  //   text: "Mã xác nhận của tôi là 2368",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: true,
  // ),
  // ChatMessage(
  //   text: "Mã xác nhận và nhận dạng giọng \nchính xác với độ khớp giọng 99%.",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: false,
  // ),
  // ChatMessage(
  //   text: "Thanh toán thành công",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: false,
  // ),
  // ChatMessage(
  //   text: "Cảm ơn đã sử dụng dịch vụ VoicePay",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.not_view,
  //   isSender: false,
  // ),
];
