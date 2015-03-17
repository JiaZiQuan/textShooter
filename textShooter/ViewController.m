//
//  ViewController.m
//  textShooter
//
//  Created by jiaziquan on 15-2-5.
//  Copyright (c) 2015年 TianDiXinDao. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton* button=[[UIButton alloc] initWithFrame:CGRectMake(100, 150, 100, 40)];
    button.backgroundColor=[UIColor blueColor];
    [button setTitle:@"简单小游戏" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPress) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
    NSLog(@"我操了个蛋");
}
- (void)buttonPress
{
    GameViewController* gameVC=[[GameViewController alloc] init];
    [self.navigationController pushViewController:gameVC animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
