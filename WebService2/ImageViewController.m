//
//  ImageViewController.m
//  WebService2
//
//  Created by Naina Sai Tipparti on 4/4/17.
//  Copyright © 2017 Naina Sai Tipparti. All rights reserved.
//

#import "ImageViewController.h"
UIImage *renderImage;

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createImageView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) createImageView{
    CGSize screenSize = [[UIScreen mainScreen]bounds].size;

    UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(0,60,screenSize.width,screenSize.height)];
    dot.image = renderImage;
    [self.view addSubview:dot];
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
