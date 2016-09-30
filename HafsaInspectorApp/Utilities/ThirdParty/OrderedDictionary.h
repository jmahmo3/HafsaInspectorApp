//
//  OrderedDictionary.h
//  ACGDeals
//
//  Created by Sameer Siddiqui on 1/25/16.
//  Copyright © 2016 KeyLimeTie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderedDictionary : NSMutableDictionary
{
    NSMutableDictionary *dictionary;
    NSMutableArray *array;
}

- (void)insertObject:(id)anObject forKey:(id)aKey atIndex:(NSUInteger)anIndex;
- (id)keyAtIndex:(NSUInteger)anIndex;
- (NSEnumerator *)reverseKeyEnumerator;

@end
