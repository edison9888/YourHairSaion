//
//  DetailViewCell.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-13.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductShowingDetail.h"


#define FRAME_DETAILVIEW_BGIMG_X 30
#define FRAME_DETAILVIEW_BGIMG_Y 40
#define FRAME_DETAILVIEW_BGIMG_W 405
#define FRAME_DETAILVIEW_BGIMG_H 406

#define FRAME_DETAILVIEW_IMG_X (FRAME_DETAILVIEW_BGIMG_X + 115)
#define FRAME_DETAILVIEW_IMG_Y (FRAME_DETAILVIEW_BGIMG_Y + 80)
#define FRAME_DETAILVIEW_IMG_W 200
#define FRAME_DETAILVIEW_IMG_H 250
#define FRAME_DETAILVIEW_IMG_OFFSET 20

#define FRAME_DETAILVIEW_TITLE_X 60
#define FRAME_DETAILVIEW_TITLE_Y (FRAME_DETAILVIEW_BGIMG_X + FRAME_DETAILVIEW_BGIMG_H + 20)
#define FRAME_DETAILVIEW_TITLE_W 200
#define FRAME_DETAILVIEW_TITLE_H 40

#define FRAME_DETAILVIEW_DETAIL_X FRAME_DETAILVIEW_TITLE_X
#define FRAME_DETAILVIEW_DETAIL_Y (FRAME_DETAILVIEW_TITLE_Y + FRAME_DETAILVIEW_TITLE_H + 20)
#define FRAME_DETAILVIEW_DETAIL_W (self.bounds.size.width - 2*(FRAME_DETAILVIEW_DETAIL_X))
#define FRAME_DETAILVIEW_DETAIL_H (self.bounds.size.height - FRAME_DETAILVIEW_DETAIL_Y)

#define FRAME_DETAILVIEW_SHOPPING_CART_X 368
#define FRAME_DETAILVIEW_SHOPPING_CART_Y 0


@class DetailViewController;
@interface DetailView : UIView
@property (nonatomic, strong)DetailViewController* detailViewController;
@property (nonatomic, strong) ProductShowingDetail* psd;

- (void)fillData:(ProductShowingDetail*)psd;

@end

