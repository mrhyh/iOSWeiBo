//
//  Common.h
//  iOSCategoriesCollection
//
//  Created by ylgwhyh on 16/3/18.
//  Copyright © 2016年 com.ylgwhyh.iOSCategoriesCollection. All rights reserved.
//

#ifndef YLCommon_h
#define YLCommon_h


#endif /* Common_h */

// RGB颜色设定
#define RGB(r, g, b) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]

//颜色进制转换
#define ColorWithHexString(colorString) [UIColor colorWithHexString:(colorString)]
#define ColorAlphaWithHexString(colorString, a) [UIColor colorWithHexString:(colorString) alpha:a]

//常用颜色
//1.全局用色
#define AppMainStyleColor ColorWithHexString(@"#10aeff") //主色 系统主题色 蓝色
#define SubColor1 ColorWithHexString(@"#d9534f") //辅助色 暗红
#define SubColor2 ColorWithHexString(@"#ffbe00") //辅助色 橘黄

//屏膜宽高
#define IPHONE_WIDTH ([UIScreen mainScreen].applicationFrame.size.width)
#define IPHONE_HEIGHT ([UIScreen mainScreen].applicationFrame.size.height) //没状态栏高度

//config
#define APPWINDOWWIDTH               [UIScreen mainScreen].bounds.size.width
#define APPWINDOWHEIGHT              [UIScreen mainScreen].bounds.size.height
