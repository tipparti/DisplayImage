//
//  MyManager.h
//  WebService
//
//  Created by Naina Sai Tipparti on 4/2/17.
//  Copyright © 2017 Naina Sai Tipparti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyManager : NSObject

+ (id)sharedManager;

-(void)getData: (NSString *)url completionHandler:(void (^)(NSDictionary *response))completionHandler;


@end
