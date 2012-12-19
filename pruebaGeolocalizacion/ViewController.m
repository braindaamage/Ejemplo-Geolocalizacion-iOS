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
    
    // Setea delegado Mapa
    [self.mapa setDelegate:self];
    
    // Instancia location
    self.location = [[CLLocationManager alloc] init];
    
    // Setea Location
    [self.location setDelegate:self];
    [self.location setDesiredAccuracy:kCLLocationAccuracyBest];
    // Setea Filtro de distancia a 10 metros
    [self.location setDistanceFilter: 10.0f];
    
    // Inicia obtención de localización
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
    
    // Zoom del mapa
    MKCoordinateSpan span;
    span.latitudeDelta = .01;
    span.longitudeDelta = .01;
    
    MKCoordinateRegion region;
    // Setea centro en mapa y zoom
    region.center = newLocation.coordinate;
    region.span = span;
    
    
    // Setea circulo a 500m
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:newLocation.coordinate radius:500];
    
    // Elimina circulos en el mapa
    [self.mapa removeOverlays: [self.mapa overlays]];
    
    // Dibuja circulo en mapa
    [self.mapa addOverlay:circle];
    
    
    // acutaliza mapa
    [self.mapa setRegion:region animated:YES];
    
    //[self.location stopUpdatingLocation];
}


// Error al obtener localización
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


// Delegado MapKit para generar circulo
- (MKOverlayView *)mapView:(MKMapView *)map viewForOverlay:(id <MKOverlay>)overlay
{
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
    //circleView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:0.1];
    circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.1];
    return circleView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
