//
// Copyright (c) 2010-2011 René Sprotte, Provideal GmbH
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
// OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "MMGridViewDefaultCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation MMGridViewDefaultCell

@synthesize backgroundView;
@synthesize photo;
@synthesize canyulabel;
@synthesize Canjia;



- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor=[UIColor whiteColor];
        
        photo=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 94, 52)];

        photo.layer.borderColor=[BACK_COLOR CGColor];
        photo.layer.borderWidth=1.0f;
        [self addSubview:photo];
        canyulabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 57,47, 20)];
        [self addSubview:canyulabel];
        canyulabel.font=[UIFont systemFontOfSize:12];
        canyulabel.textColor=YINGYONG_COLOR;
        Canjia=[[UILabel alloc]initWithFrame:CGRectMake(47, 57, 47, 20)];
        Canjia.font=[UIFont systemFontOfSize:12];
        [self addSubview:Canjia];
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
