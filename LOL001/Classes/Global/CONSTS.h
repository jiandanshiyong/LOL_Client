//
//  CONSTS.h
//  HW1_RandomStudent
//
//  Created by 张凯 on 16/6/15.
//  Copyright © 2014年 zk. All rights reserved.
//

#ifndef CONSTS_h
#define CONSTS_h

/**
 * 获取屏幕的宽和高
 */
#define SWIDTH [UIScreen mainScreen].bounds.size.width
#define SHEIGHT [UIScreen mainScreen].bounds.size.height

// RGB色值
#define UICOLOR_RGB(r, g, b, al) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:al]

//预加载图片
#define Default_Image  [UIImage imageNamed:@"Icon.png"]



#endif /* CONSTS_h */
