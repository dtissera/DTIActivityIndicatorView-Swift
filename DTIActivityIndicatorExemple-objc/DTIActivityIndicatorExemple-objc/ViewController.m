//
//  ViewController.m
//  DTIActivityIndicatorExemple-objc
//
//  Created by David Tisserand on 01/11/2014.
//  Copyright (c) 2014 dtissera. All rights reserved.
//

#import "ViewController.h"
#import "ContentVc.h"

@interface ViewController () <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pages;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pages = @[
                   @{@"title": @"Rotating plane", @"color": @"#d35400", @"style": @"rotatingPane"},
                   @{@"title": @"Double bounce", @"color": @"#2c3e50", @"style": @"doubleBounce"},
                   @{@"title": @"Wave", @"color": @"#1abc9c", @"style": @"wave"},
                   @{@"title": @"Wandering cubes", @"color": @"#1d8fd5", @"style": @"wanderingCubes"},
                   @{@"title": @"Chasing dots", @"color": @"#f1c40f", @"style": @"chasingDots"},
                   @{@"title": @"Pulse", @"color": @"#7f8c8d", @"style": @"pulse"},
                   @{@"title": @"Spotify", @"color": @"#e0e2e3", @"style": @"spotify"},
                   @{@"title": @"Wp8", @"color": @"#1d8fd5", @"style": @"wp8"}
                   ];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    ContentVc *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    // Auto layout
    self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Create the views dictionaries
    UIView *pv = self.pageViewController.view;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(pv);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pv]-0-|" options:0 metrics:0 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[pv]-0-|" options:0 metrics:0 views:views]];

    /*
     debug only
     [self.pageViewController setViewControllers:@[[self viewControllerAtIndex:6]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
     */
}

#pragma mark - private methods
- (ContentVc *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.pages count] == 0) || (index >= [self.pages count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    ContentVc *contentVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentVc"];
    
    NSDictionary *page = [self.pages objectAtIndex:index];
    [contentVc configureWithPageIndex:index
                             hexColor:[page objectForKey:@"color"]
                                title:[page objectForKey:@"title"]
                                style:[page objectForKey:@"style"]
     ];
    
    return contentVc;
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((ContentVc *) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((ContentVc *) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pages count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

@end

