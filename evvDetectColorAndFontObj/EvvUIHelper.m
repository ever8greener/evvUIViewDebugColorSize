//
//  EvvUIHelper.m
//  evvDetectColorAndFontObj
//
//  Created by artist on 9/25/16.
//  Copyright © 2016 EddieKwon. All rights reserved.
//

#import "EvvUIHelper.h"

@import ObjectiveC;


#if TARGET_OS_IPHONE
#define View UIView
#define Color UIColor
#define Image UIImage
#define Font UIFont

#elif TARGET_OS_MAC
#define View NSView
#define Color NSColor
#define Image NSImage
#define Font NSFont
#endif

@implementation EvvUIHelper

@end

#pragma mark - Random

NSUInteger RandomInteger(NSUInteger max)// 0~ max-1 사이의 난수
{
    return arc4random_uniform((unsigned int) max);
}

CGFloat Random01() //0~1 사이 부동소수점
{
    return ((CGFloat) arc4random() / (CGFloat) UINT_MAX);
}

BOOL RandomBool() // 동전을 던질때 임의의 참(?) 값을 반환.
{
    return (BOOL)arc4random_uniform(2);
}

CGPoint RandomPointInRect(CGRect rect) // 사각영역내 임의 지점
{
    CGFloat x = rect.origin.x + Random01() * rect.size.width;
    CGFloat y = rect.origin.y + Random01() * rect.size.height;
    return CGPointMake(x, y);
}

id RandomItemInArray(NSArray *array) // 배열내 임의 아이템
{
    NSUInteger index = RandomInteger(array.count);
    return array[index];
}

#pragma mark - Color

#if TARGET_OS_IPHONE
#define COLOR_PREFIX colorWithRed
#elif TARGET_OS_MAC
#define COLOR_PREFIX colorWithDeviceRed
#endif

// Underscore prevents issues when combined with color pack
Color *Random_Color()
{
    return [Color COLOR_PREFIX:Random01()
                         green:Random01()
                          blue:Random01()
                         alpha:1.0f];
}

#undef COLOR_PREFIX



void findViewRecursive(UIView* seedView, int atIndex){
    
    for (UIView* aView in seedView.subviews) {
        
        NSLog(@"----%@",aView);
        
        findViewRecursive(aView, atIndex+1 );
    }
    
}

void findLabelsRecursive(UIView* seedView, int atIndex){
    
    for (UIView* aView in seedView.subviews) {
        
        if ([aView isKindOfClass:[UILabel class]]) {
            
            NSLog(@"----%@",aView);
         }
        findLabelsRecursive(aView, atIndex+1 );
     }
}

void findOnlyViewsRecursive(UIView* seedView, int atIndex){
    
    for (UIView* aView in seedView.subviews) {
        
        if ([aView conformsToProtocol: @protocol(UILayoutSupport) ]) {
            continue;
        }
        
        if ([aView isKindOfClass:[UILabel class]] == NO  &&
            [aView isKindOfClass:[UIButton class]] == NO  &&
            [aView isKindOfClass:[UIScrollView class]] == NO  &&
            [aView isKindOfClass:[UITextView class]] == NO  &&
            [aView isKindOfClass:[UITextField class]] == NO

           // [aView conformst:[_UITextFieldRoundedRectBackgroundViewNeue class]] == NO  //what's this?
            
           ) {
            
            NSLog(@"----%@",aView);
            
        }
        
        findOnlyViewsRecursive(aView, atIndex+1 );
        
    }
    
}



//view box collection.

NSArray*  collectAllViews(UIView* seedView ){
    
    NSArray* boxArray = [seedView subviews];
    
    //NSLog(@"🍎box info:%@ ",boxArray);
    
    for (UIView* eachView in seedView.subviews) {
        
        NSArray* subviews = collectAllViews(eachView);
        
        if (subviews) {
         
           boxArray =  [boxArray arrayByAddingObjectsFromArray:  subviews ];
        }
        
    }
    
    return boxArray;
}




void findLabelsRecursiveAddingView(UIView* seedView, int atIndex){
    
    for (UIView* aView in seedView.subviews) {
        
        if ([aView isKindOfClass:[UILabel class]]) {
            
            NSLog(@"----%@",aView);
            
            
            //get coordinates.
            
            CGRect newRect = CGRectMake(100, 100, 100, 15);
            
            UIButton* helpButton = [[UIButton alloc]initWithFrame:newRect];
            
            helpButton.titleLabel.text = @"hello";
            helpButton.backgroundColor = [UIColor yellowColor];
            
            
//            let vHeight = aView.frame.size.height
//            let tipLabelRect = CGRectMake(10, vHeight/2 , 100, 20)
//            let tipLabel = UILabel(frame: tipLabelRect)
//            
//            tipLabel.text = "↕h:\(vHeight)"
//            //tipLabel.font = UIFont (name: "HelveticaNeue-UltraLight", size: 8)
//            tipLabel.font = UIFont (name: "BananaYeti-Extrabold Trial", size: 10)

            
            
            [aView.superview addSubview:helpButton];
            
            
        }
        findLabelsRecursiveAddingView(aView, atIndex+1 );
    }
}




