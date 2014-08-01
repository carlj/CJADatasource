//
//  CJAFetchedResultsSectionHeaderTableView.m
//  CJADataSource
//
//  Created by Bogdan Iusco on 8/1/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAFetchedResultsSectionHeaderTableView.h"
#import "CJADriver.h"

@implementation CJAFetchedResultsSectionHeaderTableView

#pragma mark - Property methods

- (void)setDriver:(CJADriver *)driver {
    if ([_driver isEqual:driver]) {
        return;
    }
    _driver = driver;
    self.sectionLabel.text = driver.name;
}

@end
