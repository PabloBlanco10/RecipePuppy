//
//  RecipePuppyDetailViewController.m
//  RecipePuppy
//
//  Created by Pablo Blanco Peris on 9/4/18.
//  Copyright © 2018 Pablo Blanco Peris. All rights reserved.
//

#import "RecipePuppyDetailViewController.h"

@interface RecipePuppyDetailViewController ()

@end

@implementation RecipePuppyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) configureView{
    self.titleLabel.text = self.objectSelected.title;
    self.ingredientsLabel.text = self.objectSelected.ingredients.description;
    [self.urlButton setTitle:self.objectSelected.href forState:UIControlStateNormal];
    [self.urlButton addTarget:self action:@selector(openBrowser:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) openBrowser:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.objectSelected.href] options:@{} completionHandler:nil];
}

@end
