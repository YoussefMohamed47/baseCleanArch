
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
  Location
}
class FormItemTypeEnum {
  static Map<FormItemType, int> toInt = {
  FormItemType.LongText: 1,
    FormItemType.ShortText: 2,
    FormItemType.SingleChoice: 3,
    FormItemType.MultiChoice: 4,
    FormItemType.Number: 5,
    FormItemType.Float: 6,
    FormItemType.Date: 7,
    FormItemType.Time: 8,
    FormItemType.Attachment: 9,
    FormItemType.Location: 10,
  };

  static Map<int, FormItemType> toEnum = {
    1: FormItemType.LongText,
    2: FormItemType.ShortText,
    3: FormItemType.SingleChoice,
    4: FormItemType.MultiChoice,
    5: FormItemType.Number,
    6: FormItemType.Float,
    7: FormItemType.Date,
    8: FormItemType.Time,
    9: FormItemType.Attachment,
    10: FormItemType.Location,
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