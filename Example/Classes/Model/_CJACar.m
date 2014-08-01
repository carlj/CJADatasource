// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CJACar.m instead.

#import "_CJACar.h"

const struct CJACarAttributes CJACarAttributes = {
	.manufacturer = @"manufacturer",
};

const struct CJACarRelationships CJACarRelationships = {
	.driver = @"driver",
};

const struct CJACarFetchedProperties CJACarFetchedProperties = {
};

@implementation CJACarID
@end

@implementation _CJACar

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CJACar" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CJACar";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CJACar" inManagedObjectContext:moc_];
}

- (CJACarID*)objectID {
	return (CJACarID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic manufacturer;






@dynamic driver;

	






@end
