//
//  ViewController.m
//  Attributors
//
//  Created by Devesh Shetty on 13/06/16.
//  Copyright © 2016 Devesh Shetty. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textViewBody;
@property (weak, nonatomic) IBOutlet UILabel *labelHeader;

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

-(IBAction)changeSelectedTextToButtonColor:(UIButton *)sender{
    
    //changing the color of the selected text to button touched by the user
    [self.textViewBody.textStorage addAttribute: NSForegroundColorAttributeName
                                          value:sender.backgroundColor
                                          range:self.textViewBody.selectedRange];
    
}



@end
