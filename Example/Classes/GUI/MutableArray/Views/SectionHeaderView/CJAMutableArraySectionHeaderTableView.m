//
//  CJAMutableArraySectionHeaderTableView.m
//  CJADataSource
//
//  Created by Bogdan Iusco on 7/2/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAMutableArraySectionHeaderTableView.h"

@implementation CJAMutableArraySectionHeaderTableView

#pragma mark - Property methods

- (void)setSectionIndex:(NSUInteger)sectionIndex {
    _sectionIndex = sectionIndex;
    NSString *text = [NSString stringWithFormat:@"Section %ld", sectionIndex];
    self.sectionLabel.text = text;
}

@end
