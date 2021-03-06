//
//  LevelMeterView.m
//  SimpleAudioPlayer
//
//  Created by Chris Adamson on 12/23/08.
//  Copyright 2008 Subsequently and Furthermore, Inc.. All rights reserved.
//
//
//  Licensed with the Apache 2.0 License
//  http://apache.org/licenses/LICENSE-2.0
//


#import "LevelMeterView.h"

@implementation LevelMeterView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (id) initWithCoder: (NSCoder*) decoder {
	if (self = [super initWithCoder: decoder]) {
		// Iniitialization code
		levelColor = [UIColor blueColor].CGColor;
		levelRect.origin.x=0;
		levelRect.origin.y=0;
		peakColor = [UIColor redColor].CGColor;
		peakRect.size.width=2;
		peakRect.origin.y = 0;
	}
	return self;
}


-(void) setPower: (float) pow peak: (float) pk {
	power = pow;
	peak = pk;
	// request redraw
	[self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
	// Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext();

	// erase view
	CGColorRef undrawColor = self.backgroundColor.CGColor;
	CGContextSetFillColorWithColor (context, undrawColor);
	CGContextFillRect (context, rect);
	
	// figure out how far to draw
	levelRect.size.height = rect.size.height;
	levelRect.size.width = pow (10, (0.05 * power)) * rect.size.width; //<label id="code.SimpleAudioPlayer.LevelMeterView.drawrect.levelrectwidth"/>
	
	// fill with color
	CGContextSetFillColorWithColor(context, levelColor);
	CGContextFillRect(context, levelRect);
	
	// draw peak as 2-pixel wide bar
	CGContextSetFillColorWithColor(context, peakColor);
	peakRect.size.height = rect.size.height;
	peakRect.origin.x = pow (10, (0.05 * peak)) * rect.size.width; //<label id="code.SimpleAudioPlayer.LevelMeterView.drawrect.peakrectorigin"/>
	if (peakRect.origin.x >= (rect.size.width - 2))
		peakRect.origin.x = rect.size.width - 2;
	CGContextFillRect(context, peakRect);
}


@end
