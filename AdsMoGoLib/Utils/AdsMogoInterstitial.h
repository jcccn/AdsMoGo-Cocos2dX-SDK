//
//  AdsMogoInterstitial.h
//  AdsMogoCocos2dxSample
//
//  Created by Chasel on 14-4-14.
//
//

#ifndef __AdsMogoCocos2dxSample__AdsMogoInterstitial__
#define __AdsMogoCocos2dxSample__AdsMogoInterstitial__

#include <iostream>

#endif /* defined(__AdsMogoCocos2dxSample__AdsMogoInterstitial__) */

typedef enum {
    AdsMogoInterstitialTypeUnknown          = 0,  //error
	AdsMogoInterstitialTypeNormalBanner     = 1,  //e.g. 320 * 50 ; 320 * 48...           iphone banner
    AdsMogoInterstitialTypeLargeBanner      = 2,  //e.g. 728 * 90 ; 768 * 110             ipad only
    AdsMogoInterstitialTypeMediumBanner     = 3,  //e.g. 468 * 60 ; 508 * 80              ipad only
    AdsMogoInterstitialTypeRectangle        = 4,  //e.g. 300 * 250; 320 * 270             ipad only
    AdsMogoInterstitialTypeSky              = 5,  //Don't support
    AdsMogoInterstitialTypeFullScreen       = 6,  //iphone full screen ad
    AdsMogoInterstitialTypeVideo            = 11, //iPad and iPhone use video ad
    AdsMogoInterstitialTypeiPadNormalBanner = 8,  //ipad use iphone banner
    AdsMogoInterstitialTypeiPadFullScreen   = 9,  //ipad full screen ad e.g. 1024*768     ipad only
    AdsMogoInterstitialCustomSize       = 10, //iPad and iPhone use custom size
    AdsMogoInterstitialSplash           = 12, // IOS Splash Ad
} AdsMogoInterstitialType;


class AdsMogoInterstitial {
public:
    static AdsMogoInterstitial *sharedInterstitial();
    void loadInterstitial(char* mogoid,AdsMogoInterstitialType mogotype,bool ismanualrefresh);
    void showInterstitial();
    void hideInterstitial();// 释放全插屏
    void refreshAd();
};