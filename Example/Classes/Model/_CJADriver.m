// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CJADriver.m instead.

#import "_CJADriver.h"

const struct CJADriverAttributes CJADriverAttributes = {
	.name = @"name",
};

const struct CJADriverRelationships CJADriverRelationships = {
	.cars = @"cars",
};

const struct CJADriverFetchedProperties CJADriverFetchedProperties = {
};

@implementation CJADriverID
@end

@implementation _CJADriver

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CJADriver" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CJADriver";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CJADriver" inManagedObjectContext:moc_];
}

- (CJADriverID*)objectID {
	return (CJADriverID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic cars;

	
- (NSMutableOrderedSet*)carsSet {
	[self willAccessValueForKey:@"cars"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"cars"];
  
	[self didAccessValueForKey:@"cars"];
	return result;
}
	






@end
