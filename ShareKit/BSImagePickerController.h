//
//  BSImagePickerController.h
//  BasicShareKit
//
//  Created by ZhuJiaQuan on 13-9-26.
//  Copyright (c) 2013年 5codelab. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BSImagePickerControllerPhotoCaptureSelectionBlock)(UIImage *photo);
typedef void(^BSImagePickerControllerPhotoLibrarySelectionBlock)(UIImage *photo);
typedef void(^BSImagePickerControllerCancelBlock)(void);

@interface BSImagePickerController : UIImagePickerController
{
    BSImagePickerControllerPhotoCaptureSelectionBlock _photoCaptureSelectionBlock;
    BSImagePickerControllerPhotoLibrarySelectionBlock _photoLibrarySelectionBlock;
    BSImagePickerControllerCancelBlock _cancelBlock;
}

@property (nonatomic, copy, readonly) BSImagePickerControllerPhotoCaptureSelectionBlock photoCaptureSelectionBlock;
@property (nonatomic, copy, readonly) BSImagePickerControllerPhotoLibrarySelectionBlock photoLibrarySelectionBlock;
@property (nonatomic, copy, readonly) BSImagePickerControllerCancelBlock cancelBlock;

- (id)initWithPhotoCaptureSelectionBlock:(BSImagePickerControllerPhotoCaptureSelectionBlock)photoCaptureSelectionBlock
                             cancelBlock:(BSImagePickerControllerCancelBlock)cancelBlock;

- (id)initWithPhotoLibrarySelectionBlock:(BSImagePickerControllerPhotoLibrarySelectionBlock)photoLibrarySelectionBlock
                             cancelBlock:(BSImagePickerControllerCancelBlock)cancelBlock;

@end
