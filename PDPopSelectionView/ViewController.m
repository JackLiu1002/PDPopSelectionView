//
//  ViewController.m
//  PDPopSelectionView
//
//  Created by Jack on 16/6/10.
//  Copyright © 2016年 jpanda. All rights reserved.
//

#import "ViewController.h"
#import "PDPopSelectionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x-40, 150, 80, 40)];
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitle:@"show" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}

- (void)clicked
{
    NSArray *dataSource = @[@"北京",@"上海",@"广州",@"深圳"];
    PDPopSelectionView *selectView = [[PDPopSelectionView alloc]initWithTitle:@"选择" selections:dataSource];
    selectView.selectionHandle = ^(NSInteger selectedIndex) {
        NSLog(@"selectedIndex:%li",selectedIndex);
    };
    [selectView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
