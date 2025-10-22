class Status {
  String? msg;
  String? desc;

  Status({this.msg, this.desc});

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        msg: json['msg'] as String?,
        desc: json['desc'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'msg': msg,
        'desc': desc,
      };
}
