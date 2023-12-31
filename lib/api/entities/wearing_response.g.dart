// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wearing_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WearingResponse _$WearingResponseFromJson(Map<String, dynamic> json) =>
    WearingResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => WearingData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WearingResponseToJson(WearingResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

WearingData _$WearingDataFromJson(Map<String, dynamic> json) => WearingData(
      goodsNo: json['goodsNo'] as String,
      goodsNmFl: json['goodsNmFl'] as String,
      goodsNm: json['goodsNm'] as String,
      goodsNmMain: json['goodsNmMain'] as String,
      goodsNmList: json['goodsNmList'] as String,
      goodsNmDetail: json['goodsNmDetail'] as String,
      goodsNmPartner: json['goodsNmPartner'] as String,
      goodsDisplayFl: json['goodsDisplayFl'] as String,
      goodsDisplayMobileFl: json['goodsDisplayMobileFl'] as String,
      goodsSellFl: json['goodsSellFl'] as String,
      goodsSellMobileFl: json['goodsSellMobileFl'] as String,
      scmNo: json['scmNo'] as String,
      purchaseNo: json['purchaseNo'] as String?,
      purchaseGoodsNm: json['purchaseGoodsNm'] as String,
      applyFl: json['applyFl'] as String,
      applyType: json['applyType'] as String,
      applyMsg: json['applyMsg'] as String?,
      applyDt: json['applyDt'] as String?,
      commission: json['commission'] as String,
      goodsCd: json['goodsCd'] as String,
      cateCd: json['cateCd'] as String,
      goodsSearchWord: json['goodsSearchWord'] as String,
      goodsOpenDt: json['goodsOpenDt'] as String,
      goodsState: json['goodsState'] as String,
      goodsColor: json['goodsColor'] as String,
      imageStorage: json['imageStorage'] as String,
      imagePath: json['imagePath'] as String,
      brandCd: json['brandCd'] as String,
      makerNm: json['makerNm'] as String,
      originNm: json['originNm'] as String,
      hscode: json['hscode'] as String,
      goodsModelNo: json['goodsModelNo'] as String,
      makeYmd: json['makeYmd'] as String,
      launchYmd: json['launchYmd'] as String,
      effectiveStartYmd: json['effectiveStartYmd'] as String,
      effectiveEndYmd: json['effectiveEndYmd'] as String,
      qrCodeFl: json['qrCodeFl'] as String,
      goodsPermission: json['goodsPermission'] as String,
      goodsPermissionGroup: json['goodsPermissionGroup'] as String,
      goodsPermissionPriceStringFl:
          json['goodsPermissionPriceStringFl'] as String,
      goodsPermissionPriceString: json['goodsPermissionPriceString'] as String,
      onlyAdultFl: json['onlyAdultFl'] as String,
      onlyAdultDisplayFl: json['onlyAdultDisplayFl'] as String,
      onlyAdultImageFl: json['onlyAdultImageFl'] as String,
      goodsAccess: json['goodsAccess'] as String,
      goodsAccessGroup: json['goodsAccessGroup'] as String,
      goodsAccessDisplayFl: json['goodsAccessDisplayFl'] as String,
      goodsMustInfo: json['goodsMustInfo'] as String,
      kcmarkInfo: json['kcmarkInfo'] as String,
      taxFreeFl: json['taxFreeFl'] as String,
      taxPercent: json['taxPercent'] as String,
      cultureBenefitFl: json['cultureBenefitFl'] as String,
      goodsWeight: json['goodsWeight'] as String,
      totalStock: json['totalStock'] as String,
      stockFl: json['stockFl'] as String,
      soldOutFl: json['soldOutFl'] as String,
      fixedSales: json['fixedSales'] as String,
      fixedOrderCnt: json['fixedOrderCnt'] as String,
      salesUnit: json['salesUnit'] as String,
      minOrderCnt: json['minOrderCnt'] as String,
      maxOrderCnt: json['maxOrderCnt'] as String,
      salesStartYmd: json['salesStartYmd'] as String,
      salesEndYmd: json['salesEndYmd'] as String,
      restockFl: json['restockFl'] as String,
      mileageFl: json['mileageFl'] as String,
      mileageGroup: json['mileageGroup'] as String,
      mileageGoods: json['mileageGoods'] as String,
      mileageGoodsUnit: json['mileageGoodsUnit'] as String,
      mileageGroupInfo: json['mileageGroupInfo'] as String,
      mileageGroupMemberInfo: json['mileageGroupMemberInfo'] as String,
      goodsBenefitSetFl: json['goodsBenefitSetFl'] as String,
      benefitUseType: json['benefitUseType'] as String,
      newGoodsRegFl: json['newGoodsRegFl'] as String,
      newGoodsDate: json['newGoodsDate'] as String,
      newGoodsDateFl: json['newGoodsDateFl'] as String,
      periodDiscountStart: json['periodDiscountStart'] as String,
      periodDiscountEnd: json['periodDiscountEnd'] as String,
      goodsDiscountFl: json['goodsDiscountFl'] as String,
      goodsDiscount: json['goodsDiscount'] as String,
      goodsDiscountUnit: json['goodsDiscountUnit'] as String,
      fixedGoodsDiscount: json['fixedGoodsDiscount'] as String,
      goodsDiscountGroup: json['goodsDiscountGroup'] as String,
      goodsDiscountGroupMemberInfo:
          json['goodsDiscountGroupMemberInfo'] as String,
      exceptBenefit: json['exceptBenefit'] as String,
      exceptBenefitGroup: json['exceptBenefitGroup'] as String,
      exceptBenefitGroupInfo: json['exceptBenefitGroupInfo'] as String,
      payLimitFl: json['payLimitFl'] as String,
      payLimit: json['payLimit'] as String,
      goodsPriceString: json['goodsPriceString'] as String,
      goodsPrice: json['goodsPrice'] as String,
      fixedPrice: json['fixedPrice'] as String,
      costPrice: json['costPrice'] as String,
      optionFl: json['optionFl'] as String,
      optionDisplayFl: json['optionDisplayFl'] as String,
      optionName: json['optionName'] as String,
      optionTextFl: json['optionTextFl'] as String,
      optionImagePreviewFl: json['optionImagePreviewFl'] as String,
      optionImageDisplayFl: json['optionImageDisplayFl'] as String,
      addGoodsFl: json['addGoodsFl'] as String,
      addGoods: json['addGoods'] as String,
      shortDescription: json['shortDescription'] as String,
      eventDescription: json['eventDescription'] as String,
      goodsDescription: json['goodsDescription'] as String,
      goodsDescriptionMobile: json['goodsDescriptionMobile'] as String,
      goodsDescriptionSameFl: json['goodsDescriptionSameFl'] as String,
      deliverySno: json['deliverySno'] as String,
      relationFl: json['relationFl'] as String,
      relationSameFl: json['relationSameFl'] as String,
      relationCnt: json['relationCnt'] as String,
      relationGoodsNo: json['relationGoodsNo'] as String,
      relationGoodsDate: json['relationGoodsDate'] as String,
      relationGoodsEach: json['relationGoodsEach'] as String,
      goodsIconStartYmd: json['goodsIconStartYmd'] as String,
      goodsIconEndYmd: json['goodsIconEndYmd'] as String,
      goodsIconCdPeriod: json['goodsIconCdPeriod'] as String,
      goodsIconCd: json['goodsIconCd'] as String,
      imgDetailViewFl: json['imgDetailViewFl'] as String,
      externalVideoFl: json['externalVideoFl'] as String,
      externalVideoUrl: json['externalVideoUrl'] as String,
      externalVideoWidth: json['externalVideoWidth'] as String,
      externalVideoHeight: json['externalVideoHeight'] as String,
      detailInfoDeliveryFl: json['detailInfoDeliveryFl'] as String,
      detailInfoDelivery: json['detailInfoDelivery'] as String,
      detailInfoDeliveryDirectInput:
          json['detailInfoDeliveryDirectInput'] as String,
      detailInfoASFl: json['detailInfoASFl'] as String,
      detailInfoAS: json['detailInfoAS'] as String,
      detailInfoASDirectInput: json['detailInfoASDirectInput'] as String,
      detailInfoRefundFl: json['detailInfoRefundFl'] as String,
      detailInfoRefund: json['detailInfoRefund'] as String,
      detailInfoRefundDirectInput:
          json['detailInfoRefundDirectInput'] as String,
      detailInfoExchangeFl: json['detailInfoExchangeFl'] as String,
      detailInfoExchange: json['detailInfoExchange'] as String,
      detailInfoExchangeDirectInput:
          json['detailInfoExchangeDirectInput'] as String,
      seoTagFl: json['seoTagFl'] as String,
      seoTagSno: json['seoTagSno'] as String,
      naverFl: json['naverFl'] as String,
      daumFl: json['daumFl'] as String,
      paycoFl: json['paycoFl'] as String,
      naverImportFlag: json['naverImportFlag'] as String,
      naverProductFlag: json['naverProductFlag'] as String,
      naverAgeGroup: json['naverAgeGroup'] as String,
      naverGender: json['naverGender'] as String,
      naverTag: json['naverTag'] as String,
      naverAttribute: json['naverAttribute'] as String,
      naverCategory: json['naverCategory'] as String,
      naverProductId: json['naverProductId'] as String,
      memo: json['memo'] as String,
      orderCnt: json['orderCnt'] as String,
      orderGoodsCnt: json['orderGoodsCnt'] as String,
      hitCnt: json['hitCnt'] as String,
      cartCnt: json['cartCnt'] as String,
      wishCnt: json['wishCnt'] as String,
      reviewCnt: json['reviewCnt'] as String,
      plusReviewCnt: json['plusReviewCnt'] as String,
      excelFl: json['excelFl'] as String,
      delFl: json['delFl'] as String,
      regDt: json['regDt'] as String,
      modDt: json['modDt'] as String,
      delDt: json['delDt'] as String,
      goodsVolume: json['goodsVolume'] as String,
      cremaReviewCnt: json['cremaReviewCnt'] as String,
      naverReviewCnt: json['naverReviewCnt'] as String,
      naverNpayAble: json['naverNpayAble'] as String,
      naverNpayAcumAble: json['naverNpayAcumAble'] as String,
    );

Map<String, dynamic> _$WearingDataToJson(WearingData instance) =>
    <String, dynamic>{
      'goodsNo': instance.goodsNo,
      'goodsNmFl': instance.goodsNmFl,
      'goodsNm': instance.goodsNm,
      'goodsNmMain': instance.goodsNmMain,
      'goodsNmList': instance.goodsNmList,
      'goodsNmDetail': instance.goodsNmDetail,
      'goodsNmPartner': instance.goodsNmPartner,
      'goodsDisplayFl': instance.goodsDisplayFl,
      'goodsDisplayMobileFl': instance.goodsDisplayMobileFl,
      'goodsSellFl': instance.goodsSellFl,
      'goodsSellMobileFl': instance.goodsSellMobileFl,
      'scmNo': instance.scmNo,
      'purchaseNo': instance.purchaseNo,
      'purchaseGoodsNm': instance.purchaseGoodsNm,
      'applyFl': instance.applyFl,
      'applyType': instance.applyType,
      'applyMsg': instance.applyMsg,
      'applyDt': instance.applyDt,
      'commission': instance.commission,
      'goodsCd': instance.goodsCd,
      'cateCd': instance.cateCd,
      'goodsSearchWord': instance.goodsSearchWord,
      'goodsOpenDt': instance.goodsOpenDt,
      'goodsState': instance.goodsState,
      'goodsColor': instance.goodsColor,
      'imageStorage': instance.imageStorage,
      'imagePath': instance.imagePath,
      'brandCd': instance.brandCd,
      'makerNm': instance.makerNm,
      'originNm': instance.originNm,
      'hscode': instance.hscode,
      'goodsModelNo': instance.goodsModelNo,
      'makeYmd': instance.makeYmd,
      'launchYmd': instance.launchYmd,
      'effectiveStartYmd': instance.effectiveStartYmd,
      'effectiveEndYmd': instance.effectiveEndYmd,
      'qrCodeFl': instance.qrCodeFl,
      'goodsPermission': instance.goodsPermission,
      'goodsPermissionGroup': instance.goodsPermissionGroup,
      'goodsPermissionPriceStringFl': instance.goodsPermissionPriceStringFl,
      'goodsPermissionPriceString': instance.goodsPermissionPriceString,
      'onlyAdultFl': instance.onlyAdultFl,
      'onlyAdultDisplayFl': instance.onlyAdultDisplayFl,
      'onlyAdultImageFl': instance.onlyAdultImageFl,
      'goodsAccess': instance.goodsAccess,
      'goodsAccessGroup': instance.goodsAccessGroup,
      'goodsAccessDisplayFl': instance.goodsAccessDisplayFl,
      'goodsMustInfo': instance.goodsMustInfo,
      'kcmarkInfo': instance.kcmarkInfo,
      'taxFreeFl': instance.taxFreeFl,
      'taxPercent': instance.taxPercent,
      'cultureBenefitFl': instance.cultureBenefitFl,
      'goodsWeight': instance.goodsWeight,
      'totalStock': instance.totalStock,
      'stockFl': instance.stockFl,
      'soldOutFl': instance.soldOutFl,
      'fixedSales': instance.fixedSales,
      'fixedOrderCnt': instance.fixedOrderCnt,
      'salesUnit': instance.salesUnit,
      'minOrderCnt': instance.minOrderCnt,
      'maxOrderCnt': instance.maxOrderCnt,
      'salesStartYmd': instance.salesStartYmd,
      'salesEndYmd': instance.salesEndYmd,
      'restockFl': instance.restockFl,
      'mileageFl': instance.mileageFl,
      'mileageGroup': instance.mileageGroup,
      'mileageGoods': instance.mileageGoods,
      'mileageGoodsUnit': instance.mileageGoodsUnit,
      'mileageGroupInfo': instance.mileageGroupInfo,
      'mileageGroupMemberInfo': instance.mileageGroupMemberInfo,
      'goodsBenefitSetFl': instance.goodsBenefitSetFl,
      'benefitUseType': instance.benefitUseType,
      'newGoodsRegFl': instance.newGoodsRegFl,
      'newGoodsDate': instance.newGoodsDate,
      'newGoodsDateFl': instance.newGoodsDateFl,
      'periodDiscountStart': instance.periodDiscountStart,
      'periodDiscountEnd': instance.periodDiscountEnd,
      'goodsDiscountFl': instance.goodsDiscountFl,
      'goodsDiscount': instance.goodsDiscount,
      'goodsDiscountUnit': instance.goodsDiscountUnit,
      'fixedGoodsDiscount': instance.fixedGoodsDiscount,
      'goodsDiscountGroup': instance.goodsDiscountGroup,
      'goodsDiscountGroupMemberInfo': instance.goodsDiscountGroupMemberInfo,
      'exceptBenefit': instance.exceptBenefit,
      'exceptBenefitGroup': instance.exceptBenefitGroup,
      'exceptBenefitGroupInfo': instance.exceptBenefitGroupInfo,
      'payLimitFl': instance.payLimitFl,
      'payLimit': instance.payLimit,
      'goodsPriceString': instance.goodsPriceString,
      'goodsPrice': instance.goodsPrice,
      'fixedPrice': instance.fixedPrice,
      'costPrice': instance.costPrice,
      'optionFl': instance.optionFl,
      'optionDisplayFl': instance.optionDisplayFl,
      'optionName': instance.optionName,
      'optionTextFl': instance.optionTextFl,
      'optionImagePreviewFl': instance.optionImagePreviewFl,
      'optionImageDisplayFl': instance.optionImageDisplayFl,
      'addGoodsFl': instance.addGoodsFl,
      'addGoods': instance.addGoods,
      'shortDescription': instance.shortDescription,
      'eventDescription': instance.eventDescription,
      'goodsDescription': instance.goodsDescription,
      'goodsDescriptionMobile': instance.goodsDescriptionMobile,
      'goodsDescriptionSameFl': instance.goodsDescriptionSameFl,
      'deliverySno': instance.deliverySno,
      'relationFl': instance.relationFl,
      'relationSameFl': instance.relationSameFl,
      'relationCnt': instance.relationCnt,
      'relationGoodsNo': instance.relationGoodsNo,
      'relationGoodsDate': instance.relationGoodsDate,
      'relationGoodsEach': instance.relationGoodsEach,
      'goodsIconStartYmd': instance.goodsIconStartYmd,
      'goodsIconEndYmd': instance.goodsIconEndYmd,
      'goodsIconCdPeriod': instance.goodsIconCdPeriod,
      'goodsIconCd': instance.goodsIconCd,
      'imgDetailViewFl': instance.imgDetailViewFl,
      'externalVideoFl': instance.externalVideoFl,
      'externalVideoUrl': instance.externalVideoUrl,
      'externalVideoWidth': instance.externalVideoWidth,
      'externalVideoHeight': instance.externalVideoHeight,
      'detailInfoDeliveryFl': instance.detailInfoDeliveryFl,
      'detailInfoDelivery': instance.detailInfoDelivery,
      'detailInfoDeliveryDirectInput': instance.detailInfoDeliveryDirectInput,
      'detailInfoASFl': instance.detailInfoASFl,
      'detailInfoAS': instance.detailInfoAS,
      'detailInfoASDirectInput': instance.detailInfoASDirectInput,
      'detailInfoRefundFl': instance.detailInfoRefundFl,
      'detailInfoRefund': instance.detailInfoRefund,
      'detailInfoRefundDirectInput': instance.detailInfoRefundDirectInput,
      'detailInfoExchangeFl': instance.detailInfoExchangeFl,
      'detailInfoExchange': instance.detailInfoExchange,
      'detailInfoExchangeDirectInput': instance.detailInfoExchangeDirectInput,
      'seoTagFl': instance.seoTagFl,
      'seoTagSno': instance.seoTagSno,
      'naverFl': instance.naverFl,
      'daumFl': instance.daumFl,
      'paycoFl': instance.paycoFl,
      'naverImportFlag': instance.naverImportFlag,
      'naverProductFlag': instance.naverProductFlag,
      'naverAgeGroup': instance.naverAgeGroup,
      'naverGender': instance.naverGender,
      'naverTag': instance.naverTag,
      'naverAttribute': instance.naverAttribute,
      'naverCategory': instance.naverCategory,
      'naverProductId': instance.naverProductId,
      'memo': instance.memo,
      'orderCnt': instance.orderCnt,
      'orderGoodsCnt': instance.orderGoodsCnt,
      'hitCnt': instance.hitCnt,
      'cartCnt': instance.cartCnt,
      'wishCnt': instance.wishCnt,
      'reviewCnt': instance.reviewCnt,
      'plusReviewCnt': instance.plusReviewCnt,
      'excelFl': instance.excelFl,
      'delFl': instance.delFl,
      'regDt': instance.regDt,
      'modDt': instance.modDt,
      'delDt': instance.delDt,
      'goodsVolume': instance.goodsVolume,
      'cremaReviewCnt': instance.cremaReviewCnt,
      'naverReviewCnt': instance.naverReviewCnt,
      'naverNpayAble': instance.naverNpayAble,
      'naverNpayAcumAble': instance.naverNpayAcumAble,
    };
