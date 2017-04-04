//
//  ImageLoader.m
//  WebService2
//
//  Created by Naina Sai Tipparti on 4/4/17.
//  Copyright © 2017 Naina Sai Tipparti. All rights reserved.
//

#import "ImageLoader.h"

@implementation ImageLoader

+(id) sharedManager{
    static ImageLoader *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc]init];
    });
    return sharedManager;
}

-(void)imageForUrl:(NSString *)urlString indexPathArg:(NSIndexPath *)NSIndexPath completionHandler:(void (^)(UIImage *, NSString *, NSIndexPath *))completionHandler{
    
    NSCache *imagesCache = [[NSCache alloc]init];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *data = [imagesCache objectForKey:urlString];
        if (data != nil) {
            UIImage *img = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(img,nil,nil);
            });
        }else{
            NSURL *url = [NSURL URLWithString:urlString];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (data != nil){
                    UIImage *tempImg = [UIImage imageWithData:data];
                    [imagesCache setObject:tempImg forKey:urlString];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completionHandler(tempImg,urlString,NSIndexPath);
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completionHandler(nil,urlString,NSIndexPath);
                    });
                }
            }] resume];
        }
    });
    
}

@end
