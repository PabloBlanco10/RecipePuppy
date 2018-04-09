//
//  RecipePuppy.h
//  RecipePuppy
//
//  Created by Pablo Blanco Peris on 9/4/18.
//  Copyright © 2018 Pablo Blanco Peris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipePuppy : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *ingredients;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *href;

@end
