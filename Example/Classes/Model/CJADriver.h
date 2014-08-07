#import "_CJADriver.h"

@interface CJADriver : _CJADriver {}

- (CJACar *)newCarWithManufacturerName:(NSString *)manufacturer inContext:(NSManagedObjectContext *)context;

@end
