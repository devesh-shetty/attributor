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
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation ViewController

//After instantiation and outlet setting viewDidLoad is called
//In the entire lifetime of our controller, viewDidLoad will be called only once
//At the time this method is called, the geometry of the view and its bounds is not set, so we don't know whether it's an iPhone or iPad
//So do not initialize things that are geometry-dependent here
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //Create a mutableAttributedString
    NSMutableAttributedString *title = [ [ NSMutableAttributedString alloc]
                                 initWithString: self.outlineButton.currentTitle ];
    
    //A positive value NSStrokeWidthAttributeName (i.e. 3 in this case) indicates we will only color the stroke and not fill it
    [title setAttributes:@{NSStrokeWidthAttributeName: @3,
                           NSStrokeWidthAttributeName: self.outlineButton.tintColor} range:NSMakeRange(0, [title length])];
    
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

//called just before the view appears on screen
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //do not put one time initialisation code over here
    
    //what if user opens the app, and then changes the text size from settings and returns back to the app
    //we won't get that notification
    //hence, to sync up with user settings we make use of this method
    [self usePreferredFonts];
    
    [[NSNotificationCenter defaultCenter] addObserver:self//the object to get notified to
                                             selector:@selector(preferredFontsChanged:)//the method to call
                                                 name:UIContentSizeCategoryDidChangeNotification//name of the station/name of the event we want to observe
                                               object:nil//whose changes you are interested in (nil is anyone's)
     ];
}

- (void)preferredFontsChanged:(NSNotification *) notification{
    [self usePreferredFonts];
}

-(void)usePreferredFonts{
    self.textViewBody.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.labelHeader.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //write cleanup code
    //do not work on time-consuming thing over here to prevent app from becoming sluggish
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
    
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
