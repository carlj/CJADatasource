// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CJADriver.h instead.

#import <CoreData/CoreData.h>


extern const struct CJADriverAttributes {
	__unsafe_unretained NSString *name;
} CJADriverAttributes;

extern const struct CJADriverRelationships {
	__unsafe_unretained NSString *cars;
} CJADriverRelationships;

extern const struct CJADriverFetchedProperties {
} CJADriverFetchedProperties;

@class CJACar;



@interface CJADriverID : NSManagedObjectID {}
@end

@interface _CJADriver : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CJADriverID*)objectID;




@property (nonatomic, strong) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSOrderedSet* cars;

- (NSMutableOrderedSet*)carsSet;





@end

@interface _CJADriver (CoreDataGeneratedAccessors)

- (void)addCars:(NSOrderedSet*)value_;
- (void)removeCars:(NSOrderedSet*)value_;
- (void)addCarsObject:(CJACar*)value_;
- (void)removeCarsObject:(CJACar*)value_;

@end

@interface _CJADriver (CoreDataGeneratedPrimitiveAccessors)


- (NSString *)primitiveName;
- (void)setPrimitiveName:(NSString *)value;





- (NSMutableOrderedSet*)primitiveCars;
- (void)setPrimitiveCars:(NSMutableOrderedSet*)value;


@end
