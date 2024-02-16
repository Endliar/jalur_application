abstract class LoginEvent {}

class SendVerificationCodeEvent extends LoginEvent {
  final String? phoneNumber;
  SendVerificationCodeEvent(this.phoneNumber);
}

class LoginWithCodeEvent extends LoginEvent {
  final String? phoneNumber;
  final String? smsCode;
  LoginWithCodeEvent(this.phoneNumber, this.smsCode);
}
