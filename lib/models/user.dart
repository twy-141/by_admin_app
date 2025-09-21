// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    final String? account;
    final int? age;
    final String? avatar;
    final String? city;
    final String? createBy;
    final String? createTime;
    final int? daRenPrice;
    final int? daziId;
    final String? daziKind;
    final String? educational;
    final int? gender;
    final int? height;
    final String? hobby;
    final int? intervalDistance;
    final String? inviteCode;
    final double? latitude;
    final double? longitude;
    final double? moneyBalance;
    final double? monthTotalMoney;
    final String? nickname;
    final int? onlineStatus;
    final String? openid;
    final List<OrderReply>? orderReplies;
    final Params? params;
    final String? password;
    final String? phone;
    final String? photoBackground;
    final String? profession;
    final String? province;
    final String? remark;
    final String? searchValue;
    final String? sosName;
    final String? sosPhone;
    final String? tagInfo;
    final String? tencentId;
    final String? token;
    final String? ucode;
    final String? updateBy;
    final String? updateTime;
    final String? userAudio;
    final int? userAudioLength;
    final String? userSign;
    final int? userStatus;
    final int? voteNum;
    final double? weight;

    User({
        this.account,
        this.age,
        this.avatar,
        this.city,
        this.createBy,
        this.createTime,
        this.daRenPrice,
        this.daziId,
        this.daziKind,
        this.educational,
        this.gender,
        this.height,
        this.hobby,
        this.intervalDistance,
        this.inviteCode,
        this.latitude,
        this.longitude,
        this.moneyBalance,
        this.monthTotalMoney,
        this.nickname,
        this.onlineStatus,
        this.openid,
        this.orderReplies,
        this.params,
        this.password,
        this.phone,
        this.photoBackground,
        this.profession,
        this.province,
        this.remark,
        this.searchValue,
        this.sosName,
        this.sosPhone,
        this.tagInfo,
        this.tencentId,
        this.token,
        this.ucode,
        this.updateBy,
        this.updateTime,
        this.userAudio,
        this.userAudioLength,
        this.userSign,
        this.userStatus,
        this.voteNum,
        this.weight,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        account: json["account"],
        age: json["age"],
        avatar: json["avatar"],
        city: json["city"],
        createBy: json["createBy"],
        createTime: json["createTime"],
        daRenPrice: json["daRenPrice"],
        daziId: json["daziId"],
        daziKind: json["daziKind"],
        educational: json["educational"],
        gender: json["gender"],
        height: json["height"],
        hobby: json["hobby"],
        intervalDistance: json["intervalDistance"],
        inviteCode: json["inviteCode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        moneyBalance: json["moneyBalance"],
        monthTotalMoney: json["monthTotalMoney"],
        nickname: json["nickname"],
        onlineStatus: json["onlineStatus"],
        openid: json["openid"],
        orderReplies: json["orderReplies"] == null ? [] : List<OrderReply>.from(json["orderReplies"]!.map((x) => OrderReply.fromJson(x))),
        params: json["params"] == null ? null : Params.fromJson(json["params"]),
        password: json["password"],
        phone: json["phone"],
        photoBackground: json["photoBackground"],
        profession: json["profession"],
        province: json["province"],
        remark: json["remark"],
        searchValue: json["searchValue"],
        sosName: json["sosName"],
        sosPhone: json["sosPhone"],
        tagInfo: json["tagInfo"],
        tencentId: json["tencentId"],
        token: json["token"],
        ucode: json["ucode"],
        updateBy: json["updateBy"],
        updateTime: json["updateTime"],
        userAudio: json["userAudio"],
        userAudioLength: json["userAudioLength"],
        userSign: json["userSign"],
        userStatus: json["userStatus"],
        voteNum: json["voteNum"],
        weight: json["weight"],
    );

    Map<String, dynamic> toJson() => {
        "account": account,
        "age": age,
        "avatar": avatar,
        "city": city,
        "createBy": createBy,
        "createTime": createTime,
        "daRenPrice": daRenPrice,
        "daziId": daziId,
        "daziKind": daziKind,
        "educational": educational,
        "gender": gender,
        "height": height,
        "hobby": hobby,
        "intervalDistance": intervalDistance,
        "inviteCode": inviteCode,
        "latitude": latitude,
        "longitude": longitude,
        "moneyBalance": moneyBalance,
        "monthTotalMoney": monthTotalMoney,
        "nickname": nickname,
        "onlineStatus": onlineStatus,
        "openid": openid,
        "orderReplies": orderReplies == null ? [] : List<dynamic>.from(orderReplies!.map((x) => x.toJson())),
        "params": params?.toJson(),
        "password": password,
        "phone": phone,
        "photoBackground": photoBackground,
        "profession": profession,
        "province": province,
        "remark": remark,
        "searchValue": searchValue,
        "sosName": sosName,
        "sosPhone": sosPhone,
        "tagInfo": tagInfo,
        "tencentId": tencentId,
        "token": token,
        "ucode": ucode,
        "updateBy": updateBy,
        "updateTime": updateTime,
        "userAudio": userAudio,
        "userAudioLength": userAudioLength,
        "userSign": userSign,
        "userStatus": userStatus,
        "voteNum": voteNum,
        "weight": weight,
    };
}

class OrderReply {
    final String? comment;
    final int? commentId;
    final String? createBy;
    final String? createTime;
    final int? daziId;
    final String? isDel;
    final int? isNi;
    final int? isReply;
    final String? merchantReplyContent;
    final String? merchantReplyTime;
    final int? orderInfoId;
    final Params? params;
    final String? pics;
    final String? remark;
    final String? searchValue;
    final int? serviceScore;
    final String? uavatar;
    final int? uid;
    final String? unickname;
    final String? updateBy;
    final String? updateTime;

    OrderReply({
        this.comment,
        this.commentId,
        this.createBy,
        this.createTime,
        this.daziId,
        this.isDel,
        this.isNi,
        this.isReply,
        this.merchantReplyContent,
        this.merchantReplyTime,
        this.orderInfoId,
        this.params,
        this.pics,
        this.remark,
        this.searchValue,
        this.serviceScore,
        this.uavatar,
        this.uid,
        this.unickname,
        this.updateBy,
        this.updateTime,
    });

    factory OrderReply.fromJson(Map<String, dynamic> json) => OrderReply(
        comment: json["comment"],
        commentId: json["commentId"],
        createBy: json["createBy"],
        createTime: json["createTime"],
        daziId: json["daziId"],
        isDel: json["isDel"],
        isNi: json["isNi"],
        isReply: json["isReply"],
        merchantReplyContent: json["merchantReplyContent"],
        merchantReplyTime: json["merchantReplyTime"],
        orderInfoId: json["orderInfoId"],
        params: json["params"] == null ? null : Params.fromJson(json["params"]),
        pics: json["pics"],
        remark: json["remark"],
        searchValue: json["searchValue"],
        serviceScore: json["serviceScore"],
        uavatar: json["uavatar"],
        uid: json["uid"],
        unickname: json["unickname"],
        updateBy: json["updateBy"],
        updateTime: json["updateTime"],
    );

    Map<String, dynamic> toJson() => {
        "comment": comment,
        "commentId": commentId,
        "createBy": createBy,
        "createTime": createTime,
        "daziId": daziId,
        "isDel": isDel,
        "isNi": isNi,
        "isReply": isReply,
        "merchantReplyContent": merchantReplyContent,
        "merchantReplyTime": merchantReplyTime,
        "orderInfoId": orderInfoId,
        "params": params?.toJson(),
        "pics": pics,
        "remark": remark,
        "searchValue": searchValue,
        "serviceScore": serviceScore,
        "uavatar": uavatar,
        "uid": uid,
        "unickname": unickname,
        "updateBy": updateBy,
        "updateTime": updateTime,
    };
}

class Params {
    Params();

    factory Params.fromJson(Map<String, dynamic> json) => Params(
    );

    Map<String, dynamic> toJson() => {
    };
}
