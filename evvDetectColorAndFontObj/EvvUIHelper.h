//
//  EvvUIHelper.h
//  evvDetectColorAndFontObj
//
//  Created by artist on 9/25/16.
//  Copyright © 2016 EddieKwon. All rights reserved.
//

//@import Foundation;
@import UIKit;

#import <Foundation/Foundation.h>
#import "UIView+PixelColor.h"


@interface EvvUIHelper : NSObject

@end

NSUInteger RandomInteger(NSUInteger max);// 0~ max-1 사이의 난수

//UIColor * colorFromHexString (NSString *hexString) ; // COLOR UTIL
//UIColor * colorWithHex(int color ) ;
//NSString* hexStringFromColor(UIColor *color);

void findViewRecursive(UIView* seedView, int atIndex);
void findLabelsRecursive(UIView* seedView, int atIndex);
void findOnlyViewsRecursive(UIView* seedView, int atIndex);
void findLabelsRecursiveAddingView(UIView* seedView, int atIndex);


NSArray*  collectAllViews(UIView* seedView );
//uicolor utils:
// http://uicolor.xyz/#/hex-to-ui

//picker download:
//https://bjango.com/mac/skalacolor/

