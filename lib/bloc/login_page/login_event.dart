abstract class LoginEvent {}

class SendVerificationCodeEvent extends LoginEvent {
  final String? phoneNumber;
  SendVerificationCodeEvent(this.phoneNumber);
}

class LoginWithCodeEvent extends LoginEvent {
  final String? smsCode;
  LoginWithCodeEvent(this.smsCode);
}
