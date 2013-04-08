//
//  RootViewController+Action.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-3.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController (Action)
- (IBAction)doAuthorize:(id)sender
{
    UIButton *auth = (UIButton *)sender;
    
    KPConsumer *consumer = [[KPConsumer alloc] initWithKey:@"xcInFxiv9tnMmS5a" secret:@"D7JvQn0wTR5rP9D9"];
    authController = [[KPAuthController alloc] initWithConsumer:consumer];
    
    if ([auth.titleLabel.text isEqualToString:@"认证方式一"]) {
        //进行导航推出授权页面
        [self.navigationController pushViewController:authController animated:YES];
        
    }else if ([auth.titleLabel.text isEqualToString:@"认证方式二"]){
        //进行present页面
        [self presentViewController:authController animated:YES completion:NULL];
    }
    
    
}

- (IBAction)doExit:(id)sender
{
    if (authController) {
        [authController clearAuthInfo];
    }
}

- (IBAction)doGetUserInfo:(id)sender
{
    _getUserInfoOp = [[KPGetUserInfoOperation alloc] initWithDelegate:self operationItem:nil];
    
    [_getUserInfoOp executeOperation];
}

- (void)doCreateFolder:(NSString*)path;
{
    KPFolderOperationItem *item = [[KPFolderOperationItem alloc] init];
    
    item.root = @"app_folder";
    item.path = path;
    
    _createFolderOp = [[KPCreateFolderOperation alloc] initWithDelegate:self operationItem:item];
    [_createFolderOp executeOperation];
    
}

- (NSString *)urlEncodeCovertString:(NSString *)source
{
    if (source==nil) {
        return @"";
    }
    
    NSMutableString *result = [NSMutableString string];
	const char *p = [source UTF8String];
	
	for(unsigned char c; (c = *p); p++) {
        
		switch(c) {
			case '0' ... '9':
			case 'A' ... 'Z':
			case 'a' ... 'z':
			case '.':
			case '-':
			case '~':
			case '_':
				[result appendFormat:@"%c", c];
				break;
			default:
				[result appendFormat:@"%%%02X", c];
		}
	}
    
	return result;
}

- (IBAction)doGetDirectoryInfo:(id)sender
{
    KPGetDirectoryOperationItem *item = [[KPGetDirectoryOperationItem alloc] init];
    
    item.root = @"app_folder";
    item.path = PATH_IMG_DIR;
    
    item.filterExt = @"jpg,png";
    item.sortType = kSortByTime;
    //    item.sortType = kSortBySize;
    
    _getDirectoryOp = [[KPGetDirectoryOperation alloc] initWithDelegate:self operationItem:item];
    [_getDirectoryOp executeOperation];
    
}

- (void)doUploadFile:(NSString*)localPath andRemotePath:(NSString*)remotePath;
{
    [_activity startAnimating];
    _progress.hidden = NO;
    _progress.progress = 0.0;
    
    KPUploadFileOperationItem *item = [[KPUploadFileOperationItem alloc] init];
    
    item.root = @"app_folder";
    
    //要上传到的文件夹必须已经创建，即hejinbo123文件夹必须已经存在,并且必须携带文件名
    item.path = remotePath;
    item.fileName =     [remotePath lastPathComponent];
    item.fileData = [NSData dataWithContentsOfFile:localPath];
    item.isOverwrite = YES;
    
    _uploadFileOp = [[KPUploadFileOperation alloc] initWithDelegate:self operationItem:item];
    [_uploadFileOp executeOperation];
    
}

- (void)doDownloadFile:(NSString*)remotePath andRemotePath:(NSString*)localPath;
{
    [_activity startAnimating];
    _progress.hidden = NO;
    _progress.progress = 0.0;
    
    MyFolderOperationItem *item = [[MyFolderOperationItem alloc] init];
    
    item.root = @"app_folder";
    //要下载的文件相对路径,并且必须携带文件名
    item.path = remotePath;
    item.destPath = localPath;
    
    _downloadFileOp = [[KPDownloadFileOperation alloc] initWithDelegate:self operationItem:item];
    [_downloadFileOp executeOperation];
    
}

-(IBAction)doDeleteFile:(id)sender
{
    KPFolderOperationItem *item = [[KPFolderOperationItem alloc] init];
    
    item.root = @"app_folder";
    item.path = @"KPTest/KPDeleteFolder/KPDeleteFile.jpg";
    
    _deleteOp = [[KPDeleteOperation alloc] initWithDelegate:self operationItem:item];
    
    [_deleteOp executeOperation];
    
}

-(IBAction)doDeleteFolder:(id)sender
{
    KPFolderOperationItem *item = [[KPFolderOperationItem alloc] init];
    
    item.root = @"app_folder";
    item.path = @"KPTest/KPDeleteFolder";
    
    _deleteOp = [[KPDeleteOperation alloc] initWithDelegate:self operationItem:item];
    
    [_deleteOp executeOperation];
    
}

-(IBAction)doMoveFile:(id)sender
{
    
    KPMoveOperationItem *item = [[KPMoveOperationItem alloc] init];
    
    item.root = @"app_folder";
    item.fromPath = @"KPTest/KPMoveSourceFile.jpg";
    item.toPath = @"KPTest/KPMoveTargetFile.jpg";
    
    _moveOp = [[KPMoveOperation alloc] initWithDelegate:self operationItem:item];
    
    [_moveOp executeOperation];
    
}

-(IBAction)doMoveFolder:(id)sender
{
    KPMoveOperationItem *item = [[KPMoveOperationItem alloc] init];
    
    item.root = @"app_folder";
    item.fromPath = @"KPTest/KPMoveSourceFolder";
    item.toPath = @"KPTest/KPMoveTargetFolder";
    
    _moveOp = [[KPMoveOperation alloc] initWithDelegate:self operationItem:item];
    
    [_moveOp executeOperation];
    
}

- (IBAction)doCopyFile:(id)sender
{
    KPCopyOperationItem *item = [[KPCopyOperationItem alloc] init];
    
    item.root = @"app_folder";
    item.fromPath = @"KPTest/KPCopySourceFile.jpg";
    item.toPath = @"KPTest/KPCopyTargetFile.jpg";
    
    _copyOp = [[KPCopyOperation alloc] initWithDelegate:self operationItem:item];
    
    [_copyOp executeOperation];
    
}

- (IBAction)doCopyFolder:(id)sender
{
    KPCopyOperationItem *item = [[KPCopyOperationItem alloc] init];
    
    item.root = @"app_folder";
    item.fromPath = @"KPTest/KPCopySourceFolder";
    item.toPath = @"KPTest/KPCopyTargetFolder";
    
    _copyOp = [[KPCopyOperation alloc] initWithDelegate:self operationItem:item];
    [_copyOp executeOperation];
    
}

- (IBAction)doShareFile:(id)sender
{
    KPGetShareLinkOperationItem *item = [[KPGetShareLinkOperationItem alloc] init];
    
    item.root = @"app_folder";
    item.name = @"123";
    item.accessCode = @"123";
    item.path = @"我的照片/2012-04-20 11.11.56_568.jpg";
    
    _shareFileOp = [[KPGetShareLinkOperation alloc] initWithDelegate:self operationItem:item];
    [_shareFileOp executeOperation];
    
}

- (IBAction)doCopyRefFile:(id)sender
{
    KPCopyOperationItem *item = [[KPCopyOperationItem alloc] init];
    
    item.root = @"app_folder";
    item.Path = @"KPTest/KPCopyRefFile.jpg";
    
    _copyRefFileOp = [[KPCopyRefOperation alloc] initWithDelegate:self operationItem:item];
    
    [_copyRefFileOp executeOperation];
    
}

- (IBAction)doCopyRefFolder:(id)sender
{
    KPCopyOperationItem *item = [[KPCopyOperationItem alloc] init];
    
    item.root = @"app_folder";
    item.Path = @"KPTest/KPCopyRefFolder";
    
    _copyRefFileOp = [[KPCopyRefOperation alloc] initWithDelegate:self operationItem:item];
    
    [_copyRefFileOp executeOperation];
    
}

- (IBAction)doThumbnail:(id)sender
{
    KPThumbnailOperationItem *item = [[KPThumbnailOperationItem alloc] init];
    
    item.root = @"app_folder";
    item.path = @"KPTest/KPTestFolder/KPTestFile.jpg";
    item.height = 123;
    item.width = 123;
    
    _thumbnailOp = [[KPThumbnailOperation alloc] initWithDelegate:self operationItem:item];
    [_thumbnailOp executeOperation];
    
}

- (IBAction)doDocumentView:(id)sender
{
    [_activity startAnimating];
    _progress.hidden = NO;
    _progress.progress = 0.0;
    
    KPDocumentConvertOperationItem *item = [[KPDocumentConvertOperationItem alloc] init];
    
    item.root = @"app_folder";
    item.path = @"KPTest/KPDocumentConvert.pdf";
    item.documentType = kDocumentPDF;
    item.viewFormat = kViewiPad;
    item.compressType = kCompressNone;
    
    _documentConvertOp = [[KPDocumentConvertOperation alloc] initWithDelegate:self operationItem:item];
    [_documentConvertOp executeOperation];
    
}

- (IBAction)doFileHistory:(id)sender
{
    KPFolderOperationItem *item = [[KPFolderOperationItem alloc] init];
    
    item.root = @"app_folder";
    item.path = @"KPTest/KPHistory.doc";
    
    _historyOP = [[KPGetFileHistoryOperation alloc] initWithDelegate:self operationItem:item];
    [_historyOP executeOperation];
    
}


@end
