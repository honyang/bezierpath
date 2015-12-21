//
//  ViewController.m
//  Tandemo
//
//  Created by jkb on 15/12/21.
//  Copyright © 2015年 Enjoyor. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    CustomView *view=[[CustomView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
