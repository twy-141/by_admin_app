// To parse this JSON data, do
//
//     final daRenInfoResult = daRenInfoResultFromJson(jsonString);

import 'dart:convert';

DaRenInfoResult daRenInfoResultFromJson(String str) => DaRenInfoResult.fromJson(json.decode(str));

String daRenInfoResultToJson(DaRenInfoResult data) => json.encode(data.toJson());

class DaRenInfoResult {
    String? addressInfo;
    num? carMoney;
    num? carServerPercent;
    num? couponId;
    num? couponMoney;
    String? createBy;
    String? createTime;
    String? faceAddress;
    String? faceDate;
    num? faceLatitude;
    num? faceLongitude;
    String? faceTime;
    String? forderId;
    num? forderStatus;
    num? growthNum;
    String? linkPhone;
    String? nickname;
    num? orderMoney;
    num? orderType;
    Params? params;
    String? payMethod;
    num? payMoney;
    List<PayOrderInfoList>? payOrderInfoList;
    String? payTime;
    num? platCarFree;
    num? platItemFree;
    String? platOrder;
    num? refundCarMoney;
    num? refundMoney;
    String? remark;
    String? searchValue;
    num? serverPercent;
    String? serverRemark;
    num? ulatitude;
    num? ulongitude;
    String? updateBy;
    String? updateTime;
    num? userId;
    String? userTag;
    String? vipName;

    DaRenInfoResult({
        this.addressInfo,
        this.carMoney,
        this.carServerPercent,
        this.couponId,
        this.couponMoney,
        this.createBy,
        this.createTime,
        this.faceAddress,
        this.faceDate,
        this.faceLatitude,
        this.faceLongitude,
        this.faceTime,
        this.forderId,
        this.forderStatus,
        this.growthNum,
        this.linkPhone,
        this.nickname,
        this.orderMoney,
        this.orderType,
        this.params,
        this.payMethod,
        this.payMoney,
        this.payOrderInfoList,
        this.payTime,
        this.platCarFree,
        this.platItemFree,
        this.platOrder,
        this.refundCarMoney,
        this.refundMoney,
        this.remark,
        this.searchValue,
        this.serverPercent,
        this.serverRemark,
        this.ulatitude,
        this.ulongitude,
        this.updateBy,
        this.updateTime,
        this.userId,
        this.userTag,
        this.vipName,
    });

    factory DaRenInfoResult.fromJson(Map<String, dynamic> json) => DaRenInfoResult(
        addressInfo: json["addressInfo"],
        carMoney: json["carMoney"],
        carServerPercent: json["carServerPercent"],
        couponId: json["couponId"],
        couponMoney: json["couponMoney"],
        createBy: json["createBy"],
        createTime: json["createTime"],
        faceAddress: json["faceAddress"],
        faceDate: json["faceDate"],
        faceLatitude: json["faceLatitude"],
        faceLongitude: json["faceLongitude"],
        faceTime: json["faceTime"],
        forderId: json["forderId"],
        forderStatus: json["forderStatus"],
        growthNum: json["growthNum"],
        linkPhone: json["linkPhone"],
        nickname: json["nickname"],
        orderMoney: json["orderMoney"],
        orderType: json["orderType"],
        params: json["params"] == null ? null : Params.fromJson(json["params"]),
        payMethod: json["payMethod"],
        payMoney: json["payMoney"],
        payOrderInfoList: json["payOrderInfoList"] == null ? [] : List<PayOrderInfoList>.from(json["payOrderInfoList"]!.map((x) => PayOrderInfoList.fromJson(x))),
        payTime: json["payTime"],
        platCarFree: json["platCarFree"],
        platItemFree: json["platItemFree"],
        platOrder: json["platOrder"],
        refundCarMoney: json["refundCarMoney"],
        refundMoney: json["refundMoney"],
        remark: json["remark"],
        searchValue: json["searchValue"],
        serverPercent: json["serverPercent"],
        serverRemark: json["serverRemark"],
        ulatitude: json["ulatitude"],
        ulongitude: json["ulongitude"],
        updateBy: json["updateBy"],
        updateTime: json["updateTime"],
        userId: json["userId"],
        userTag: json["userTag"],
        vipName: json["vipName"],
    );

    Map<String, dynamic> toJson() => {
        "addressInfo": addressInfo,
        "carMoney": carMoney,
        "carServerPercent": carServerPercent,
        "couponId": couponId,
        "couponMoney": couponMoney,
        "createBy": createBy,
        "createTime": createTime,
        "faceAddress": faceAddress,
        "faceDate": faceDate,
        "faceLatitude": faceLatitude,
        "faceLongitude": faceLongitude,
        "faceTime": faceTime,
        "forderId": forderId,
        "forderStatus": forderStatus,
        "growthNum": growthNum,
        "linkPhone": linkPhone,
        "nickname": nickname,
        "orderMoney": orderMoney,
        "orderType": orderType,
        "params": params?.toJson(),
        "payMethod": payMethod,
        "payMoney": payMoney,
        "payOrderInfoList": payOrderInfoList == null ? [] : List<dynamic>.from(payOrderInfoList!.map((x) => x.toJson())),
        "payTime": payTime,
        "platCarFree": platCarFree,
        "platItemFree": platItemFree,
        "platOrder": platOrder,
        "refundCarMoney": refundCarMoney,
        "refundMoney": refundMoney,
        "remark": remark,
        "searchValue": searchValue,
        "serverPercent": serverPercent,
        "serverRemark": serverRemark,
        "ulatitude": ulatitude,
        "ulongitude": ulongitude,
        "updateBy": updateBy,
        "updateTime": updateTime,
        "userId": userId,
        "userTag": userTag,
        "vipName": vipName,
    };
}

class Params {
    Params();

    factory Params.fromJson(Map<String, dynamic> json) => Params(
    );

    Map<String, dynamic> toJson() => {
    };
}

class PayOrderInfoList {
    num? age;
    String? arriveTime;
    String? avatar;
    num? carMoney;
    num? conFlag;
    String? createBy;
    String? createTime;
    String? daziAddress;
    num? daziId;
    String? daziKind;
    num? daziLatitude;
    num? daziLongitude;
    num? distance;
    String? finishTime;
    String? forderId;
    num? gender;
    num? itemPrice;
    String? leaveTime;
    String? nickname;
    num? onlineStatus;
    num? orderInfoId;
    num? orderMoney;
    Params? params;
    String? phone;
    String? photoBackground;
    String? recTime;
    String? remark;
    num? revenueCarMoney;
    num? revenueMoney;
    String? searchValue;
    String? serverEndTime;
    String? serverStartTime;
    num? serverStatus;
    num? serverTime;
    String? tagName;
    String? updateBy;
    String? updateTime;

    PayOrderInfoList({
        this.age,
        this.arriveTime,
        this.avatar,
        this.carMoney,
        this.conFlag,
        this.createBy,
        this.createTime,
        this.daziAddress,
        this.daziId,
        this.daziKind,
        this.daziLatitude,
        this.daziLongitude,
        this.distance,
        this.finishTime,
        this.forderId,
        this.gender,
        this.itemPrice,
        this.leaveTime,
        this.nickname,
        this.onlineStatus,
        this.orderInfoId,
        this.orderMoney,
        this.params,
        this.phone,
        this.photoBackground,
        this.recTime,
        this.remark,
        this.revenueCarMoney,
        this.revenueMoney,
        this.searchValue,
        this.serverEndTime,
        this.serverStartTime,
        this.serverStatus,
        this.serverTime,
        this.tagName,
        this.updateBy,
        this.updateTime,
    });

    factory PayOrderInfoList.fromJson(Map<String, dynamic> json) => PayOrderInfoList(
        age: json["age"],
        arriveTime: json["arriveTime"],
        avatar: json["avatar"],
        carMoney: json["carMoney"],
        conFlag: json["conFlag"],
        createBy: json["createBy"],
        createTime: json["createTime"],
        daziAddress: json["daziAddress"],
        daziId: json["daziId"],
        daziKind: json["daziKind"],
        daziLatitude: json["daziLatitude"],
        daziLongitude: json["daziLongitude"],
        distance: json["distance"],
        finishTime: json["finishTime"],
        forderId: json["forderId"],
        gender: json["gender"],
        itemPrice: json["itemPrice"],
        leaveTime: json["leaveTime"],
        nickname: json["nickname"],
        onlineStatus: json["onlineStatus"],
        orderInfoId: json["orderInfoId"],
        orderMoney: json["orderMoney"],
        params: json["params"] == null ? null : Params.fromJson(json["params"]),
        phone: json["phone"],
        photoBackground: json["photoBackground"],
        recTime: json["recTime"],
        remark: json["remark"],
        revenueCarMoney: json["revenueCarMoney"],
        revenueMoney: json["revenueMoney"],
        searchValue: json["searchValue"],
        serverEndTime: json["serverEndTime"],
        serverStartTime: json["serverStartTime"],
        serverStatus: json["serverStatus"],
        serverTime: json["serverTime"],
        tagName: json["tagName"],
        updateBy: json["updateBy"],
        updateTime: json["updateTime"],
    );

    Map<String, dynamic> toJson() => {
        "age": age,
        "arriveTime": arriveTime,
        "avatar": avatar,
        "carMoney": carMoney,
        "conFlag": conFlag,
        "createBy": createBy,
        "createTime": createTime,
        "daziAddress": daziAddress,
        "daziId": daziId,
        "daziKind": daziKind,
        "daziLatitude": daziLatitude,
        "daziLongitude": daziLongitude,
        "distance": distance,
        "finishTime": finishTime,
        "forderId": forderId,
        "gender": gender,
        "itemPrice": itemPrice,
        "leaveTime": leaveTime,
        "nickname": nickname,
        "onlineStatus": onlineStatus,
        "orderInfoId": orderInfoId,
        "orderMoney": orderMoney,
        "params": params?.toJson(),
        "phone": phone,
        "photoBackground": photoBackground,
        "recTime": recTime,
        "remark": remark,
        "revenueCarMoney": revenueCarMoney,
        "revenueMoney": revenueMoney,
        "searchValue": searchValue,
        "serverEndTime": serverEndTime,
        "serverStartTime": serverStartTime,
        "serverStatus": serverStatus,
        "serverTime": serverTime,
        "tagName": tagName,
        "updateBy": updateBy,
        "updateTime": updateTime,
    };
}
