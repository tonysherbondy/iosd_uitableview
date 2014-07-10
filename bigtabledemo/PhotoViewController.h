//
//  PhotoViewController.h
//  bigtabledemo
//
//  Created by Anthony Sherbondy on 7/9/14.
//  Copyright (c) 2014 Anthony Sherbondy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (nonatomic, strong) NSString *url;

@end
