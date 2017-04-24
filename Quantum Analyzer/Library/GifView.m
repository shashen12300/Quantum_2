//
//  GifView.m
//  GIFViewer
//
//  Created by xToucher04 on 11-11-9.
//  Copyright 2011 Toucher. All rights reserved.
//

#import "GifView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GifView


- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath{
    
    self = [super initWithFrame:frame];
    if (self) {
        
		gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
													 forKey:(NSString *)kCGImagePropertyGIFDictionary] ;
		gif = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:_filePath], (CFDictionaryRef)gifProperties);
		count =CGImageSourceGetCount(gif);
		timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(plays) userInfo:nil repeats:YES];
	//	[timer fire];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame data:(NSData *)_data{
    
    self = [super initWithFrame:frame];
    if (self) {
        
		gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
													 forKey:(NSString *)kCGImagePropertyGIFDictionary] ;
        //		gif = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:_filePath], (CFDictionaryRef)gifProperties);
        gif = CGImageSourceCreateWithData((CFDataRef)_data, (CFDictionaryRef)gifProperties);
		count =CGImageSourceGetCount(gif);
		timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(plays) userInfo:nil repeats:YES];
		[timer fire];
    }
    return self;
}

-(void)plays
{
	index ++;
	index = index%count;
	CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
	self.layer.contents = (__bridge id)(ref);
    CFRelease(ref);
}

-(void)play
{
    [timer setFireDate:[NSDate distantPast]];

}

- (void)stop
{
    CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, 0, (CFDictionaryRef)gifProperties);
    self.layer.contents = (__bridge id)(ref);
    CFRelease(ref);
[timer setFireDate:[NSDate distantFuture]];
}

- (void)pause
{
    CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
    self.layer.contents = (__bridge id)(ref);
    CFRelease(ref);
    [timer setFireDate:[NSDate distantFuture]];
}

- (void)start
{

    CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, 0, (CFDictionaryRef)gifProperties);
    self.layer.contents = (__bridge id)(ref);
    CFRelease(ref);
    [timer setFireDate:[NSDate distantPast]];

}
-(void)removeFromSuperview
{
	NSLog(@"removeFromSuperview");
	[timer invalidate];
	timer = nil;
	[super removeFromSuperview];
}
//- (void)dealloc {
//    NSLog(@"dealloc");
//	CFRelease(gif);
//	[gifProperties release];
//    [super dealloc];
//}
@end
