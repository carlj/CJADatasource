// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CJACar.h instead.

#import <CoreData/CoreData.h>


extern const struct CJACarAttributes {
	__unsafe_unretained NSString *manufacturer;
} CJACarAttributes;

extern const struct CJACarRelationships {
	__unsafe_unretained NSString *driver;
} CJACarRelationships;

extern const struct CJACarFetchedProperties {
} CJACarFetchedProperties;

@class CJADriver;



@interface CJACarID : NSManagedObjectID {}
@end

@interface _CJACar : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CJACarID*)objectID;




@property (nonatomic, strong) NSString *manufacturer;


//- (BOOL)validateManufacturer:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) CJADriver* driver;

//- (BOOL)validateDriver:(id*)value_ error:(NSError**)error_;





@end

@interface _CJACar (CoreDataGeneratedAccessors)

@end

@interface _CJACar (CoreDataGeneratedPrimitiveAccessors)


- (NSString *)primitiveManufacturer;
- (void)setPrimitiveManufacturer:(NSString *)value;





- (CJADriver*)primitiveDriver;
- (void)setPrimitiveDriver:(CJADriver*)value;


@end
