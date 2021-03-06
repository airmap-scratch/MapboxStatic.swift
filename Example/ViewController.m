#import "ViewController.h"

@import CoreLocation;
@import MapboxStatic;

// You can also specify the access token with the `MGLMapboxAccessToken` key in Info.plist.
static NSString * const AccessToken = @"pk.eyJ1IjoianVzdGluIiwiYSI6IlpDbUJLSUEifQ.4mG8vhelFMju6HpIY-Hi5A";

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.imageView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    MBSnapshotOptions *options = [[MBSnapshotOptions alloc] initWithMapIdentifiers:@[@"justin.tm2-basemap"]
                                                                  centerCoordinate:CLLocationCoordinate2DMake(45, -122)
                                                                         zoomLevel:6
                                                                              size:self.imageView.bounds.size];
    CLLocationCoordinate2D coords[] = {
        CLLocationCoordinate2DMake(45, -122),
        CLLocationCoordinate2DMake(45, -124),
    };
    MBPath *path = [[MBPath alloc] initWithCoordinates:coords count:sizeof(coords) / sizeof(coords[0])];
    options.overlays = @[path];
    MBSnapshot *snapshot = [[MBSnapshot alloc] initWithOptions:options accessToken:AccessToken];
    __weak typeof(self) weakSelf = self;
    [snapshot imageWithCompletionHandler:^(UIImage * _Nullable image, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.imageView.image = image;
    }];
}

@end
