//
//  AdsmogoBanner.mm
//  AdsMogoCocos2dxSample
//
//  Created by Chasel on 14-4-14.
//
//

#include "AdsmogoBanner.h"
#include "cocos2d.h"
#import "AdMoGoView.h"
#import "AppController.h"
//#import "EAGLView.h"
#import "CCEAGLView.h"
#import "AdMoGoLogCenter.h"
#import "AppController.h"



@interface BannerObj :NSObject<AdMoGoDelegate,AdMoGoWebBrowserControllerUserDelegate>
{
    AdMoGoView * adbanner;
}
-(AdMoGoView*)createBanner:(NSString*)mogoid andBannerType:(AdViewType)type;
-(void)hideBanner;
@end


@implementation BannerObj

+ (BannerObj *)sharedInstance {
    static BannerObj *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

-(AdMoGoView *)createBanner:(NSString *)mogoid andBannerType:(AdViewType)type isManualRefresh:(BOOL)ismanualrefresh{
    if (adbanner) {
        [self hideBanner];
    }
    //普通初始化方式
    adbanner= [[AdMoGoView alloc] initWithAppKey:mogoid adType:type   adMoGoViewDelegate:self adViewPointType:AdMoGoViewPointTypeTop_middle isManualRefresh:ismanualrefresh];
    //手动轮换广告初始化方式  isManualRefresh   YES :手动刷新  NO：自动刷新   设置isManualRefresh参数时候必须将芒果后台的刷新禁用才可使用。
//     adbanner= [[AdMoGoView alloc] initWithAppKey:mogoid adType:type adMoGoViewDelegate:self adViewPointType:AdMoGoViewPointTypeTop_middle isManualRefresh:YES];
    [self showMogoLog];
    adbanner.frame = CGRectZero;
    CGFloat centerX = CGRectGetWidth(adbanner.bounds);
    CGFloat centerY = CGRectGetHeight(adbanner.bounds);
    adbanner.center = CGPointMake(centerX, centerY);
    return adbanner;
}


/*
 手动刷新接口 在芒果后台配置刷新时间为不刷新
 调用这个接口手动刷新横幅广告;
 如果设置的轮换时间不是不刷新,调用此接口无效.
 */
-(void)refreshAd{
    [adbanner refreshAd];   //调用手动刷新接口
}


-(void)hideBanner{
    if (adbanner) {
        [adbanner removeFromSuperview];
         [adbanner release],adbanner=nil;
    }
}

-(void)showMogoLog{
    [[AdMoGoLogCenter shareInstance] setLogLeveFlag:AdMoGoLogTemp];
}


-(void)dealloc{
    [super dealloc];
}
#pragma AdMoGoDelegate
/*
 Return to advertising （rootViewController old code）
 */
- (UIViewController *)viewControllerForPresentingModalView{
    UIViewController *result = nil;
    
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    
    if (topWindow.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows){
            if (topWindow.windowLevel == UIWindowLevelNormal){
                break;
            }
        }
    }
    
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    id nextResponder = [rootView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        
        result = nextResponder;
        
    }else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil){
        
        result = topWindow.rootViewController;
        
    }
    return result;
}

/** 
 Advertising initialization is complete
*/
- (void)adMoGoInitFinish:(AdMoGoView *)adMoGoView{
    
}


/**
 * Advertising began to request a callback
 */
- (void)adMoGoDidStartAd:(AdMoGoView *)adMoGoView{
    
}
/**
 * You can get notified when the user receive the ad
 */
- (void)adMoGoDidReceiveAd:(AdMoGoView *)adMoGoView{

}
/**
 * You can get notified when the user failed receive the ad
 */
- (void)adMoGoDidFailToReceiveAd:(AdMoGoView *)adMoGoView didFailWithError:(NSError *)error{

}
/**
 * Back to click on ads
 */
- (void)adMoGoClickAd:(AdMoGoView *)adMoGoView{

}
/**
 *You can get notified when the user delete the ad
 */
- (void)adMoGoDeleteAd:(AdMoGoView *)adMoGoView{
    
}


#pragma AdMoGoWebBrowserControllerUserDelegate

/*
 The browser will display
 */
- (void)webBrowserWillAppear{


}

/*
 Browser has shown
 */
- (void)webBrowserDidAppear{

}

/*
 The browser will be shut down
 */
- (void)webBrowserWillClosed{

}

/*
 The browser is closed
 */
- (void)webBrowserDidClosed{

}

/*
 The browser share
 url Browser to open the url
 */
- (void)webBrowserShare:(NSString *)url{

}

@end

AdsmogoBanner * AdsmogoBanner ::sharedBanner(){
    static AdsmogoBanner * banner=NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        banner= new AdsmogoBanner;
    });
    return banner;
}

// TODO:You can modify this method according to your needs
void AdsmogoBanner::showBanner(char * mogoid,AdsmogoBannerType type,float x, float y,bool  ismanualrefresh) {
    NSString *mogo_id = [[NSString alloc] initWithCString:mogoid
                                                        encoding:NSASCIIStringEncoding];
    //Set the advertising types
    AdViewType mogotype=(AdViewType)type;
    //You can set the debug mode
    
    //create the advertising
    BannerObj  * bannerView=[BannerObj sharedInstance];
    //For advertising
    AdMoGoView * mogoBanner =[bannerView createBanner:mogo_id andBannerType:mogotype isManualRefresh:ismanualrefresh ];
    //Set the advertising position
    mogoBanner.center = CGPointMake(x,y);
    //Set the advertising of the container
    auto view = cocos2d::Director::getInstance()->getOpenGLView();
    CCEAGLView *eaglview = (CCEAGLView *) view->getEAGLView();
    [eaglview addSubview:mogoBanner];
    
}



void AdsmogoBanner::hideBanner(){
    [[BannerObj sharedInstance]hideBanner];
}

void AdsmogoBanner::refreshAd(){
    [[BannerObj sharedInstance]refreshAd];
}

