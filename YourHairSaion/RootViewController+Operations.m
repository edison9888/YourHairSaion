//
//  RootViewController+Operations.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-3.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController (Operations)

#pragma mark - KPOperationDelegate methods

- (void)operation:(KPOperation *)operation success:(id)data
{
    if (_getUserInfoOp == operation) {
        
        KPUserInfo *info = data;
        
        NSString *msg = [NSString stringWithFormat:@"UserInfo:%d,%@,%lld,%lld,%lld",info.userID,info.userName,info.maxFileSize,info.quotaTotal,info.quotaUsed];
        _textLog.text = msg;
        
        
        _getUserInfoOp = nil;
    }
    else if (_createFolderOp == operation) {
        KPFolderInfo *info = data;
        
        _textLog.text = [NSString stringWithFormat:@"CreateFolderInfo:%@,%@,%@,%u",info.root,info.path,info.fileID];
        
        _createFolderOp = nil;
    }
    else if (_getDirectoryOp == operation) {
        
        KPDirectoryInfo *directoryInfo = data;
        
        _textLog.text = [NSString stringWithFormat:@"GetDirecotryInfo:%@",directoryInfo];
        
        
        _getDirectoryOp = nil;
    }
    else if (_uploadFileOp == operation) {
        NSString *serverReturn = data;
        _textLog.text = [NSString stringWithFormat:@"UploadFileInfo:%@",serverReturn];
        
        _uploadFileOp = nil;
        
        _activity.hidden = YES;
        [_activity stopAnimating];
        _progress.hidden = YES;
    }
    else if (_downloadFileOp == operation) {
        
        //下载的文件临时存储路径，最后使用Move方法将该文件移走即操作快速又避免临时文件占用硬盘空间。
        NSString *localFilePath = data;
        NSString* destPath = [NSString stringWithFormat:@"%@%@%@", [[DataAdapter shareInstance]path], PATH_LOCAL_IMG_DIR,[localFilePath lastPathComponent]];
        NSFileManager *fileManage = [NSFileManager defaultManager];
        [fileManage moveItemAtPath:data toPath:destPath error:nil];
        _textLog.text = [NSString stringWithFormat:@"download file success,local path:%@",localFilePath];
        
        _downloadFileOp = nil;
        
        _activity.hidden = YES;
        [_activity stopAnimating];
        _progress.hidden = YES;
    }
    else if (_deleteOp == operation) {
        NSString *serverReturn = data;
        _textLog.text = [NSString stringWithFormat:@"delete success:%@",serverReturn];
        
        _deleteOp = nil;
    }
    else if (_moveOp == operation) {
        NSString *serverReturn = data;
        _textLog.text = [NSString stringWithFormat:@"move success:%@",serverReturn];
        
        _moveOp = nil;
    }
    else if (_copyOp == operation) {
        NSDictionary *serverReturn = data;
        _textLog.text = [NSString stringWithFormat:@"copy success:文件的id为 :%@",[serverReturn objectForKey:@"file_id"]];
        
        _copyOp = nil;
    }
    else if (_shareFileOp == operation) {
        NSDictionary *serverReturn = data;
        _textLog.text = [NSString stringWithFormat:@"分享链接为 :%@",[serverReturn objectForKey:@"url"]];
        
        _shareFileOp = nil;
    }
    else if (_copyRefFileOp == operation) {
        NSDictionary *serverReturn = data;
        _textLog.text = [NSString stringWithFormat:@"复制引用 :%@",[serverReturn objectForKey:@"copy_ref"]];
        
        _copyRefFileOp = nil;
    }
    else if (_thumbnailOp == operation) {
        
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        _imageView.image = image;
        
        _thumbnailOp = nil;
    }
    else if (_documentConvertOp == operation) {
        
        //下载的文件临时存储路径，使用完后，为了不占用空间，请将临时文件删除
        NSString *localFilePath = data;
        _textLog.text = [NSString stringWithFormat:@"document convert success,local path:%@",localFilePath];
        
        _documentConvertOp = nil;
        
        _activity.hidden = YES;
        [_activity stopAnimating];
        _progress.hidden = YES;
    }
    else if (_historyOP == operation) {
        
        NSMutableArray *fileHistorys = data;
        
        NSMutableString *historyString = [[NSMutableString alloc] init];
        for (KPFileHistoryInfo *fileHistory in fileHistorys) {
            [historyString appendFormat:@"文件ID为：%@，文件的版本为：%@，文件的创建时间为：%@\n",fileHistory.fileId,fileHistory.version,fileHistory.createTime];
        }
        
        _textLog.text = [@"文件的历史版本信息---" stringByAppendingFormat:@"%@",historyString];
        
        _historyOP = nil;
    }
    NSLog(@"%@", _textLog.text);
}

- (void)operation:(KPOperation *)operation fail:(NSString *)errorMessage
{
    NSLog(@"fail Message:%@",errorMessage);
    _textLog.text = errorMessage;
    
    _activity.hidden = YES;
    [_activity stopAnimating];
    _progress.hidden = YES;
}

- (void)operation:(KPOperation *)operation
totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    CGFloat progress = (totalBytesWritten*1.0) / totalBytesExpectedToWrite;
    _progress.progress += progress;
}
@end
