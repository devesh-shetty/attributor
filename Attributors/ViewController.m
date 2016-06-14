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

//After instantiation and outlet setting viewDidLoad is called
//In the entire lifetime of our controller, viewDidLoad will be called only once
//At the time this method is called, the geometry of the view and its bounds is not set, so we don't know whether it's an iPhone or iPad
//So do not initialize things that are geometry-dependent here
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

//called just before the view appears on screen
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //do not put one time initialisation code over here
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //write cleanup code
    //do not work on time-consuming thing over here to prevent app from becoming sluggish
    
    
}


- (void)viewWillLayoutSubviews{
    //viewWillLayoutSubviews and viewDidLayoutSubviews called anytime a sub-views changed and its sub-views were thus re-layed out
    //for example; autorotation
    [super viewWillLayoutSubviews];
}
//AutoLayout happens between viewWillLayoutSubviews and viewDidLayoutSubviews

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)changeSelectedTextToButtonColor:(UIButton *)sender{
    //making use NSAttributedString
    //changing the color of the selected text to button touched by the user
    [self.textViewBody.textStorage addAttribute: NSForegroundColorAttributeName
                                          value:sender.backgroundColor
                                          range:self.textViewBody.selectedRange];
    
}

- (IBAction)outlineBodySelection {
    //To do the outline, we need to set the stroke width and stroke color
    //so we add more than one NSAttributed properties
    //NSStrokeWidthAttributeName with a negative value suggests that it will not color the stroke but also fill it
    [ self.textViewBody.textStorage addAttributes: @{NSStrokeWidthAttributeName: @-3,
                                                    NSStrokeWidthAttributeName: [UIColor blackColor]}
                                            range: self.textViewBody.selectedRange];
}

- (IBAction)unoutlineBodySelection {
    //remove stroke
    [self.textViewBody.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.textViewBody.selectedRange];
    
    
}

@end
