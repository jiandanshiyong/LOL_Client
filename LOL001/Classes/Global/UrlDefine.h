//
//  UrlDefine.h
//  LOLInfomation
//
//  Created by RichyLeo on 15/9/15.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#ifndef _______DEFINE_h
#define _______DEFINE_h

/**
 *  资料模块
 */
// 朋友圈（Cell自适应高度，XML解析）
#define kFriendCircleUrlString  @"http://www.oschina.net/action/api/tweet_list?uid=0&pageIndex=%ld&pageSize=30"


/**
 *  1.新闻模块
    包含新闻列表，新闻详情URL；
 */

//最新
#define kLatestNewsUrlString @"http://lol.data.shiwan.com/getArticleListImprove/?cid_rel=207&page=%ld"
//活动
#define kS4UrlString @"http://lol.data.shiwan.com/getArticleListImprove/?cid_rel=215&page=%ld"
//赛事
#define kMatchUrlStirng @"http://lol.data.shiwan.com/getArticleListImprove/?cid_rel=216&page=%ld"
//视频
#define kGreatUrlString @"http://lol.data.shiwan.com/getArticleListImprove/?cid_rel=212&page=%ld"
//娱乐
#define kLolPictureUrlString @"http://lol.data.shiwan.com/getArticleListImprove/?cid_rel=213&page=%ld"
//官方
#define kOfficialUrlString @"http://lol.data.shiwan.com/getArticleListImprove/?cid_rel=211&page=%ld"
//美女
#define kBeautifulGirlUrlString @"http://lol.data.shiwan.com/getArticleListImprove/?cid_rel=210&page=%ld"
//攻略
#define kStrategyUrlString @"http://lol.data.shiwan.com/getArticleListImprove/?cid_rel=214&page=%ld"
//新闻详细
#define kNewsDetailUrlString @"http://lol.data.shiwan.com/getArticleInfo/loldata?article_id=%@"


/**
 *  2.账号登录注册功能
    接口api可参见，[Others] - 文件“AccountApi”
 */


//装备物品
#define kEquipmentUrlString @"http://lol.data.shiwan.com/lolItemFilter/lolvideo?index=99"

//召唤师技能
#define kSkillUrlString @"http://lol.data.shiwan.com/lolSpell"
//召唤师详情  web   server  player
#define kPlayerUrlString @"http://lolbox.duowan.com/phone/playerDetail.php?sn=%@&target=%@&from=search&sk=398723%254019T"
//json 召唤师详情  player  server
#define kJasonPlayerUrlString @"http://115.29.206.154:8080/LOL_Query/service/ZDLQuery?playerName=%@&serverName=%@"


/**
 *  3.英雄模块
 *  包含全部英雄和限免英雄URL；
 */

//全部英雄
#define kAllHeroUrlString @"http://lol.data.shiwan.com/lolHeros/?filter=&type=all"
//本周免费英雄
#define kFreeHeroUrlString @"http://lol.data.shiwan.com/lolHeros/?filter=&type=free"
#define kHeroDetailInfoUrlString @"http://lol.data.shiwan.com/lolHeroInfo/?id=%@"
//英雄出装
#define kHeroEquipmentUrlString @"http://db.duowan.com/lolcz/img/ku11/api/lolcz.php?championName=%@&limit=7"
//装备图片
#define kEquipmentImageUrlString @"http://img.lolbox.duowan.com/zb/%@_64x64.png"
//英雄技能
#define kSkillImageUrlString @"http://img.lolbox.duowan.com/abilities/%@_%@_64x64.png"



// 获取全局并发队列
#define HMGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
// 获取主线程队列
#define HMMainQueue dispatch_get_main_queue()

#endif

