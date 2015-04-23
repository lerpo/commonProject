//
//  AspactAcrollViewViewController.h
//  commonProject
//
//  Created by JEREI on 15-4-23.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import "BaseViewController.h"
#import "APScrollView.h"
@interface AspactAcrollViewViewController : BaseViewController<APScrollDelegate,UIScrollViewDelegate>
{
    APScrollView *apsScrollView;
}
@end
