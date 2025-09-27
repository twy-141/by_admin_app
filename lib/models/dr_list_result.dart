// To parse this JSON data, do
//
//     final drListResult = drListResultFromJson(jsonString);

import 'dart:convert';

DrListResult drListResultFromJson(String str) => DrListResult.fromJson(json.decode(str));

String drListResultToJson(DrListResult data) => json.encode(data.toJson());

class DrListResult {
    int? endRow;
    bool? hasNextPage;
    bool? hasPreviousPage;
    bool? isFirstPage;
    bool? isLastPage;
    List<ListElement>? list;
    int? navigateFirstPage;
    int? navigateLastPage;
    int? navigatePages;
    List<dynamic>? navigatepageNums;
    int? nextPage;
    int? pageNum;
    int? pageSize;
    int? pages;
    int? prePage;
    int? size;
    int? startRow;
    int? total;

    DrListResult({
        this.endRow,
        this.hasNextPage,
        this.hasPreviousPage,
        this.isFirstPage,
        this.isLastPage,
        this.list,
        this.navigateFirstPage,
        this.navigateLastPage,
        this.navigatePages,
        this.navigatepageNums,
        this.nextPage,
        this.pageNum,
        this.pageSize,
        this.pages,
        this.prePage,
        this.size,
        this.startRow,
        this.total,
    });

    factory DrListResult.fromJson(Map<String, dynamic> json) => DrListResult(
        endRow: json["endRow"],
        hasNextPage: json["hasNextPage"],
        hasPreviousPage: json["hasPreviousPage"],
        isFirstPage: json["isFirstPage"],
        isLastPage: json["isLastPage"],
        list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
        navigateFirstPage: json["navigateFirstPage"],
        navigateLastPage: json["navigateLastPage"],
        navigatePages: json["navigatePages"],
        navigatepageNums: json["navigatepageNums"] == null ? [] : List<dynamic>.from(json["navigatepageNums"]!.map((x) => x)),
        nextPage: json["nextPage"],
        pageNum: json["pageNum"],
        pageSize: json["pageSize"],
        pages: json["pages"],
        prePage: json["prePage"],
        size: json["size"],
        startRow: json["startRow"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "endRow": endRow,
        "hasNextPage": hasNextPage,
        "hasPreviousPage": hasPreviousPage,
        "isFirstPage": isFirstPage,
        "isLastPage": isLastPage,
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
        "navigateFirstPage": navigateFirstPage,
        "navigateLastPage": navigateLastPage,
        "navigatePages": navigatePages,
        "navigatepageNums": navigatepageNums == null ? [] : List<dynamic>.from(navigatepageNums!.map((x) => x)),
        "nextPage": nextPage,
        "pageNum": pageNum,
        "pageSize": pageSize,
        "pages": pages,
        "prePage": prePage,
        "size": size,
        "startRow": startRow,
        "total": total,
    };
}

class ListElement {
    String? addressInfo;
    double? carMoney;
    double? carServerPercent;
    int? couponId;
    double? couponMoney;
    String? createBy;
    String? createTime;
    String? faceAddress;
    String? faceDate;
    double? faceLatitude;
    double? faceLongitude;
    String? faceTime;
    String? forderId;
    int? forderStatus;
    double? growthNum;
    String? linkPhone;
    String? nickname;
    double? orderMoney;
    int? orderType;
    Params? params;
    String? payMethod;
    double? payMoney;
    List<PayOrderInfoList>? payOrderInfoList;
    String? payTime;
    double? platCarFree;
    double? platItemFree;
    String? platOrder;
    double? refundCarMoney;
    double? refundMoney;
    String? remark;
    String? searchValue;
    double? serverPercent;
    String? serverRemark;
    int? ulatitude;
    int? ulongitude;
    String? updateBy;
    String? updateTime;
    int? userId;
    String? userTag;
    String? vipName;

    ListElement({
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

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
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
    int? age;
    String? arriveTime;
    String? avatar;
    double? carMoney;
    int? conFlag;
    String? createBy;
    String? createTime;
    String? daziAddress;
    int? daziId;
    String? daziKind;
    double? daziLatitude;
    double? daziLongitude;
    int? distance;
    String? finishTime;
    String? forderId;
    int? gender;
    double? itemPrice;
    String? leaveTime;
    String? nickname;
    int? onlineStatus;
    int? orderInfoId;
    double? orderMoney;
    Params? params;
    String? photoBackground;
    String? recTime;
    String? remark;
    double? revenueCarMoney;
    double? revenueMoney;
    String? searchValue;
    String? serverEndTime;
    String? serverStartTime;
    int? serverStatus;
    int? serverTime;
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
