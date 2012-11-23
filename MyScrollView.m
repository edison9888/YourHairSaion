//
//  MyScrollView.m
//  PhotoBrowserEx
//
//  Created by on 10-6-12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyScrollView.h"


@implementation MyScrollView


@synthesize image;


#pragma mark -
#pragma mark === Intilization ===
#pragma mark -
- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
	{
		self.delegate = self;
		self.minimumZoomScale = 0.5;
		self.maximumZoomScale = 2.5;
		self.showsVerticalScrollIndicator = NO;
		self.showsHorizontalScrollIndicator = NO;
		
		imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		imageView.contentMode = UIViewContentModeCenter;
		[self addSubview:imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)img
{
	imageView.image = img;
}

#pragma mark -
#pragma mark === UIScrollView Delegate ===
#pragma mark -
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{	
	return imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
	//NSLog(@"%s", _cmd);
	
	CGFloat zs = scrollView.zoomScale;
	zs = MAX(zs, 1.0);
	zs = MIN(zs, 2.0);	
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];		
	scrollView.zoomScale = zs;	
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark === UITouch Delegate ===
#pragma mark -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"%s", _cmd);
	
	UITouch *touch = [touches anyObject];
	
	if ([touch tapCount] == 2) 
	{
		//NSLog(@"double click");
		
		CGFloat zs = self.zoomScale;
		zs = (zs == 1.0) ? 2.0 : 1.0;
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];			
		self.zoomScale = zs;	
		[UIView commitAnimations];
	}
}

@end
