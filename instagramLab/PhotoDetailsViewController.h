//
//  PhotoDetailsViewController.h
//  instagramLab
//
//  Created by Liz Chaddock on 9/14/15.
//  Copyright (c) 2015 Liz Chaddock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSDictionary *selectedPhoto;

@end
