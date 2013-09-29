//
//  BSImagePickerController.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-26.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSImagePickerController : UIImagePickerController

- (id)initWithPhotoCaptureSelectionBlock:(void(^)(UIImage *photo))photoCaptureSelectionBlock
                             cancelBlock:(void(^)(void))cancelBlock;

- (id)initWithPhotoLibrarySelectionBlock:(void(^)(UIImage *photo))photoLibrarySelectionBlock
                             cancelBlock:(void(^)(void))cancelBlock;

@end
