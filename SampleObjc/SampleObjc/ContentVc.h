//
//  ContentVc.h
//  SampleObjc
//
//  Created by dtissera on 15/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleObjc-Swift.h"

@interface ContentVc : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet DTIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, readonly) NSUInteger pageIndex;

- (void)configureWithPageIndex:(NSUInteger)pageIndex
                      hexColor:(NSString *)hexColor
                         title:(NSString *)title
                         style:(NSString *)style;

@end
