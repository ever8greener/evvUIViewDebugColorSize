//
//  UIColor+HexConvert.h
//  evvDetectColorAndFontObj
//
//  Created by artist on 9/25/16.
//  Copyright © 2016 EddieKwon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexConvert)

//not tested:
+ (UIColor *) colorWithRGBHex:(NSUInteger)RGBHex;
+ (UIColor *) colorWithRGBHex:(NSUInteger)RGBHex alpha:(CGFloat)alpha;

//잘동작
+ (UIColor *) colorFromHexString : (NSString *) hexString;

//not tested:
+ (UIColor *) colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha; //http://j.mp/2d0PGV4


//뭔가이상.
+(UIColor *) colorWithHex:(int) hex;


+( NSString* )hexStringFromColor:(UIColor *) color;

@end
