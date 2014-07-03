//
//  CJAMutableArraySectionHeaderTableView.m
//  CJADataSource
//
//  Created by Bogdan Iusco on 7/2/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAMutableArraySectionHeaderTableView.h"

@interface CJAMutableArraySectionHeaderTableView ()

@property (nonatomic, strong, readwrite) UIButton *addCellButton;
@property (nonatomic, strong, readwrite) UIButton *deleteCellButton;
@property (nonatomic, strong, readwrite) UILabel *sectionLabel;

@end


@implementation CJAMutableArraySectionHeaderTableView

#pragma mark - UIView methods

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.addCellButton];
        [self.contentView addSubview:self.deleteCellButton];
        [self.contentView addSubview:self.sectionLabel];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - Property methods

- (UIButton *)addCellButton {
    if (!_addCellButton) {
        _addCellButton = [[self class] createButtonWithText:@"+"];
        _addCellButton.tintColor = [UIColor greenColor];
    }
    return _addCellButton;
}

- (UIButton *)deleteCellButton {
    if (!_deleteCellButton) {
        _deleteCellButton = [[self class] createButtonWithText:@"-"];
        _deleteCellButton.tintColor = [UIColor redColor];
    }
    return _deleteCellButton;
}

- (UILabel *)sectionLabel {
    if (!_sectionLabel) {
        _sectionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _sectionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _sectionLabel.textAlignment = NSTextAlignmentCenter;
        _sectionLabel.font =[UIFont boldSystemFontOfSize:18.0];
    }
    return _sectionLabel;
}

- (void)setSectionIndex:(NSUInteger)sectionIndex {
    _sectionIndex = sectionIndex;
    NSString *text = [NSString stringWithFormat:@"Section %ld", sectionIndex];
    self.sectionLabel.text = text;
}

#pragma mark - Autolayout methods

- (void)setupConstraints {
    [self setupConstraintsAddButton];
    [self setupConstraintsDeleteButton];
    [self setupConstraintsSectionLabel];
}

- (void)setupConstraintsAddButton {
    id addButton = self.addCellButton;
    NSDictionary *views = NSDictionaryOfVariableBindings(addButton);
    NSDictionary *metrics = @{@"space" : @(10),
                              @"width" : @(30)};
    NSArray *constraints;
    NSLayoutConstraint *constraint;

    // Center view on y axis
    constraint = [NSLayoutConstraint constraintWithItem:addButton
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self
                                              attribute:NSLayoutAttributeCenterY
                                             multiplier:1.0
                                               constant:0.0];
    [self addConstraint:constraint];

    // Set height be equal to width
    constraint = [NSLayoutConstraint constraintWithItem:addButton
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:addButton
                                              attribute:NSLayoutAttributeWidth
                                             multiplier:1.0
                                               constant:0.0];
    [self addConstraint:constraint];

    // Position view on x axis
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(space)-[addButton(==width)]"
                                                          options:0
                                                          metrics:metrics
                                                            views:views];
    [self addConstraints:constraints];
}

- (void)setupConstraintsDeleteButton {
    id deleteButton = self.deleteCellButton;
    NSDictionary *views = NSDictionaryOfVariableBindings(deleteButton);
    NSDictionary *metrics = @{@"space" : @(10),
                              @"width" : @(30)};
    NSArray *constraints;
    NSLayoutConstraint *constraint;
    
    // Center view on y axis
    constraint = [NSLayoutConstraint constraintWithItem:deleteButton
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self
                                              attribute:NSLayoutAttributeCenterY
                                             multiplier:1.0
                                               constant:0.0];
    [self addConstraint:constraint];

    // Set height be equal to width
    constraint = [NSLayoutConstraint constraintWithItem:deleteButton
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:deleteButton
                                              attribute:NSLayoutAttributeWidth
                                             multiplier:1.0
                                               constant:0.0];
    [self addConstraint:constraint];

    // Position view on x axis
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[deleteButton(==width)]-(space)-|"
                                                          options:0
                                                          metrics:metrics
                                                            views:views];
    [self addConstraints:constraints];
}

- (void)setupConstraintsSectionLabel {
    id label = self.sectionLabel;
    id deleteButton = self.deleteCellButton;
    id addButton = self.addCellButton;
    NSDictionary *views = NSDictionaryOfVariableBindings(label, addButton, deleteButton);
    NSArray *constraints;
    NSLayoutConstraint *constraint;
    
    // Center view on y axis
    constraint = [NSLayoutConstraint constraintWithItem:deleteButton
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self
                                              attribute:NSLayoutAttributeCenterY
                                             multiplier:1.0
                                               constant:0.0];
    [self addConstraint:constraint];
    
    // Position view on x axis
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[addButton]-[label]-[deleteButton]"
                                                          options:0
                                                          metrics:nil
                                                            views:views];
    [self addConstraints:constraints];

    // Position view on x axis
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|"
                                                          options:0
                                                          metrics:nil
                                                            views:views];
    [self addConstraints:constraints];
    
}

#pragma mark - Helper methods

+ (UIButton *)createButtonWithText:(NSString *)text {
    NSParameterAssert(text.length);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:text forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    return button;
}

@end
