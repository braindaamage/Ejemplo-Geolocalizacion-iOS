//
//  ViewController.m
//  pruebaGeolocalizacion
//
//  Created by Leonardo on 17-12-12.
//  Copyright (c) 2012 devTrash. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    self.location = [[CLLocationManager alloc] init];
    
    [self.location setDelegate:self];
    [self.location setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.location setDistanceFilter:kCLDistanceFilterNone];
    [self.location startUpdatingLocation];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    // Se obtiene la última localización
    CLLocation *newLocation = (CLLocation *) [locations lastObject];
    
    // Se imprime latitud
    NSString *lat = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.latitude];
    [self.latitud setText:lat];
    
    // Se imprime longitud;
    NSString *lon = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.longitude];
    [self.longitud setText:lon];
    
    // Se imprime precisión
    NSString *pre = [[NSString alloc]initWithFormat:@"%f", newLocation.horizontalAccuracy];
    [self.precision setText:pre];
    
    // Setea centro en mapa
    MKCoordinateSpan span;
    span.latitudeDelta = .01;
    span.longitudeDelta = .01;
    MKCoordinateRegion region;
    region.center = newLocation.coordinate;
    region.span = span;
    
    [self.mapa setRegion:region animated:YES];
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSString *msg = @"Error al obtener localización";
    
    UIAlertView *alert;
    alert = [[UIAlertView alloc]
            initWithTitle:@"Error"
            message:msg
            delegate:self
            cancelButtonTitle:@"OK"
            otherButtonTitles:nil];
    [alert show];
    
    NSLog(@"%@", [error localizedDescription]);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
