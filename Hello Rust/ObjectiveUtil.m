#import "ObjectiveUtil.h"

@implementation ObjectiveUtil

+ (double)dotProduct:(NSArray*)vector1 vector2:(NSArray*)vector2 {
    
    double __block sum = 0;
    NSEnumerator *v2enumerator = [vector2 objectEnumerator];
    
    [vector1 enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        double first = [object doubleValue];
        double second = [[v2enumerator nextObject] doubleValue];
        sum += first * second;
    }];
    
    return sum;
}

@end
