//
//  ViewController.h
//  pruebaGeolocalizacion
//
//  Created by Leonardo on 17-12-12.
//  Copyright (c) 2012 devTrash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *precision;
@property (weak, nonatomic) IBOutlet UITextField *longitud;
@property (weak, nonatomic) IBOutlet UITextField *latitud;
@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property (strong, nonatomic) CLLocationManager *location;

@end
