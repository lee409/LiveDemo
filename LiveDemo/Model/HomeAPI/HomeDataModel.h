//
//  HomeDataModel.h
//  HaiTao
//
//  Created by lxm on 15/12/17.
//  Copyright © 2015年 HaiShang. All rights reserved.
//

#import "JSONModel.h"


@protocol HomeSpecial_DataModel
@end
@protocol HomeBanner_infoModel
@end
@protocol HomeGroupbuy_infoModel
@end
@protocol HomeSpecial_infoModel
@end
@protocol HomeTuan_infoModel
@end
@protocol HomeBlock_goodsModel
@end
@protocol HomeBlock_infoModel
@end
@protocol HomeRecommend_DataModel
@end

/*banner*/
@interface HomeBanner_infoModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *img_url;/*banner图片*/
@property (nonatomic, strong) NSString<Optional> *ref_url;/*banner详情url*/
@property (nonatomic, assign) int adv_type;/*广告链接类型(0是url; 1是goods;2是分类)*/
@property (nonatomic, strong) NSString<Optional> *map_name;/*title*/
@end

@interface HomeGroupbuy_infoModel : JSONModel
@property (nonatomic, assign) int goods_id;/*商品id*/
@property (nonatomic, assign) int groupbuy_id;/*闪购id*/
@property (nonatomic, strong) NSString<Optional> *groupbuy_image;/*图片*/
@property (nonatomic, strong) NSString<Optional> *groupbuy_name;/*商品名称*/
@property (nonatomic, strong) NSString<Optional> *groupbuy_price;/*活动价格*/
@property (nonatomic, assign) int groupbuy_type;/*类型0闪购1秒少*/
@property (nonatomic, assign) int status;/*1开抢2抢光3预告*/
@property (nonatomic, strong) NSString<Optional> *timestamp;/*时间*/
@property (nonatomic, assign) int virtual_quantity;/*库存数*/
@end

@interface HomeBlock_infoModel : JSONModel
@property (nonatomic, strong) NSArray<HomeBlock_goodsModel,Optional> *goods_list;/*国旗*/
@property (nonatomic, assign) int show_type;
@property (nonatomic, assign) int tid;
@property (nonatomic, strong) NSString<Optional> *tweet_image;
@property (nonatomic, strong) NSString<Optional> *tweet_title;
@property (nonatomic, strong) NSString<Optional> *href_url;
@end

@interface HomeBlock_goodsModel : JSONModel
@property (nonatomic, assign) int goods_id;/*商品id*/
@property (nonatomic, strong) NSString<Optional> *goods_image;/*图片*/
@property (nonatomic, strong) NSString<Optional> *goods_name;/*商品名称*/
@property (nonatomic, strong) NSString<Optional> *goods_price;/*商品名称*/
@property (nonatomic, assign) int goods_storage;/*是否为售罄*/
@end

@interface HomeRecommend_DataModel : JSONModel
@property (nonatomic, assign) int goods_id;/*商品id*/
@property (nonatomic, strong) NSString<Optional> *goods_image;/*图片*/
@property (nonatomic, strong) NSString<Optional> *goods_name;/*商品名称*/
@property (nonatomic, strong) NSString<Optional> *goods_price;/*商品名称*/
@property (nonatomic, assign) int goods_storage;/*是否为售罄*/
@property (nonatomic, strong) NSString<Optional> *nickname;/*是否为售罄*/
@property (nonatomic, strong) NSString<Optional> *geval_content;/*评论内容*/
@end

/*猜你喜欢*/
@interface HomeRecommend_infoModel : JSONModel
@property (nonatomic, strong) NSArray<HomeRecommend_DataModel,Optional> *data_list;/*国旗*/
@property (nonatomic, assign) int max_count;/*最大数*/
@end

/*专场商品模块*/
@interface HomeSpecial_DataModel : JSONModel
@property (nonatomic, assign) int goods_id;/*商品id*/
@property (nonatomic, strong) NSString<Optional> *goods_image;/*图片*/
@property (nonatomic, strong) NSString<Optional> *goods_name;/*商品名称*/
@property (nonatomic, strong) NSString<Optional> *goods_price;/*商品名称*/
@property (nonatomic, assign) int goods_storage;/*是否为售罄*/
@end

/*专场模块*/
@interface HomeSpecial_infoModel : JSONModel
@property (nonatomic, strong) NSArray<HomeSpecial_DataModel,Optional> *goods_list;/*国旗*/
@property (nonatomic, strong) NSString<Optional> *pic_img;/*图片链接*/
@property (nonatomic, strong) NSString<Optional> *pic_url;/*图片跳转*/
@end


@interface HomeTuan_infoModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *goods_image;/*团购的图片*/
@property (nonatomic, assign) int tuan_goods_id;/*团购的商品ID*/
@property (nonatomic, assign) int tuan_id;/*团购ID*/
@property (nonatomic, strong) NSString<Optional> *tuan_name;/*团购名称*/
@property (nonatomic, strong) NSString<Optional> *tuan_price;/*团购价格*/
@property (nonatomic, assign) int tuan_status;/*团购的状态(1进行中;3预告)*/
@property (nonatomic, assign) int tuan_sum;/*团购人数*/
@property (nonatomic, strong) NSString<Optional> *tuan_txt;/*文本信息*/
@end

@interface HomeSubDataModel : JSONModel
@property (nonatomic, strong) NSArray<HomeBanner_infoModel,Optional> *banner_info;/*banner*/
@property (nonatomic, strong) NSArray<HomeGroupbuy_infoModel,Optional> *groupbuy_info;/*闪购*/
@property (nonatomic, strong) NSArray<HomeBlock_infoModel,Optional> *block_info;/**/
@property (nonatomic, strong) HomeRecommend_infoModel<Optional> *recommend_info;/*猜你喜欢*/
@property (nonatomic, strong) NSArray<HomeSpecial_infoModel,Optional> *special_info;/*专场*/
@property (nonatomic, strong) NSArray<HomeTuan_infoModel,Optional> *tuan_info;/*团购*/
@property (nonatomic, strong) NSString<Optional> *tuan_href;
@end

@interface HomeDataModel : JSONModel
@property (nonatomic, assign) int code;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) HomeSubDataModel<Optional> *data;
@end
