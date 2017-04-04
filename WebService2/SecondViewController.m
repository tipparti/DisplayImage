//
//  SecondViewController.m
//  WebService
//
//  Created by Naina Sai Tipparti on 4/1/17.
//  Copyright © 2017 Naina Sai Tipparti. All rights reserved.
//

#import "SecondViewController.h"
NSDictionary *myDict;


@interface SecondViewController (){
    NSString *imageURL;
    NSMutableArray *imgURLs;
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTable];
    imgURLs = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createTable {
    CGSize screenSize = [[UIScreen mainScreen]bounds].size;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, screenSize.width, screenSize.height) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[myDict objectForKey:@"jobs"] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    tableCell == nil ? tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] : NSLog(@"Cell Resuing");
    
    NSArray *extractData = [myDict objectForKey:@"jobs"];
    NSMutableDictionary *eachObject = [[NSMutableDictionary alloc]init];
    NSMutableArray *names = [[NSMutableArray alloc]init];
    
    for (NSDictionary *eachDict in extractData) {
        [eachObject addEntriesFromDictionary:eachDict];
        [names addObject:[eachObject objectForKey:@"Name"]];
        [imgURLs addObject:[eachObject objectForKey:@"Image"]];
    }
    
    tableCell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row + 1];

    return tableCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    imageURL = imgURLs[indexPath.row];
    if (imageURL != nil){
    [[ImageLoader sharedManager] imageForUrl:imageURL indexPathArg:indexPath completionHandler:^(UIImage *image, NSString *url, NSIndexPath *indexPath) {
        
        renderImage = image;
        dispatch_async(dispatch_get_main_queue(), ^{
            if(renderImage != nil){
                UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                
                ImageViewController *imageVC = [storyBoard instantiateViewControllerWithIdentifier:@"ImageViewController"];
                
                [self.navigationController pushViewController:imageVC animated:YES];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Image Not Recevied" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *accept = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alert addAction:accept];
                [self presentViewController:alert animated:YES completion:^{
                }];
                
            }
        });
    }];}else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Image Not Recevied" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *accept = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:accept];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }
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
