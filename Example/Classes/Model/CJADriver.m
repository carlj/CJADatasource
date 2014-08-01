#import "CJADriver.h"
#import "CJACar.h"

@implementation CJADriver

- (CJACar *)newCarWithManufacturerName:(NSString *)manufacturer {
    NSParameterAssert(manufacturer);

    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    CJACar *car = [CJACar insertInManagedObjectContext:defaultContext];
    car.manufacturer = manufacturer;
    car.driver = self;

    NSMutableOrderedSet *allCars = [NSMutableOrderedSet orderedSetWithOrderedSet:self.cars];
    [allCars addObject:car];
    self.cars = allCars;

    return car;
}


@end
