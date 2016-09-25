//
//  ViewController.m
//  evvDetectColorAndFontObj
//
//  Created by artist on 9/25/16.
//  Copyright © 2016 EddieKwon. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+HexConvert.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *bigLabel;
@property (weak, nonatomic) IBOutlet UIView *orangeView;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
 
    // 동일한 칼러를 적용하여도 xib 와 code 가 일치하지 않는다
    // 참고: http://inaka.net/blog/2014/09/05/getting-the-right-colors-in-your-ios-app/
    
    UIColor* someColor =  [UIColor colorFromHexString: @"#15F80B" ];  //UIDeviceRGBColorSpace 0.0823529 0.972549 0.0431373 1
    UIColor* refViewColor = _orangeView.backgroundColor;        // UIDeviceRGBColorSpace 0.15009 0.99592 0.0515978 1
    
    _bigLabel.textColor =    someColor;
    
    NSArray* box =  collectAllViews( self.view   );
    
    for (UIView* eachView in box) {
        
        if ([eachView conformsToProtocol:@protocol(UILayoutSupport) ] ) {
            continue;     //_UILayoutGuide 타입이면 스킵.
        }
        
        //detect label color
        if ([eachView isKindOfClass:[UILabel class] ]) {
            
            UILabel* aLabel = (UILabel*)eachView;
            NSString* colorHexStr = [@"c:" stringByAppendingString: [UIColor hexStringFromColor: aLabel.textColor  ] ];
            aLabel.text = colorHexStr;
         
            
        //skip for button
        } else if ([eachView isKindOfClass:[UIButton class] ]) {
       
            
        //detect view color
        }else  {
         
            CGRect stickRect = CGRectMake(20, 0 , 2, eachView.frame.size.height);
            
            UIView *narrowStick = [[UILabel alloc]initWithFrame:   stickRect ];
            narrowStick.backgroundColor = [UIColor blackColor];
            [eachView  addSubview:narrowStick ];
            
            
            CGFloat vHeight = eachView.frame.size.height;
            CGRect tipLabelRect = CGRectMake(10, vHeight/2 , 100, 20) ;
            UIButton* tipButton = [[UIButton alloc]initWithFrame:   tipLabelRect ];
            
            // 칼러정보
            NSString*   vString =  [UIColor hexStringFromColor:eachView.backgroundColor ];
            // 사이즈
                        vString = [NSString stringWithFormat:@"↕h:%d", (int)vHeight];
            
            
            [tipButton setTitle: vString   forState:UIControlStateNormal];
            tipButton.titleLabel.textColor = [UIColor whiteColor];
            tipButton.backgroundColor = [UIColor blackColor];
            tipButton.userInteractionEnabled = YES;
            //tipLabel.font = UIFont (name: "HelveticaNeue-UltraLight", size: 8)
            tipButton.titleLabel.font = [UIFont fontWithName:  @"BananaYeti-Extrabold Trial" size: 10 ];
            [eachView  addSubview:tipButton ];
            
            [tipButton addTarget:self action:@selector(moveMeSomewhere:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}


-(void)moveMeSomewhere:(UIButton*)sender {
    
    CGFloat superHeight = sender.superview.frame.size.height * 0.9; //max 90%
    CGRect orgFrame = sender.frame;
    int randInt = arc4random() % (int)superHeight;
    orgFrame.origin.y = randInt;
   
    sender.frame = orgFrame;
}

 

@end


