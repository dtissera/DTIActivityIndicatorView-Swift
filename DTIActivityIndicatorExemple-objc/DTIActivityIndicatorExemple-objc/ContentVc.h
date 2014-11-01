//
//  ContentVc.h
//  SampleObjc
//
//  Created by dtissera on 15/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DTIActivityIndicator/DTIActivityIndicator-Swift.h>

@interface ContentVc : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet DTIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet DTIActivityIndicatorView *smallActivityIndicatorView;

@property (nonatomic, readonly) NSUInteger pageIndex;

- (void)configureWithPageIndex:(NSUInteger)pageIndex
                      hexColor:(NSString *)hexColor
                         title:(NSString *)title
                         style:(NSString *)style;

- (IBAction)actionStart:(id)sender;
- (IBAction)actionStop:(id)sender;

@end
