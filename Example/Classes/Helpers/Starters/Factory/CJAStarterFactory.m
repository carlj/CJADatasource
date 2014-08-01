//
//  CJAStarterFactory.m
//  CJADataSource
//
//  Created by Bogdan Iusco on 8/1/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAStarterFactory.h"

@interface CJAStarterFactory ()

@property (nonatomic, strong) NSMutableArray *starters;

@end


@implementation CJAStarterFactory

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.starters = [NSMutableArray array];
    }
    return self;
}

- (void)addStarterClass:(Class<CJAStarter>)class {
    
    NSParameterAssert(class);
    
    NSString *classString = NSStringFromClass(class);
    
    [self.starters addObject: classString];
}


- (void)run {
    
    [self runWithClassArray: [self.starters copy] ];
}

- (void)runWithClassArray:(NSArray *)classes {
    
    NSParameterAssert(classes);
    
    for (NSString *classString in classes) {
        
        Class c = NSClassFromString(classString);
        
        NSObject<CJAStarter> *i = [c new];
        [i start];
        
    }
}

@end
