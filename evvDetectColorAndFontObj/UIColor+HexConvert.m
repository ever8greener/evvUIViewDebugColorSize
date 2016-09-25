//
//  UIColor+HexConvert.m
//  evvDetectColorAndFontObj
//
//  Created by artist on 9/25/16.
//  Copyright © 2016 EddieKwon. All rights reserved.
//

#import "UIColor+HexConvert.h"

@implementation UIColor (HexConvert)

//http://padgom.tistory.com/entry/iOS-RGB-코드를-UIColor로-변환하기
+ (UIColor *)colorWithRGBHex:(NSUInteger)RGBHex
{
    CGFloat red = ((CGFloat)((RGBHex & 0xFF0000) >> 16)) / 255.0f;
    CGFloat green = ((CGFloat)((RGBHex & 0xFF00) >> 8)) / 255.0f;
    CGFloat blue = ((CGFloat)((RGBHex & 0xFF))) / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)colorWithRGBHex:(NSUInteger)RGBHex alpha:(CGFloat)alpha
{
    CGFloat red = ((CGFloat)((RGBHex & 0xFF0000) >> 16)) / 255.0f;
    CGFloat green = ((CGFloat)((RGBHex & 0xFF00) >> 8)) / 255.0f;
    CGFloat blue = ((CGFloat)((RGBHex & 0xFF))) / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


//잘동작
+ (UIColor *) colorFromHexString : (NSString *) hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

// not tested. usage as below:

// NSString *hexStr1 = @"123ABC";
// NSString *hexStr2 = @"#123ABC";
// NSString *hexStr3 = @"0x123ABC";
// UIColor *color1 = [UIColor colorwithHexString:hexStr1 alpha:.9];
// NSLog(@"UIColor: %@", color1);

+ (UIColor *)colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha//http://j.mp/2d0PGV4
{
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

//뭔가이상.
+ (UIColor *) colorWithHex:(int) hex
{
    
    //    float red = (color & 0xff000000) >> 24;
    //    float green = (color & 0x00ff0000) >> 16;
    //    float blue = (color & 0x0000ff00) >> 8;
    //    float alpha = (color & 0x000000ff);
    //
    //    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
    
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

// http://j.mp/2dtpGUR
+ ( NSString* )hexStringFromColor:(UIColor *) color
{
    CGColorSpaceModel colorSpace = CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor));
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r, g, b, a;
    
    if (colorSpace == kCGColorSpaceModelMonochrome) {
        r = components[0];
        g = components[0];
        b = components[0];
        a = components[1];
    }
    else if (colorSpace == kCGColorSpaceModelRGB) {
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255),
            lroundf(a * 255)];
}



@end
