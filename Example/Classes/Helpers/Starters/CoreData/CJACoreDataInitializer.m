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
    
    // Create cars
    NSArray *drivers = @[john];
    const NSUInteger countCarsPerDriver = 3;
    for (CJADriver *driver in drivers) {
        
        NSMutableOrderedSet *newCars = [[NSMutableOrderedSet alloc] init];
        for (NSUInteger index = 0; index < countCarsPerDriver; index++) {
            NSString *manufacturerName = [NSString stringWithFormat:@"Old car %ld", (long)index];
            CJACar *car = [driver newCarWithManufacturerName:manufacturerName inContext: defaultContext];
            
            [newCars addObject: car];
            
            //[driver addCarsObject: car];
        }
        
        driver.cars = newCars;

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
