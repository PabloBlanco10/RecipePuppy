//
//  RecipePuppyDetailViewController.h
//  RecipePuppy
//
//  Created by Pablo Blanco Peris on 9/4/18.
//  Copyright © 2018 Pablo Blanco Peris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipePuppy.h"

@interface RecipePuppyDetailViewController : UIViewController
@property (nonatomic) RecipePuppy *objectSelected;
@property (weak, nonatomic) IBOutlet UILabel *ingredientsLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *urlButton;

@end
