/**
 @property(nonatomic,assign) BOOL *navisHiddenLeftitle;  //是否显示返回标题 默认显示，值为YES时则隐藏返回标题
 @property(nonatomic,strong) NSString *navTiltle;        //中间标题
 @property(nonatomic,strong) NSString *navrigthTitle;    //右边标题
 
 注：继承此类必须要加入到navigationcontroller中
 
 */
#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


@property(nonatomic,assign) BOOL *navisHiddenLeftitle;  //左边标题
@property(nonatomic,strong) NSString *navTiltle;     //中间标题
@property(nonatomic,strong) NSString *navrigthTitle;    //右边标题
@end
