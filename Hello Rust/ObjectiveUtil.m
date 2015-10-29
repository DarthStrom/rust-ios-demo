#import "ObjectiveUtil.h"

@implementation ObjectiveUtil

+ (double)dotProduct:(NSArray*)vector1 vector2:(NSArray*)vector2 {
    
    double __block sum = 0;
    
    [vector1 enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        double first = [object doubleValue];
        double second = [[vector2 objectAtIndex:index] doubleValue];
        sum += first * second;
    }];
    
    return sum;
}

@end
