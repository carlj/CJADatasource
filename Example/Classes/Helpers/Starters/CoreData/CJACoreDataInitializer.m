//
//  CJACoreDataInitializer.m
//  CJADataSource
//
//  Created by Bogdan Iusco on 8/1/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJACoreDataInitializer.h"
#import "CJADriver.h"
#import "CJACar.h"

@implementation CJACoreDataInitializer

- (void)start {
    
    if ([CJADriver MR_findFirst]) {
        return;
    }

    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];

    // Create drivers
    CJADriver *john = [[self class] driverInContext:defaultContext withName:@"John"];
    CJADriver *peter = [[self class] driverInContext:defaultContext withName:@"Peter"];
    
    // Create cars
    NSArray *drivers = @[john, peter];
    const NSUInteger countCarsPerDriver = 3;
    for (CJADriver *driver in drivers) {
        
        for (NSUInteger index = 0; index < countCarsPerDriver; index++) {
            NSString *manufacturerName = [NSString stringWithFormat:@"Old car %d", index];
            [driver newCarWithManufacturerName:manufacturerName];
        }

    }

    [defaultContext MR_saveToPersistentStoreAndWait];
}

+ (CJADriver *)driverInContext:(NSManagedObjectContext *)context withName:(NSString *)name {
    NSParameterAssert(context);
    NSParameterAssert(name);
    
    CJADriver *driver = [CJADriver insertInManagedObjectContext:context];
    driver.name = name;
    return driver;
}


@end
