//
//  MyManager.m
//  WebService
//
//  Created by Naina Sai Tipparti on 4/2/17.
//  Copyright © 2017 Naina Sai Tipparti. All rights reserved.
//

#import "MyManager.h"

@implementation MyManager

+(id) sharedManager{
    static MyManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc]init];
    });
    return sharedManager;
}

-(void)getData: (NSString *)urlString completionHandler:(void (^)(NSDictionary *response))completionHandler{
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
   [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
       if(error == nil){
           NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
           completionHandler(responseData);
       }
       
   }] resume];
    
}


@end
