//
//  ContentVc.m
//  SampleObjc
//
//  Created by dtissera on 15/08/2014.
//  Copyright (c) 2014 o--O--o. All rights reserved.
//

#import "ContentVc.h"
#import "UIColor+DTI.h"

@interface ContentVc () {
    NSString *_hexColor;
    NSString *_title;
    NSString *_style;
}

@end

@implementation ContentVc
@synthesize pageIndex=_pageIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorFromHexString:_hexColor];
    self.labelTitle.text = _title;
    self.activityIndicatorView.indicatorStyle = _style;
    [self.activityIndicatorView startActivity];
    
    self.smallActivityIndicatorView.indicatorStyle = _style;
    [self.smallActivityIndicatorView startActivity];
}

- (void)dealloc {
    [self.activityIndicatorView stopActivity];
    [self.smallActivityIndicatorView stopActivity];
}

#pragma mark - public methods
- (void)configureWithPageIndex:(NSUInteger)pageIndex
                      hexColor:(NSString *)hexColor
                         title:(NSString *)title
                         style:(NSString *)style {
    _pageIndex = pageIndex;
    _hexColor = hexColor;
    _title = title;
    _style = style;
}

#pragma mark - IBActions
- (IBAction)actionStart:(id)sender {
    [self.activityIndicatorView startActivity];
    [self.smallActivityIndicatorView startActivity];
}

- (IBAction)actionStop:(id)sender {
    [self.activityIndicatorView stopActivity];
    [self.smallActivityIndicatorView stopActivity];
}

@end
