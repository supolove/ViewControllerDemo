//
//  ViewController.m
//  ViewControllerDemo
//
//  Created by supozheng on 2017/6/15.
//  Copyright © 2017年 supozheng. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController1.h"
#import "TableViewController2.h"

@interface ViewController ()
@property(nonatomic,strong)UIScrollView *scrollview;

@property(nonatomic,strong)TableViewController1 *vc1;

@property(nonatomic,strong)TableViewController2 *vc2;

@property(nonatomic,strong)UIViewController *currentVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat buttonWidth = (self.view.frame.size.width - 30)/2;
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, buttonWidth, 30)];
    [self.view addSubview:button1];
    [button1 setTitle:@"click1" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 setBackgroundColor:[UIColor blueColor]];
    [button1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth + 20, 20, buttonWidth, 30)];
    [self.view addSubview:button2];
    [button2 setTitle:@"click2" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor greenColor]];
    [button2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.scrollview = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.scrollview];
    self.scrollview.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
    self.scrollview.pagingEnabled = YES;
    
    self.vc1 = [[TableViewController1 alloc] init];
    self.vc2 = [[TableViewController2 alloc] init];
    
    [self addChildViewController:self.vc1];
    [self addChildViewController:self.vc2];
    
    self.vc1.view.frame = self.view.frame;
    self.vc2.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    self.vc1.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    self.vc2.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    
    [self.scrollview addSubview:self.vc1.view];
    
    [self.scrollview addSubview:self.vc2.view];
    
    [self.view bringSubviewToFront:button1];
    [self.view bringSubviewToFront:button2];
    
    self.currentVC = self.vc1;
    
}

-(void) click1{
//    [self transitionFromOldViewController:self.currentVC toNewViewController:self.vc2];
    CGPoint scrPoint = self.scrollview.contentOffset;
    scrPoint.x = 0;
    [self.scrollview setContentOffset:scrPoint animated:YES];
}

-(void) click2{
    CGPoint scrPoint = self.scrollview.contentOffset;
    scrPoint.x = self.view.frame.size.width;
    [self.scrollview setContentOffset:scrPoint animated:YES];
}


//转换子视图控制器
- (void)transitionFromOldViewController:(UIViewController *)oldViewController toNewViewController:(UIViewController *)newViewController{
    [self transitionFromViewController:oldViewController toViewController:newViewController duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newViewController didMoveToParentViewController:self];
            self.currentVC = newViewController;
        }else{
            self.currentVC = oldViewController;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
