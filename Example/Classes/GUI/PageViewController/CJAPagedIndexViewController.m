//
//  CJAPagedIndexViewController.m
//  CJADataSource
//
//  Created by Carl Jahn on 14.08.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAPagedIndexViewController.h"

@interface CJAPagedIndexViewController ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation CJAPagedIndexViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.textLabel];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.textLabel.frame = self.view.bounds;
}

- (void)setIndex:(NSUInteger)index {
    _index = index;

    self.textLabel.text = [NSString stringWithFormat:@"%ld", _index];
}

- (UILabel *)textLabel {

    if (!_textLabel) {
        
        _textLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        _textLabel.font = [UIFont boldSystemFontOfSize:160.0f];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    return _textLabel;
}

@end
