
class Voucher {
  String voucherName;

  Voucher(this.voucherName);


  Voucher.fromJson(Map<String,dynamic> json) :
        voucherName = json['voucherName'];

  Map<String, dynamic> toJson() => {
    'voucherName' : voucherName
  };
}