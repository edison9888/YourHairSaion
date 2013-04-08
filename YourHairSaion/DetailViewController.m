//
//  DetailViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-12.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "DetailViewController.h"
//#import "MyToolBar.h"
#import "ProductViewController.h"
#import "RootViewController.h"
#import "ImgFullViewController.h"
#import "StatementViewController.h"
#import "StatementViewController2.h"

#import "L1Button.h"
#import "L1SearchButton.h"
#import "SearchPagePolicy.h"
#import "ShoppingCartPagePolicy.h"
#import "MyUIButton.h"
#import "DetailImageView.h"
#import "TextInputPopViewController.h"
#import "FacePickerViewController.h"
#import "PopUpViewController.h"
#import "UIImage+fixOrientation.h"
#import "MyImagePickerViewController.h"
#import "PopImageViewController.h"
#import "MyImagePickerViewController2.h"
#import "DataAdapter.h"
#import "SyncMainViewController.h"
#import "SyncPopUpViewController.h"
#import "SyncMainViewController.h"
#import "SyncProgressViewController.h"
#import "CMPopTipView.h"
#import "DetailView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+CornerAddition.h"
#define IMGVIEW_NUM 3

@interface DetailViewController ()
- (void)configView;
//@property (nonatomic, retain)MyToolBar* toolBar;
@property (nonatomic, strong)NSString* currentProductId;
@property (nonatomic, retain) IBOutlet UIButton *btnGoShoppingCart;
@property (nonatomic, retain) IBOutlet UIButton* btnStatement;
@property (nonatomic, retain) IBOutlet UIButton* btnSearch;
@property (nonatomic, retain) IBOutlet UIButton* btnTakeFace;
@property (nonatomic, retain) IBOutlet UIButton* btnShowFace;
@property (nonatomic, strong)IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong)IBOutlet UIPageControl* pageControl;



@property (nonatomic, retain) IBOutlet UIImageView *imageBg;

@property (nonatomic, retain) IBOutlet UITextView *labelDetail;
@property (nonatomic, retain) IBOutlet UIButton *btnBuy1;
@property (nonatomic, retain) IBOutlet UILabel *labelPage;



@property (nonatomic, strong)UIPopoverController* pc;
@property (strong, nonatomic)TextInputPopViewController* inputPvc;
@property (nonatomic, strong)MyImagePickerViewController2* imagePicker;


//sync
@property (nonatomic, strong)SyncProgressViewController* syncProgressViewController;
@property (nonatomic, assign)BOOL isSyncing;

//- (void)scaleToolbarItem;

- (IBAction)showStatement;
- (IBAction)buyProduct;
- (IBAction)onSearch:(id)sender;
- (IBAction)onTakeFace:(id)sender;
- (IBAction)onShowFace:(id)sender;
- (IBAction)onSync:(id)sender;
- (IBAction)onGoShoppingCart:(id)sender;
- (IBAction)onResetUserData:(id)sender;
- (void)imgTouchInside:(id)sender;

@end

@implementation DetailViewController
@synthesize currentProductId,btnStatement, btnSearch, btnGoShoppingCart, pc, inputPvc, btnTakeFace, imagePicker, syncProgressViewController, isSyncing;
//@synthesize toolBar = _toolBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"DetailView" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"%s", __FUNCTION__);
    [super viewDidLoad];
    [self configView];
}

- (void)viewDidUnload
{
    NSLog(@"%s", __FUNCTION__);
}
- (void)didReceiveMemoryWarning
{
    NSLog(@"%s", __FUNCTION__);
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);
    [super viewDidAppear:animated];
    //[super viewWillAppear:animated];
    //NSLog(@"DetailFrame!!!x=%f, y=%f, w=%f, h=%f", self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
    
}

- (void)configView
{
    NSLog(@"%s", __FUNCTION__);
    //self.detailView = [[DetailView alloc]initWithFrame:CGRectMake(0, 0, FRAME_W, FRAME_H)];
    //self.detailView.detailViewDelegate = self;
    //[self.view addSubview:self.detailView];
    
//    self.toolBar = [[MyToolBar alloc]initWithFrame:CGRectMake(FRAME_W-50 , FRAME_H - 50, 50, 50)];
 //   self.toolBar.barStyle = UIBarStyleBlackTranslucent;
 
    //btnStatement = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    //btnStatement.center = self.view.center;
    //[btnStatement setImage:[UIImage imageNamed:@"btnStatement.png"] forState:UIControlStateNormal];
    //[btnStatement addTarget:self action:@selector(showStatement) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:btnStatement];
 //   [self.toolBar setItems:items animated:YES];
  //  [self.view addSubview:self.toolBar];
    
    
    //btnBuy = [[UIButton alloc]initWithFrame:CGRectMake(FRAME_SHOPPING_CART_X, FRAME_SHOPPING_CART_Y, 32, 30)];
    //[btnBuy setImage:[UIImage imageNamed:@"btnShoppingCart.png"] forState:UIControlStateNormal];
    //[btnBuy addTarget:self action:@selector(buyProduct) forControlEvents:UIControlEventTouchUpInside];
    //[btnBuy setHidden:YES];
    //[self.view addSubview:btnBuy];
    
//    btnSearch = [[L1SearchButton alloc]initAll:CGRectMake(370, 10, 25, 25) andPagePolicy:[[SearchPagePolicy alloc] initWithSubType:@""] andTitle:@"" andStyle:MyUIButtonStyleRight andImgName:@"btnSearch.png" andRvc:self.psViewController.rootViewController];
//    [self.view addSubview:btnSearch];
    
//    btnSearch.pagePolicy = [[SearchPagePolicy alloc]initWithSubType:@""];
//    btnSearch.rvc = self.psViewController.rootViewController;
//    
//    UITapGestureRecognizer *tapReconizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTouchInside:)];
//    UITapGestureRecognizer *tapReconizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTouchInside:)];
//    UITapGestureRecognizer *tapReconizer3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTouchInside:)];
//    [tapReconizer setNumberOfTouchesRequired:1];
//    [tapReconizer2 setNumberOfTouchesRequired:1];
//    [tapReconizer3 setNumberOfTouchesRequired:1];
//
//    [self.imageView addGestureRecognizer:tapReconizer];
//    [self.imageView2 addGestureRecognizer:tapReconizer2];
//    [self.imageView3 addGestureRecognizer:tapReconizer3];
    
    self.scrollView.delegate = self;
    
    
    inputPvc = [[TextInputPopViewController alloc]initWithNibName:@"TextInputPopViewController" bundle:nil];
    [inputPvc setContentSizeForViewInPopover:inputPvc.view.bounds.size];
    inputPvc.rvc = self.psViewController.rootViewController;
    pc = [[UIPopoverController alloc]initWithContentViewController:inputPvc];
    inputPvc.pc = pc;
    self.labelPage.text = [NSString stringWithFormat:@"- PAGE %d -", [self indexInPage]+1];
    
    
    //self.btnTakeFace.titleLabel.backgroundColor = [UIColor yellowColor];
//    imagePicker = [[MyImagePickerViewController2 alloc]init];
//    imagePicker.picker.delegate = self;

}


- (void)setItem:(PsDataItem *)dataItem {
    NSLog(@"%s", __FUNCTION__);

    [super setItem:dataItem];
    [((DetailView*)self.view) fillData:(ProductShowingDetail*)dataItem];
}

//- (void)addProduct2Buy:(id)sender
//{
//    [[DataAdapter shareInstance]addProductToBuy:self.currentProductId];
//   // [self scaleToolbarItem];
//    /*
//    NGTabBarController* leftTabBarController = self.rootViewController.leftTabBarController;
//    if (leftTabBarController.selectedIndex == LeftTabBarViewControllerShoppingCart)
//    {
//        UINavigationController* nav = leftTabBarController.viewControllers[LeftTabBarViewControllerShoppingCart];
//        [((ShoppingCartViewController*)nav.topViewController) refresh];
//    }
//     */
//}
/*
- (void)scaleToolbarItem
{
    UIBarButtonItem* item = self.toolBar.items[0];
    if ([[DataAdapter shareInstance] productIsInShoppingCart:self.currentProductId])
    {
        item.title = @"TakeOut";
    }
    else
    {
        item.title = @"BUY";
    }
}
 */

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);

    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];

    if ([[self.psViewController.rootViewController pagePolicy] isKindOfClass:[ShoppingCartPagePolicy class]])
    {
        [self.btnStatement setHidden:NO];
        [self.btnGoShoppingCart setHidden:YES];
        [self.btnSearch setHidden:YES];

    }
    else if ([[self.psViewController.rootViewController pagePolicy] isKindOfClass:[SearchPagePolicy class]])
    {
        [self.btnStatement setHidden:YES];
        [self.btnGoShoppingCart setHidden:NO];
        [self.btnSearch setHidden:YES];
    }
    else
    {
        [self.btnStatement setHidden:YES];
        [self.btnGoShoppingCart setHidden:NO];
        [self.btnSearch setHidden:NO];
    }
    [self updateShoppingCartNum];
    
    if ([[DataAdapter shareInstance]count] <= 0)
    {
        for (UIView* view in self.view.subviews)
        {
            [view setHidden:YES];
        }
    }
    
    if ([self.psViewController.rootViewController.popImageViewController containImage])
    {
        [self.btnShowFace setHidden:NO];
    }
    else
    {
        [self.btnShowFace setHidden:YES];

    }
}

- (void)MainViewOnTouch:(UIView *)view andData:(ProductShowingDetail *)psd
{
    NSLog(@"%s", __FUNCTION__);

    self.psViewController.rootViewController.navigationController.navigationBarHidden = NO;
    [self.psViewController.rootViewController.imgFullViewController setData:psd];
    [self.psViewController.rootViewController.navigationController pushViewController:self.psViewController.rootViewController.imgFullViewController animated:YES];
}

- (void)showStatement
{
    NSLog(@"%s", __FUNCTION__);
    [self.psViewController.rootViewController.statementViewController setProductViewController:self.psViewController andIndex:[self.psViewController indexInPage]];
//    [self.psViewController.rootViewController.navigationController pushViewController:self.psViewController.rootViewController.statementViewController animated:YES];
//    self.psViewController.rootViewController.navigationController.navigationBarHidden = NO;
    [self.psViewController.rootViewController showStatement];

}

- (void)buyProduct
{
    NSLog(@"%s", __FUNCTION__);
    if (self.psViewController != nil && [self.psViewController isKindOfClass:[PsViewController class]])
    {
        [((ProductViewController*)self.psViewController) buyCurrentSelection];
        [self updateShoppingCartNum];
    }
}


- (void)imgTouchInside:(id)sender
{
    NSLog(@"%s", __FUNCTION__);

    UITapGestureRecognizer* tabReg = sender;
    DetailImageView* view = tabReg.view;
    if (view.rotation == 0.0f)
    {
        [self MainViewOnTouch:self.view andData:((DetailView*)self.view).psd];
    }
    else
    {
        int target = view.tag;
        for (int i = 1; i < IMGVIEW_NUM+1; i ++)
        {
            if (i != target)
            {
                DetailImageView* toBeSwith = (DetailImageView*)[self.view viewWithTag:i];
                if (toBeSwith.rotation == 0.0f)
                {
                    
//                    NSLog(@"x=%f, y=%f", toBeSwith.center.x, toBeSwith.center.y);
//                    NSLog(@"x=%f, y=%f", view.center.x, view.center.y);

//                    CGPoint rectTmp = toBeSwith.center;
//                    CGFloat rotation = view.rotation;
//                    toBeSwith.center = view.center;
//                    view.rotation = toBeSwith.rotation;
//                    view.center = rectTmp;
//                    toBeSwith.rotation = rotation;
//                    [self.view bringSubviewToFront:view];
                    
                    //toBeSwith.frame = CGRectMake(0, 0, 200, 200);
//                    view.rotation = 0.0f;
//
//                    view.center = CGPointMake(view.center.x + 100, toBeSwith.center.y);
//                    view.center = CGPointMake(view.center.x + 20, toBeSwith.center.y);

//                    view.center = CGPointMake(50, 0);
//                    CGFloat rotation = view.rotation;
//                    toBeSwith.rotation = rotation;
//                    [self.view bringSubviewToFront:view];
                    UIImage* tmp = view.image;
                    view.image = toBeSwith.image;
                    toBeSwith.image = tmp;


                }
            }
        }
    }
}

- (IBAction)onSearch:(id)sender
{
    //pc.popoverContentSize = inputPvc.view.bounds.size;//CGSizeMake(400, 400);
    
    [pc presentPopoverFromRect:CGRectMake(0, 0, 25, 25) inView:self.btnSearch permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)onTakeFace:(id)sender
{
    
//    FacePickerViewController* facePicker = [[FacePickerViewController alloc]init];
//    facePicker.view.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
//    PopUpViewController* pop = [[PopUpViewController alloc]initWithContentViewController:facePicker];
//    [pop show:self.psViewController.rootViewController.view andAnimated:YES];
    //[self.psViewController.rootViewController.view addSubview:facePicker.view];
    //[self.psViewController.rootViewController.view bringSubviewToFront:facePicker.view];
        
//    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
//    
//    NSString *requiredMediaType = (__bridge NSString *)kUTTypeImage;
//    controller.mediaTypes = [[NSArray alloc]
//                             initWithObjects:requiredMediaType, nil];
//    controller.allowsEditing = NO;
//    controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
//    UIImage* img = [UIImage imageNamed:@"1_noface.png"];
//    UIImageView* iv = [[UIImageView alloc]initWithImage:img];
//    CGFloat objectWidth = CGImageGetWidth(img.CGImage);
//    CGFloat objectHeight = CGImageGetHeight(img.CGImage);
//    CGRect cameraOverlayFrame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);//controller.cameraOverlayView.frame;
//    CGFloat frameWidth = cameraOverlayFrame.size.width;
//    CGFloat frameHeight = cameraOverlayFrame.size.height;
//    CGFloat ivWidth = 0;
//    CGFloat ivHeight = 0;
//    //长形
//    if (objectWidth/SCREEN_W > objectHeight/SCREEN_H)
//    {
//        ivWidth = frameWidth;
//        ivHeight = objectHeight/(objectWidth/frameWidth);
//    }
//    //竖型
//    else
//    {
//        ivHeight = frameHeight;
//        ivWidth = objectWidth/(objectHeight/frameHeight);
//    }
//
//    iv.frame = CGRectMake((cameraOverlayFrame.size.width-ivWidth)/2, (cameraOverlayFrame.size.height-ivHeight)/2, ivWidth, ivHeight);
//    iv.contentMode = UIViewContentModeScaleAspectFill;
//    [controller.cameraOverlayView addSubview:iv];
    if (nil != [self.item.imgDic objectForKey:PRODUCT_PIC_TYPE_NOFACE])
    {
        UIImage* overlay = [self.item.imgDic objectForKey:PRODUCT_PIC_TYPE_NOFACE];
        //filePath = [[DataAdapter shareInstance]getLocalPath:filePath];
        self.imagePicker = [[MyImagePickerViewController2 alloc]initWithImage:overlay];
        imagePicker.picker.delegate = self;
        [self.psViewController.rootViewController presentModalViewController:imagePicker animated:YES];
    }
    else
    {
        CMPopTipView* popTipView = [[CMPopTipView alloc] initWithMessage:@"该产品不给力，暂不支持试用！"];
        popTipView.backgroundColor = [UIColor grayColor];
        popTipView.animation = YES;
        
        popTipView.dismissTapAnywhere = YES;
        [popTipView autoDismissAnimated:YES atTimeInterval:3.0];
        [popTipView presentPointingAtView:sender inView:self.view animated:YES];

    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *camImage = [[info objectForKey:@"UIImagePickerControllerOriginalImage"] fixOrientation];
    camImage = [camImage downMirrored];
    UIImage* myImg = [imagePicker.pickerOverLayoutImageView.image  downMirrored];
    
    UIImage *outputImage = [camImage merge:myImg];
    [self.psViewController.rootViewController dismissModalViewControllerAnimated:YES];
//    PopImageViewController* pImgView = [[PopImageViewController alloc]initWithNibName:@"PopImageViewController" bundle:nil];
    [self.psViewController.rootViewController.popImageViewController addImage:outputImage];
    PopUpViewController* pop = [[PopUpViewController alloc]initWithContentViewController:self.psViewController.rootViewController.popImageViewController];
    [pop show:self.psViewController.rootViewController.view andAnimated:YES];
    [self.btnShowFace setHidden:NO];
    self.imagePicker.picker = nil;
    self.imagePicker = nil;

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.psViewController.rootViewController dismissModalViewControllerAnimated:YES];
    self.imagePicker.picker = nil;
    self.imagePicker = nil;

}

- (void)onShowFace:(id)sender
{
    PopUpViewController* pop = [[PopUpViewController alloc]initWithContentViewController:self.psViewController.rootViewController.popImageViewController];
    [pop show:self.psViewController.rootViewController.view andAnimated:YES];
}




- (void)onResetUserData:(id)sender
{
    [self.psViewController.rootViewController resetData:YES];
    [self reset];
    [self updateShoppingCartNum];

}

- (void)reset
{
    imagePicker = [[MyImagePickerViewController2 alloc]init];
    imagePicker.picker.delegate = self;
}


- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;

}

- (void)updateShoppingCartNum
{
    NSUInteger buyCount = [[DataAdapter shareInstance]totalNumInShoppingCart];
    if (buyCount > 0)
    {
        [self.btnGoShoppingCart setCornerContent:[NSString stringWithFormat:@"%d", buyCount]];
    }
    else
    {
        [self.btnGoShoppingCart setCornerContent:nil];
    }
}


- (void)onGoShoppingCart:(id)sender
{
    if ([[DataAdapter shareInstance].productsToBuy count] <= 0 )
    {
        CMPopTipView* popTipView = [[CMPopTipView alloc] initWithMessage:@"亲还木有购买任何产品哦！"];
        popTipView.backgroundColor = [UIColor grayColor];
        popTipView.animation = YES;
        
        popTipView.dismissTapAnywhere = YES;
        [popTipView autoDismissAnimated:YES atTimeInterval:3.0];        [popTipView presentPointingAtView:sender inView:self.view animated:YES];
    }
    else
    {
        [((L1Button*)self.psViewController.rootViewController.l1Btns.lastObject) sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    
}
@end
