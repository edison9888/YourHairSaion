//
//  RootViewController.h
//  PageTest
//
//  Created by chen loman on 12-11-16.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGTabBarController.h"
#import "MyTabBarViewController.h"
#import "ProductViewController.h"
#import "OperationNode.h"
#import <KuaiPanOpenAPI/KuaiPanOpenAPI.h>
#import "MyFolderOperationItem.h"

#define PATH_DB_FILE_PATH @"YourHairSaion/DB/YourHairSaion.sqlite"
#define DB_FILE_NAME @"YourHairSaion.sqlite"
#define PATH_IMG_DIR @"YourHairSaion/IMG/Product/"
#define PATH_LOCAL_IMG_DIR @"/IMG/Product/"



@class DetailViewController;
@class ImgFullViewController;
@class StatementViewController;
@class BasePagePolicy;
typedef enum {
    LeftTabBarViewControllerProduct = 0,
    LeftTabBarViewControllerPolicy,
    LeftTabBarViewControllerMap,
    LeftTabBarViewControllerShoppingCart
} LeftTabBarViewControllerItem;


#define SPLIT_POSITION_MID 512.0f
#define SPLIT_POSITION_RIGHT_END 1024.0f


@interface RootViewController : UIViewController <UIPageViewControllerDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate>
{
    
    KPAuthController                    *authController;    // 授权及注册视图
    
    KPGetUserInfoOperation              *_getUserInfoOp;     // 获取用户信息操作
    KPCreateFolderOperation             *_createFolderOp;    // 创建文件夹操作
    KPGetDirectoryOperation             *_getDirectoryOp;    // 获取文件（夹）信息操作
    KPUploadFileOperation               *_uploadFileOp;      // 上传文件
    KPDownloadFileOperation             *_downloadFileOp;    // 下载文件
    KPDeleteOperation                   *_deleteOp;          // 删除文件（夹）操作
    KPMoveOperation                     *_moveOp;            // 移动文件（夹）操作
    KPCopyOperation                     *_copyOp;            // 复制文件（夹）操作
    KPGetShareLinkOperation             *_shareFileOp;       // 分享文件链接
    KPCopyRefOperation                  *_copyRefFileOp;     // 复制引用
    KPThumbnailOperation                *_thumbnailOp;       // 获取缩略图
    KPDocumentConvertOperation          *_documentConvertOp; // 文档转换
    KPGetFileHistoryOperation           *_historyOP;         // 文件的历史版本
    
    IBOutlet UITextView                 *_textLog;
    IBOutlet UIActivityIndicatorView    *_activity;
    IBOutlet UIProgressView             *_progress;
    IBOutlet UIImageView                *_imageView;

}

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (nonatomic, strong) ProductViewController* productViewController;
@property (nonatomic, strong) DetailViewController* detailViewController;
@property (nonatomic, strong) NSMutableArray* l1Btns;
@property (nonatomic, strong) ImgFullViewController* imgFullViewController;
@property (nonatomic, strong) StatementViewController* statementViewController;
@property (nonatomic, strong)UITextField* searchTextField;
@property (nonatomic, strong)UIButton* btnOpBack;
@property (nonatomic, strong)UIButton* btnOpForward;



- (void)setPagePolicy:(BasePagePolicy*)pagePolicy;
- (BasePagePolicy*)pagePolicy;
- (NSString*)currentSubType;
- (void)setPage:(NSInteger)leftPageIndex animated:(BOOL)animated;
- (UIViewController*)page:(NSInteger)index;
- (void)opMark:(OperationNode*)op;
- (void)opBack;
- (void)opForward;

@end

@interface RootViewController (Action)

- (IBAction)doAuthorize:(id)sender;
- (IBAction)doGetUserInfo:(id)sender;
- (void)doCreateFolder:(NSString*)path;
- (IBAction)doGetDirectoryInfo:(id)sender;
- (void)doUploadFile:(NSString*)localPath andRemotePath:(NSString*)remotePath;
- (void)doDownloadFile:(NSString*)remotePath andRemotePath:(NSString*)localPath;
- (IBAction)doDeleteFile:(id)sender;
- (IBAction)doDeleteFolder:(id)sender;
- (IBAction)doMoveFile:(id)sender;
- (IBAction)doMoveFolder:(id)sender;
- (IBAction)doCopyFile:(id)sender;
- (IBAction)doCopyFolder:(id)sender;
- (IBAction)doShareFile:(id)sender;
- (IBAction)doCopyRefFile:(id)sender;
- (IBAction)doCopyRefFolder:(id)sender;
- (IBAction)doThumbnail:(id)sender;
- (IBAction)doDocumentView:(id)sender;
- (IBAction)doFileHistory:(id)sender;
- (IBAction)doExit:(id)sender;
@end
@interface RootViewController (Operations)<KPOperationDelegate>

@end
