//
//  NSEntityDescription+MagicalDataImport.m
//  Magical Record
//
//  Created by Saul Mora on 9/5/11.
//  Copyright 2011 Magical Panda Software LLC. All rights reserved.
//

#import "NSEntityDescription+MagicalDataImport.h"
#import "NSManagedObject+MagicalDataImport.h"
#import "NSManagedObject+MagicalRecord.h"
#import "MagicalImportFunctions.h"
#import "MagicalRecordLogging.h"

@implementation NSEntityDescription (MagicalRecord_DataImport)

- (NSArray *) MR_primaryAttributeToRelateBy;
{
    
    NSMutableArray *attributeDescriptions = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        
        NSString *key = i == 0 ? kMagicalRecordImportRelationshipLinkedByKey : [NSString stringWithFormat:@"%@.%d",kMagicalRecordImportRelationshipLinkedByKey,i];
        
        
        NSString *lookupKey = [[self userInfo] objectForKey:key];
        
        if (lookupKey == nil) {
            continue;
        }
        NSAttributeDescription *attributeDescription = [self MR_attributeDescriptionForName:lookupKey];
        
        if (attributeDescription == nil)
        {
            MRLogError(
                       @"Invalid value for key '%@' in '%@' entity. Remove this key or add attribute '%@'\n",
                       kMagicalRecordImportRelationshipLinkedByKey,
                       self.name,
                       lookupKey);
        }
        
        [attributeDescriptions addObject:attributeDescription];

        
    }
   
    return attributeDescriptions;
}

- (NSManagedObject *) MR_createInstanceInContext:(NSManagedObjectContext *)context;
{
    Class relatedClass = NSClassFromString([self managedObjectClassName]);
    NSManagedObject *newInstance = [relatedClass MR_createEntityInContext:context];
   
    return newInstance;
}

- (NSAttributeDescription *) MR_attributeDescriptionForName:(NSString *)name;
{
    __block NSAttributeDescription *attributeDescription;

    NSDictionary *attributesByName = [self attributesByName];

    if ([attributesByName count] == 0) {
        return nil;
    }

    [attributesByName enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key isEqualToString:name]) {
            attributeDescription = obj;

            *stop = YES;
        }
    }];

    return attributeDescription;
}

@end
