//
//  ViewController.h
//  Player
//
//  Created by administrator on 12-9-5.
//  Copyright (c) 2012年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "LevelMeterView.h"
@interface ViewController : UIViewController<AVAudioPlayerDelegate>{
    float ballRadius;
    CGPoint delta;
    NSTimer *timer;
}
@property (strong, nonatomic) IBOutlet UIImageView *_image1;

@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic, retain) NSMutableString *str;
@property (strong, nonatomic) IBOutlet UILabel *totalTime;
@property (strong, nonatomic) IBOutlet UIProgressView *progress;
@property (strong, nonatomic) IBOutlet UIButton *playOrpause;
@property (strong, nonatomic) IBOutlet LevelMeterView *leftMeter;
@property (strong, nonatomic) IBOutlet LevelMeterView *rightMeter;
@property (strong, nonatomic) IBOutlet UISlider *volume;
@property (strong, nonatomic) IBOutlet UILabel *durationLable;
-(IBAction)palyOrpause;
-(IBAction)setVolume;
@property (strong, nonatomic) IBOutlet UIButton *plays;

- (IBAction)play;

@property (strong, nonatomic) IBOutlet UIImageView *_image;


@end
