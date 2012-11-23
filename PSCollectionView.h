//
// PSCollectionView.h
//
// Copyright (c) 2012 Peter Shih (http://petershih.com)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#define FRAME_Content_X 20.0f
#define FRAME_Content_Y 20.0f
#define FRAME_Content_W (FRAME_W - (2 * FRAME_Content_X))
#define FRAME_Content_H (FRAME_H - FRAME_Content_X)

#define FRAME_Content_Label_W FRAME_Content_W
#define FRAME_Content_Label_H 30.0f
#define FRAME_Content_Margin 20.0f
#define FRAME_Buttom_X FRAME_Content_X
#define FRAME_Buttom_W FRAME_Content_W
#define FRAME_Buttom_H 30.0f
#define FRAME_Content_CollectView_Y (FRAME_Content_Y + FRAME_Content_Label_H + FRAME_Content_Margin)
#define FRAME_Content_CollectView_X FRAME_Content_X
#define FRAME_Content_CollectView_W FRAME_Content_W
#define FRAME_Content_CollectView_H (FRAME_Content_H - FRAME_Content_Label_H - FRAME_Buttom_H - (2 * FRAME_Content_Margin))
#define FRAME_Buttom_Y (FRAME_Content_CollectView_Y + FRAME_Content_CollectView_H + FRAME_Content_Margin)

#import <UIKit/UIKit.h>

@class PSCollectionViewCell;

@protocol PSCollectionViewDelegate, PSCollectionViewDataSource;

@interface PSCollectionView : UIScrollView

#pragma mark - Public Properties

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIView *loadingView;

@property (nonatomic, assign, readonly) CGFloat colWidth;
@property (nonatomic, assign, readonly) NSInteger numCols;
@property (nonatomic, assign) NSInteger numColsLandscape;
@property (nonatomic, assign) NSInteger numColsPortrait;
@property (nonatomic, unsafe_unretained) id <PSCollectionViewDelegate> collectionViewDelegate;
@property (nonatomic, unsafe_unretained) id <PSCollectionViewDataSource> collectionViewDataSource;

#pragma mark - Public Methods

/**
 Reloads the collection view
 This is similar to UITableView reloadData)
 */
- (void)reloadData;

/**
 Dequeues a reusable view that was previously initialized
 This is similar to UITableView dequeueReusableCellWithIdentifier
 */
- (UIView *)dequeueReusableView;

@end

#pragma mark - Delegate

@protocol PSCollectionViewDelegate <NSObject>

@optional
- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index;

@end

#pragma mark - DataSource

@protocol PSCollectionViewDataSource <NSObject>

@required
- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView;
- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index;
- (CGFloat)heightForViewAtIndex:(NSInteger)index;

@end
