//
//  ViewController.m
//  WebService
//
//  Created by Naina Sai Tipparti on 4/1/17.
//  Copyright © 2017 Naina Sai Tipparti. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadData:(id)sender {
    
    NSString *urlString = [NSString stringWithFormat:@"http://35.160.251.153:8081/Services/getMasters?type=%@&mallId=%@",@"macidinfo",@"2"];
    
    NSLog(@"%@",urlString);
  
    [[MyManager sharedManager] getData:urlString completionHandler:^(NSDictionary *response) {
        
         myDict = response;
        NSLog(@"%@",myDict);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // make some UI changes // ... // show actionSheet for example
    if ([myDict count] > 0) {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        SecondViewController *tableVC = [storyBoard instantiateViewControllerWithIdentifier:@"SecondViewController"];
        
        [self.navigationController pushViewController:tableVC animated:YES];
        
    } else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Data Not Recevied" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *accept = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        }];
        
        [alert addAction:accept];
        [self presentViewController:alert animated:YES completion:^{
        }];
        
    }
        });
    }];
    
}

@end
