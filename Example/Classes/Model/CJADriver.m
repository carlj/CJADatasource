#import "CJADriver.h"
#import "CJACar.h"

@implementation CJADriver

- (CJACar *)newCarWithManufacturerName:(NSString *)manufacturer inContext:(NSManagedObjectContext *)context {
    NSParameterAssert(manufacturer);
    NSParameterAssert(context);

    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    CJACar *car = [CJACar insertInManagedObjectContext:defaultContext];
    car.manufacturer = manufacturer;
    car.driver = self;
    car.created = [NSDate date];
    
    return car;
}


@end
