//
//  NSRelationshipDescription+MagicalDataImport.m
//  Magical Record
//
//  Created by Saul Mora on 9/4/11.
//  Copyright 2011 Magical Panda Software LLC. All rights reserved.
//

#import "NSRelationshipDescription+MagicalDataImport.h"
#import "NSManagedObject+MagicalDataImport.h"
#import "MagicalImportFunctions.h"

@implementation NSRelationshipDescription (MagicalRecord_DataImport)

- (NSString *) MR_primaryKey;
{
    return [[self userInfo] objectForKey:kMagicalRecordImportRelationshipLinkedByKey];
}

@end
