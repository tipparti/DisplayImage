//
//  ImageLoader.h
//  WebService2
//
//  Created by Naina Sai Tipparti on 4/4/17.
//  Copyright © 2017 Naina Sai Tipparti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface ImageLoader : NSObject

+ (id)sharedManager;

-(void) imageForUrl:(NSString *)urlString indexPathArg:(NSIndexPath *)NSIndexPath completionHandler:(void (^)(
                                                                UIImage* image, NSString *url, NSIndexPath *indexPath))completionHandler;
@end
