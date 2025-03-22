
enum FormItemType
{
  LongText,
  ShortText,
  SingleChoice,
  MultiChoice,
  Number,
  Float,
  Date,
  Time,
  Attachment,
  Location,
  Client,
  ClientSignature
}
class FormItemTypeEnum {
  static Map<FormItemType, int> toInt = {
  FormItemType.LongText: 0,
    FormItemType.ShortText: 1,
    FormItemType.SingleChoice: 2,
    FormItemType.MultiChoice: 3,
    FormItemType.Number: 4,
    FormItemType.Float: 5,
    FormItemType.Date: 6,
    FormItemType.Time: 7,
    FormItemType.Attachment: 8,
    FormItemType.Location: 9,
    FormItemType.Client: 10,
    FormItemType.ClientSignature: 11,
  };

  static Map<int, FormItemType> toEnum = {
    0: FormItemType.LongText,
    1: FormItemType.ShortText,
    2: FormItemType.SingleChoice,
    3: FormItemType.MultiChoice,
    4: FormItemType.Number,
    5: FormItemType.Float,
    6: FormItemType.Date,
    7: FormItemType.Time,
    8: FormItemType.Attachment,
    9: FormItemType.Location,
    10: FormItemType.Client,
    11: FormItemType.ClientSignature,
  };
}

enum validatorType { Notempty, TextLength, PhoneNumber, Age, Email }


class AppEnums {
  // static const Map<String, int> SubscriptionStatus = const {
  //   'UnPaid': 29,
  //   'Paid': 30,
  //   'Active': 31,
  //   'Canceled': 32,
  // };


}