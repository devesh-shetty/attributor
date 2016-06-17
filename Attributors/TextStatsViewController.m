//
//  TextStatsViewController.m
//  Attributors
//
//  Created by Devesh Shetty on 16/06/16.
//  Copyright © 2016 Devesh Shetty. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"test"
                                                         attributes:@{NSForegroundColorAttributeName: [UIColor greenColor],
                                                                                         NSStrokeWidthAttributeName: @-3}];

}

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze{
    
    _textToAnalyze = textToAnalyze;
    
    //self.view.window will be null if this view is not on-screen
    //self.view.window = null indicates outlet have not been set
    //hence in viewWillAppear we try to update the UI
    if(self.view.window){
        //update the UI if I am on-screen
        [self updateUI];
    }
}

- (void)updateUI{
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%lu colorful characters",[[self charactersWithAttribute:NSForegroundColorAttributeName] length] ];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%lu outlined characters",[[self charactersWithAttribute:NSStrokeWidthAttributeName] length] ];
    
}

- (NSAttributedString *)charactersWithAttribute: (NSString *)attributeName{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while(index < [self.textToAnalyze length]){
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        
        if(value){
            //value is not nill
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            //update the index location to range.location + range.length because
            //attributes in (range.location to range.location + range.length) have already been analyzed; no need to analyze them again
            index = range.location + range.length;
        }else{
            //check the next character
            index++;
        }
    }
    
    return characters;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //update the UI when the view is about to appear
    [self updateUI];
}

@end
