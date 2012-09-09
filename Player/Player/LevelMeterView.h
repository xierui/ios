//
//  LevelMeterView.h
//  SimpleAudioPlayer
//
//  Created by Chris Adamson on 12/23/08.
//  Copyright 2008 Subsequently and Furthermore, Inc.. All rights reserved.
//
//
//  Licensed with the Apache 2.0 License
//  http://apache.org/licenses/LICENSE-2.0
//


#import <UIKit/UIKit.h>

@interface LevelMeterView : UIView {
	float power;
	float peak;
	CGColorRef levelColor;
	CGColorRef peakColor;
	CGRect levelRect;
	CGRect peakRect;
}
- (void) setPower: (float) pow peak: (float) pk;
@end
