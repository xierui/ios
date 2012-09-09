//
//  ViewController.m
//  Player
//
//  Created by administrator on 12-9-5.
//  Copyright (c) 2012年 administrator. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize _image1;
@synthesize _image;
@synthesize totalTime;
@synthesize progress;
@synthesize playOrpause;
@synthesize leftMeter;
@synthesize rightMeter;
@synthesize volume;

@synthesize durationLable;
-(NSString*)timeToString:(int)time{
    return [NSString stringWithFormat:@"%02d:%02d",time / 60,time % 60];
}
-(IBAction)palyOrpause{
    UIImage *q1 = [UIImage imageNamed:[NSString stringWithFormat:@"%@1.jpg",self.str]];
	UIImage *q2 = [UIImage imageNamed:[NSString stringWithFormat:@"%@2.jpg",self.str]];
	UIImage *q3 = [UIImage imageNamed:[NSString stringWithFormat:@"%@3.jpg",self.str]];
	UIImage *q4 = [UIImage imageNamed:[NSString stringWithFormat:@"%@4.jpg",self.str]];

	self._image.animationDuration = 2.5;
    NSArray *a = [NSArray arrayWithObjects: q1, q2,
                  q3, q4, nil];
     
    if (self.player.playing) {
        [self.playOrpause setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [self.player pause];
        self._image.animationImages = nil;
    }else{
        [self.playOrpause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [self.player play];
        self._image.animationImages = a;
        [self._image startAnimating];
    }
}
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if (flag) {
        [self.playOrpause setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
}
-(IBAction)setVolume{
    self.player.volume = self.volume.value;
}
-(IBAction)handleStop
{
     [self._image stopAnimating];
    [self.player stop];
}
- (IBAction)play {
    
    self._image1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@q.png",self.str]];
    ballRadius = _image1.bounds.size.width / 2;
    
    delta = CGPointMake(2.0,1.3);
    timer = [NSTimer scheduledTimerWithTimeInterval:.02
                                             target:self
                                           selector:@selector(onTimer)
                                           userInfo:nil
                                            repeats:YES];
    

    
    UIImage *q1 = [UIImage imageNamed:[NSString stringWithFormat:@"%@1.jpg",self.str]];
	UIImage *q2 = [UIImage imageNamed:[NSString stringWithFormat:@"%@2.jpg",self.str]];
	UIImage *q3 = [UIImage imageNamed:[NSString stringWithFormat:@"%@3.jpg",self.str]];
	UIImage *q4 = [UIImage imageNamed:[NSString stringWithFormat:@"%@4.jpg",self.str]];
	
    self._image.animationDuration = 2.5;
    
    NSArray *q = [NSArray arrayWithObjects: q1, q2,
                  q3, q4, nil];
    	self._image.animationImages = q;
	[self._image startAnimating];
//     self._image.alpha = 0;
//    [NSTimer scheduledTimerWithTimeInterval:13 target:self selector:@selector(handleStop) userInfo:nil repeats:NO];
  
//    self._image.image = [UIImage imageNamed:[NSString stringWithFormat:@"q%@.jpg",self.str]];
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",self.str] ofType:@"mp3"];
    NSLog(@"---%@",path);
    if (path == nil) {
        path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"q"] ofType:@"mp3"];
        UIImage *q1 = [UIImage imageNamed:@"q1.jpg"];
        UIImage *q2 = [UIImage imageNamed:@"q2.jpg"];
        UIImage *q3 = [UIImage imageNamed:@"q3.jpg"];
        UIImage *q4 = [UIImage imageNamed:@"q4.jpg"];
        self._image.animationDuration = 2.5;
        NSArray *q = [NSArray arrayWithObjects: q1, q2,
                      q3, q4, nil];
    	self._image.animationImages = q;
        [self._image startAnimating];
         }
    NSURL *url = [[NSURL alloc]initFileURLWithPath:path];
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [self.player setDelegate:self];
    self.player.volume = .5;
    //    self.volume.value=0.5f;
    self.player.meteringEnabled = YES;
   self.volume.value = self.player.volume;
    self.totalTime.text = @"0:00";

    self.durationLable.text = [self timeToString:self.player.duration];
    [self updateDisplay];
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(updateDisplay) userInfo:nil repeats:YES];

    if (self.player.playing) {
        [self.player stop];
        [self.player play];
    }else{
        [self.player play];
    }

    
    
}
-(void)updateDisplay{
    self.progress.progress = self.player.currentTime/self.player.duration;
    self.totalTime.text = [self timeToString:self.player.currentTime];
    [self.player updateMeters];
    [self.leftMeter setPower:[self.player averagePowerForChannel:0] peak:[self.player peakPowerForChannel:0]];
    [self.rightMeter setPower:[self.player averagePowerForChannel:1] peak:[self.player peakPowerForChannel:1]];
}





- (void)viewDidLoad
{
    [super viewDidLoad];
     self.title = @"音乐播放器";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"list" style:UIBarButtonItemStyleBordered target:self action:@selector(display)];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"pause" style:UIBarButtonItemStyleBordered target:self action:@selector(handleStop)];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"mp3"];
//    MenuViewController *menu = [[MenuViewController alloc]init];
//    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",menu.str] ofType:@"mp3"];
//    NSURL *url = [[NSURL alloc]initFileURLWithPath:path];
//    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
//    self.player = [[AVAudioPlayer alloc]init];
    [self.player prepareToPlay];
      

  	// Do any additional setup after loading the view, typically from a nib.
}
-(void) onTimer {
    //    NSLog(@"---%f",_image.center.x);
    self._image1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@q.png",self.str]];

    _image1.center = CGPointMake(_image1.center.x + delta.x,
                                _image1.center.y + delta.y);
    
    if (_image1.center.x > self.view.bounds.size.width - ballRadius || _image1.center.x < ballRadius)
        delta.x = -delta.x;
    if (_image1.center.y > self.view.bounds.size.height - ballRadius || _image1.center.y < ballRadius )
        delta.y = -delta.y;
}

-(IBAction)display{
    MenuViewController *menu = [[MenuViewController alloc]initWithStyle:UITableViewStylePlain];
//    menu.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController pushViewController:menu animated:YES];
}

- (void)viewDidUnload
{
   
    [self setTotalTime:nil];
    [self setProgress:nil];
    [self setPlayOrpause:nil];
    [self setLeftMeter:nil];
    [self setRightMeter:nil];
    [self setVolume:nil];
    [self setDurationLable:nil];
    [self set_image:nil];

    [self set_image1:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
