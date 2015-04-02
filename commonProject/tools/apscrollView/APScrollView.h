//
//  APScrollView.h
//  APExtendedScrollView
//
//  Created by Andrzej on 23.01.2013.
//  Copyright (c) 2013 apuczyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol APScrollDelegate <NSObject>
//
//-(void)detailWith:(BbsTopic *)bbsTopic;
//-(void)checkImage:(NSString *)_image;
//-(void)checkNetWork;
-(void)scrollToCurrenPage:(int)currentpage;

@end
@interface APScrollView : UIScrollView {
    UIPageControl           * _statusBarPageControl;
    UIInterfaceOrientation    _lastOrientation;
    
}
@property(nonatomic,strong)id<APScrollDelegate>delegate1;
@property(nonatomic,assign)int isSecond;
@end
