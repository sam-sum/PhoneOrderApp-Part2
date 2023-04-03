//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 1
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  LocationsViewController.swift
//  Date: MAR 26, 2023
//  Version: 1.0
//

import UIKit
import MapKit
import CoreLocation

class LocationsViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!

    fileprivate var locationManager:CLLocationManager = CLLocationManager()
    var storeDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StoreDetailViewController") as! StoreDetailViewController
    
    var appleStores = [
        [
            "name": "Apple Fairview",
            "address": "1800 Sheppard Ave E, Toronto, ON M2J 5A7, Canada",
            "phone": "(416) 646-4412",
            "hours": "Mon to Sat: 10:00am to 9:00pm\nSun: 11:00am to 7:00pm",
            "website": "https://www.apple.com/ca/retail/fairview/?cid=aos-ca-seo-maps",
            "lat" : "43.7778832",
            "lng" : "-79.3437891"
        ],
        [
            "name": "Apple Markville Shopping Centre",
            "address": "5000 Hwy 7, Markham, ON L3R 4M9, Canada",
            "phone": "(905) 513-2860",
            "hours": "Mon to Fri: 10:00am to 9:00pm\nSat: 10:00am to 6:00pm\nSun: 11:00am to 6:00pm",
            "website": "https://www.apple.com/ca/retail/markvilleshoppingcentre?cid=aos-ca-seo-maps",
            "lat" : "43.8683067",
            "lng" : "-79.2879519"
        ],
        [
            "name": "Jump+ - Apple Premium Retailer (Scarborough)",
            "address": "300 Borough Dr, Scarborough, ON M1P 4P5, Canada",
            "phone": "(647) 417-1434",
            "hours": "Mon to Sat: 10:00am to 9:00pm\nSun: 11:00am to 7:00pm",
            "website": "http://jumpplus.com/",
            "lat" : "43.775482",
            "lng" : "-79.2570003"
        ],
        [
            "name": "Apple Eaton Centre",
            "address": "220 Yonge St, Toronto, ON M5B 2H1, Canada",
            "phone": "(647) 258-0801",
            "hours": "Mon to Sat: 10:00am to 9:00pm\nSun: 11:00am to 7:00pm",
            "website": "https://www.apple.com/ca/retail/eatoncentre/?cid=aos-ca-seo-maps",
            "lat" : "43.6528195",
            "lng" : "-79.3806105"
        ],
        [
            "name": "Apple Yorkdale",
            "address": "3401 Dufferin St, Toronto, ON M6A 3A1, Canada",
            "phone": "(416) 785-1776",
            "hours": "Mon to Sat: 10:00am to 9:00pm\nSun: 11:00am to 7:00pm",
            "website": "https://www.apple.com/ca/retail/yorkdale?cid=aos-ca-seo-maps",
            "lat" : "43.7242617",
            "lng" : "-79.4531191"
        ],
        [
            "name": "Apple Sherway Gardens",
            "address": "25 The West Mall, Toronto, ON M9C 1B8, Canada",
            "phone": "(416) 646-8489",
            "hours": "Mon to Sat: 10:00am to 9:00pm\nSun: 10:00am to 6:00pm",
            "website": "https://www.apple.com/ca/retail/sherwaygardens?cid=aos-ca-seo-maps",
            "lat" : "43.6122152",
            "lng" : "-79.5563002"
        ],
        [
            "name": "Jump+ Apple Premium Retailer (Toronto)",
            "address": "275 College St, Toronto, ON M5T 1S2, Canada",
            "phone": "(416) 927-8000",
            "hours": "Mon to Fri: 9:00am to 7:00pm\nSat: 10:00am to 5:30pm\nSun: 12:00nn to 5:00pm",
            "website": "http://www.jumpplus.com",
            "lat" : "43.6577101",
            "lng" : "-79.4006072"
        ],
        [
            "name": "Apple Square One",
            "address": "100 City Centre Dr, Mississauga, ON L5B 2C9, Canada",
            "phone": "(905) 366-0580",
            "hours": "Mon to Sat: 10:00am to 9:00pm\nSun: 11:00am to 7:00pm",
            "website": "https://www.apple.com/ca/retail/squareone?cid=aos-ca-seo-maps",
            "lat" : "43.6122152",
            "lng" : "-79.5563002"
        ],
        [
            "name": "RiverdaleMac",
            "address": "345 Danforth Ave, Toronto, ON M4K 1N7, Canada",
            "phone": "(416) 778-4048",
            "hours": "Mon to Sat: 10:00am to 6:00pm\nSun: Closed",
            "website": "https://www.riverdalemac.com/",
            "lat" : "43.6771945",
            "lng" : "-79.3531491"
        ],
        [
            "name": "Jump+ Apple Premium Retailer (Vaughan Mills)",
            "address": "1 Bass Pro Mills Dr, Concord, ON L4K 5W4, Canada",
            "phone": "(289) 459-1887",
            "hours": "Mon to Sat: 10:00am to 9:00pm\nSun: 11:00am to 7:00pm",
            "website": "http://jumpplus.com/",
            "lat" : "43.8255192",
            "lng" : "-79.5407848"
        ],
        [
            "name": "BeachMac",
            "address": "1960 Queen St E #2, Toronto, ON M4L 1H8, Canada",
            "phone": "(416) 849-0694",
            "hours": "Mon to Sat: 10:00am to 6:00pm\nSun: Closed",
            "website": "https://www.riverdalemac.com/",
            "lat" : "43.669736",
            "lng" : "-79.3020569"
        ],
        [
            "name": "Apple Upper Canada Mall",
            "address": "17600 Yonge St, Newmarket, ON L3Y 4Z1, Canada",
            "phone": "(905) 952-3400",
            "hours": "Mon to Sat: 10:00am to 8:00pm\nSun: 11:00am to 7:00pm",
            "website": "https://www.apple.com/ca/retail/uppercanadamall?cid=aos-ca-seo-maps",
            "lat" : "44.0557712",
            "lng" : "-79.48520409999999"
        ],
        [
            "name": "Roncesvalles Apple Specialist",
            "address": "381 Roncesvalles Ave, Toronto, ON M6R 2M8, Canada",
            "phone": "(416) 769-2775",
            "hours": "Mon to Sat: 10:00am to 8:00pm\nSun: 11:00am to 7:00pm",
            "website": "https://www.riverdalemac.com/",
            "lat" : "43.6502852",
            "lng" : "-79.4502878"
        ],
        [
            "name": "Best Buy",
            "address": "480 Progress Ave, Scarborough, ON M1P 5J, Canada",
            "phone": "(866) 237-8289",
            "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm",
            "website": "https://stores.bestbuy.ca/en-ca/on/scarborough/480-progress-ave",
            "lat" : "43.7787632",
            "lng" : "-79.2599262"
        ],
        [
            "name": "The Mobile Shop",
            "address": "8339 Kennedy Rd, Unionville, ON L3R 5T5, Canada",
            "phone": "(905) 513-0908",
            "hours": "Mon to Sun: 10:00am to 6:00pm",
            "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
            "lat" : "43.857031",
            "lng" : "-79.303463"
        ],
        [
            "name": "Best Buy",
            "address": "50 Ashtonbee Rd Unit 2, Scarborough, ON M1L 4R5, Canada",
            "phone": "(866) 237-8289",
            "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm",
            "website": "https://stores.bestbuy.ca/en-ca/on/scarborough/50-ashtonbee-rd-unit-2",
            "lat" : "43.730121",
            "lng" : "79.2892152"
        ],
        [
            "name": "The Mobile Shop",
            "address": "200 Bullock Dr, Markham, ON L3P 1W2, Canada",
            "phone": "(905) 471-9894",
            "hours": "Mon to Sat: 10:00am to 8:00pm\nSun: 10:00am to 6:00pm",
            "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
            "lat" : "43.874193",
            "lng" : "-79.284753"
        ],
        [
            "name": "Best Buy",
            "address": "147 Laird Dr, Toronto, ON M4G 4K1, Canada",
            "website": "https://stores.bestbuy.ca/en-ca/on/toronto/147-laird-dr",
            "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm",
            "phone": "(866) 237-8289",
            "lat": "43.7092551",
            "lng": "-79.3616804"
        ],
        [
            "name": "The Mobile Shop",
            "address": "51 Gerry Fitzgerald Dr, North York, ON M3J 3N4, Canada",
            "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
            "hours": "Mon to Sun: 10:am to 6:00pm",
            "phone": "(416) 661-3013",
            "lat": "43.784833",
            "lng": "-79.47177500000001"
        ],
        [
            "name": "Best Buy",
                  "address": "5000 Hwy 7 Unit 2070L, Markham, ON L3R 4M9, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/markham/5000-hwy-7-e-unit-2070l",
                  "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm",
                  "phone": "(866) 237-8289",
                  "lat": "43.8690265",
                  "lng": "-79.2889952"
        ],
        [
            "name": "Best Buy",
                  "address": "225 High Tech Rd Unit 3, Richmond Hill, ON L4B 0A6, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/richmond-hill/225-high-tech-rd-unit-3",
                  "hours": "Mon to Sat: 11:00am to 7:00pm\nSun: 11:00am to 6:00pm",
                  "phone": "(866) 237-8289",
                  "lat": "43.8419634",
                  "lng": "-79.4175206"
        ],
        [
            "name": "Best Buy",
                  "address": "695 Wilson Ave, Toronto, ON M3K 1E3, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/toronto/695-wilson-ave",
                  "hours": "Mon to Sat: 11:00am to 7:00pm\nSun: 11:00am to 6:00pm",
                  "phone": "(866) 237-8289",
                  "lat": "43.7320846",
                  "lng": "-79.4564214"
        ],
        [
            "name": "Best Buy",
                  "address": "65 Dundas St W, Toronto, ON M5G 2C3, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/toronto/65-dundas-st-w",
                  "phone": "(866) 237-8289",
                  "lat": "43.6554395",
                  "lng": "-79.3824463",
                  "hours": "Mon to Sat: 10:00am to 9:00pm\nSun: 11:00am to 7:00pm"
        ],
        [
            "name": "The Mobile Shop",
                 "address": "200 Taunton Rd W, Whitby, ON L1R 3H8, Canada",
                 "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
                 "phone": "(905) 666-2654",
                 "lat": "43.916054",
                 "lng": "-78.96187499999999",
                 "hours": "Mon to Sat: 10:00am to 8:00pm\nSun: 10:00am to 6:00pm"
        ],
        [
            "name": "Best Buy",
                  "address": "10 Old Stock Yards Rd, Toronto, ON M6N 5G8, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/toronto/10-old-stock-yards-rd",
                  "phone": "(866) 237-8289",
                  "lat": "43.6692236",
                  "lng": "-79.4715066",
                  "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm"
        ],
        [
            "name": "Best Buy",
                  "address": "7850 Weston Rd Bldg. E Unit 1, Woodbridge, ON L4L 9N8, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/woodbridge/7850-weston-rd--bldg-e-unit-1",
                  "phone": "(866) 237-8289",
                  "lat": "43.7922458",
                  "lng": "-79.5490796",
                  "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm"
        ],
        [
            "name": "The Mobile Shop",
                  "address": "1385 Harmony Rd N, Oshawa, ON L1H 7K5, Canada",
                  "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
                  "phone": "(905) 571-7674",
                  "lat": "43.941904",
                  "lng": "-78.843763",
                  "hours": "Mon to Sat: 10:00am to 8:00pm\nSun: 10:00am to 6:00pm"
        ],
        [
            "name": "Best Buy",
                  "address": "20 Kingston Rd W, Ajax, ON L1T 4K8, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/ajax/20-kingston-rd-w",
                  "phone": "(866) 237-8289",
                  "lat": "43.8617354",
                  "lng": "-79.02849379999999",
                  "hours": "Mon to Sat: 11:00am to 7:00pm\nSun: 11:00am to 6:00pm"
        ],
        [
            "name": "Best Buy",
                  "address": "167 N Queen St, Etobicoke, ON M9C 1A7, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/etobicoke/167-north-queen-st",
                  "phone": "(866) 237-8289",
                  "lat": "43.6171686",
                  "lng": "-79.5537239",
                  "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm"
        ],
        [
            "name": "The Mobile Shop",
                  "address": "171 Guelph St, Georgetown, ON L7G 4A1, Canada",
                  "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
                  "phone": "(905) 702-8434",
                  "lat": "43.651481",
                  "lng": "-79.90639399999999",
                  "hours": "Mon to Sun: 11:00am to 7:00pm"
        ],
        [
            "name": "The Mobile Shop",
                 "address": "820 Main St E, Milton, ON L9T 0J4, Canada",
                 "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
                 "phone": "(905) 875-4153",
                 "lat": "43.52540399999999",
                 "lng": "-79.866258",
                 "hours": "Mon to Sun: 10:00am to 8:00pm"
        ],
        [
            "name": "Best Buy",
                  "address": "6075 Mavis Rd Unit 1, Mississauga, ON L5R 4G6, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/mississauga/6075-mavis-rd-unit-1",
                  "phone": "(866) 237-8289",
                  "lat": "43.6146907",
                  "lng": "-79.6970235",
            "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm"
        ]
    ]

    var googleStores = [
        [
            "name": "Best Buy",
            "address": "480 Progress Ave, Scarborough, ON M1P 5J, Canada",
            "phone": "(866) 237-8289",
            "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm",
            "website": "https://stores.bestbuy.ca/en-ca/on/scarborough/480-progress-ave",
            "lat" : "43.7787632",
            "lng" : "-79.2599262"
        ],
        [
            "name": "The Mobile Shop",
            "address": "8339 Kennedy Rd, Unionville, ON L3R 5T5, Canada",
            "phone": "(905) 513-0908",
            "hours": "Mon to Sun: 10:00am to 6:00pm",
            "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
            "lat" : "43.857031",
            "lng" : "-79.303463"
        ],
        [
            "name": "Best Buy",
            "address": "50 Ashtonbee Rd Unit 2, Scarborough, ON M1L 4R5, Canada",
            "phone": "(866) 237-8289",
            "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm",
            "website": "https://stores.bestbuy.ca/en-ca/on/scarborough/50-ashtonbee-rd-unit-2",
            "lat" : "43.730121",
            "lng" : "79.2892152"
        ],
        [
            "name": "The Mobile Shop",
            "address": "200 Bullock Dr, Markham, ON L3P 1W2, Canada",
            "phone": "(905) 471-9894",
            "hours": "Mon to Sat: 10:00am to 8:00pm\nSun: 10:00am to 6:00pm",
            "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
            "lat" : "43.874193",
            "lng" : "-79.284753"
        ],
        [
            "name": "Best Buy",
            "address": "147 Laird Dr, Toronto, ON M4G 4K1, Canada",
            "website": "https://stores.bestbuy.ca/en-ca/on/toronto/147-laird-dr",
            "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm",
            "phone": "(866) 237-8289",
            "lat": "43.7092551",
            "lng": "-79.3616804"
        ],
        [
            "name": "The Mobile Shop",
            "address": "51 Gerry Fitzgerald Dr, North York, ON M3J 3N4, Canada",
            "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
            "hours": "Mon to Sun: 10:am to 6:00pm",
            "phone": "(416) 661-3013",
            "lat": "43.784833",
            "lng": "-79.47177500000001"
        ],
        [
            "name": "Best Buy",
                  "address": "5000 Hwy 7 Unit 2070L, Markham, ON L3R 4M9, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/markham/5000-hwy-7-e-unit-2070l",
                  "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm",
                  "phone": "(866) 237-8289",
                  "lat": "43.8690265",
                  "lng": "-79.2889952"
        ],
        [
            "name": "Best Buy",
                  "address": "225 High Tech Rd Unit 3, Richmond Hill, ON L4B 0A6, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/richmond-hill/225-high-tech-rd-unit-3",
                  "hours": "Mon to Sat: 11:00am to 7:00pm\nSun: 11:00am to 6:00pm",
                  "phone": "(866) 237-8289",
                  "lat": "43.8419634",
                  "lng": "-79.4175206"
        ],
        [
            "name": "Best Buy",
                  "address": "695 Wilson Ave, Toronto, ON M3K 1E3, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/toronto/695-wilson-ave",
                  "hours": "Mon to Sat: 11:00am to 7:00pm\nSun: 11:00am to 6:00pm",
                  "phone": "(866) 237-8289",
                  "lat": "43.7320846",
                  "lng": "-79.4564214"
        ],
        [
            "name": "Best Buy",
                  "address": "65 Dundas St W, Toronto, ON M5G 2C3, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/toronto/65-dundas-st-w",
                  "phone": "(866) 237-8289",
                  "lat": "43.6554395",
                  "lng": "-79.3824463",
                  "hours": "Mon to Sat: 10:00am to 9:00pm\nSun: 11:00am to 7:00pm"
        ],
        [
            "name": "The Mobile Shop",
                 "address": "200 Taunton Rd W, Whitby, ON L1R 3H8, Canada",
                 "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
                 "phone": "(905) 666-2654",
                 "lat": "43.916054",
                 "lng": "-78.96187499999999",
                 "hours": "Mon to Sat: 10:00am to 8:00pm\nSun: 10:00am to 6:00pm"
        ],
        [
            "name": "Best Buy",
                  "address": "10 Old Stock Yards Rd, Toronto, ON M6N 5G8, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/toronto/10-old-stock-yards-rd",
                  "phone": "(866) 237-8289",
                  "lat": "43.6692236",
                  "lng": "-79.4715066",
                  "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm"
        ],
        [
            "name": "Best Buy",
                  "address": "7850 Weston Rd Bldg. E Unit 1, Woodbridge, ON L4L 9N8, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/woodbridge/7850-weston-rd--bldg-e-unit-1",
                  "phone": "(866) 237-8289",
                  "lat": "43.7922458",
                  "lng": "-79.5490796",
                  "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm"
        ],
        [
            "name": "The Mobile Shop",
                  "address": "1385 Harmony Rd N, Oshawa, ON L1H 7K5, Canada",
                  "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
                  "phone": "(905) 571-7674",
                  "lat": "43.941904",
                  "lng": "-78.843763",
                  "hours": "Mon to Sat: 10:00am to 8:00pm\nSun: 10:00am to 6:00pm"
        ],
        [
            "name": "Best Buy",
                  "address": "20 Kingston Rd W, Ajax, ON L1T 4K8, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/ajax/20-kingston-rd-w",
                  "phone": "(866) 237-8289",
                  "lat": "43.8617354",
                  "lng": "-79.02849379999999",
                  "hours": "Mon to Sat: 11:00am to 7:00pm\nSun: 11:00am to 6:00pm"
        ],
        [
            "name": "Best Buy",
                  "address": "167 N Queen St, Etobicoke, ON M9C 1A7, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/etobicoke/167-north-queen-st",
                  "phone": "(866) 237-8289",
                  "lat": "43.6171686",
                  "lng": "-79.5537239",
                  "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm"
        ],
        [
            "name": "The Mobile Shop",
                  "address": "171 Guelph St, Georgetown, ON L7G 4A1, Canada",
                  "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
                  "phone": "(905) 702-8434",
                  "lat": "43.651481",
                  "lng": "-79.90639399999999",
                  "hours": "Mon to Sun: 11:00am to 7:00pm"
        ],
        [
            "name": "The Mobile Shop",
                 "address": "820 Main St E, Milton, ON L9T 0J4, Canada",
                 "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
                 "phone": "(905) 875-4153",
                 "lat": "43.52540399999999",
                 "lng": "-79.866258",
                 "hours": "Mon to Sun: 10:00am to 8:00pm"
        ],
        [
            "name": "Best Buy",
                  "address": "6075 Mavis Rd Unit 1, Mississauga, ON L5R 4G6, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/mississauga/6075-mavis-rd-unit-1",
                  "phone": "(866) 237-8289",
                  "lat": "43.6146907",
                  "lng": "-79.6970235",
            "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm"
        ]
    ]
    var samsumgStores = [
        [
            "name": "Samsung",
                  "address": "300 Borough Dr, Scarborough, ON M1P 4P5, Canada",
                  "website": "https://scarboroughtowncentre.com/store/samsung/",
                  "phone": "(416) 775-3527",
                  "lat": "43.77525139999999",
                  "lng": "-79.2576768",
                  "hours": "Mon to Sat: 10:00am to 9:00pm\nSun: 11:00am to 7:00pm"
        ],
        [
            "name": "Samsung Experience Store - Toronto Eaton Centre",
                  "address": "220 Yonge St, Toronto, ON M5B 2H1, Canada",
                  "website": "http://www.samsung.com/ca/ses/",
                  "phone": "(416) 775-3520",
                  "lat": "43.6555803",
                  "lng": "-79.3809804",
            "hours": "Mon to Sat: 10:00am to 9:00pm\nSun: 11:00am to 7:00pm"
        ],
        [
            "name": "Samsung Experience Store - Yorkdale",
                  "address": "3401 Dufferin St Unit 508, North York, ON M6A 2T9, Canada",
                  "website": "http://samsung.com/ca/ses",
                  "phone": "(416) 784-0819",
                  "lat": "43.7254552",
                  "lng": "-79.4500059",
            "hours": "Mon to Sat: 10:00am to 9:00pm\nSun: 11:00am to 7:00pm"
        ],
        [
            "name": "Samsung Experience Store - Sherway Gardens",
                  "address": "25 The West Mall #3020, Etobicoke, ON M9C 1B8, Canada",
                  "website": "http://samsung.com/ca/ses",
                  "phone": "(416) 622-9855",
                  "lat": "43.61294840000001",
                  "lng": "-79.5590303",
            "hours": "Mon to Sat: 10:00am to 9:00pm\nSun: 10:00am to 6:00pm"
            
        ],
        [
            "name": "Nur's Shop",
                  "address": "38 Metropolitan Rd Unit 8, Scarborough, ON M1R 2T6, Canada",
                  "website": "http://www.nursshop.com/",
                  "phone": "(647) 781-9504",
                  "lat": "43.7683662",
                  "lng": "-79.29990819999999",
            "hours": "Mon to Fri: 9:00am to 5:00pm\nSat to Sun: Closed"
        ],
        [
            "name": "Galaxy Mobile",
                  "address": "4300 Steeles Ave E unit a16, Markham, ON L3R 0Y5, Canada",
                  "website": "https://website--889930675944279220947-cellphonestore.business.site/?utm_source=gmb&utm_medium=referral",
                  "phone": "(647) 771-8820",
                  "lat": "43.8263024",
                  "lng": "-79.3062592",
            "hours": "Mon to Tue: 11:00am to 7:00pm\nWed: Closed\nThurs to Sat: 11:00am to 7:00pm\nSun: Closed"
        ],
        [
            "name": "Bluetech Canada",
                  "address": "2220 Midland Ave #60BR, Scarborough, ON M1P 3E6, Canada",
                  "website": "http://www.bluetechcanada.com/",
                  "phone": "(647) 748-5599",
                  "lat": "43.7737775",
                  "lng": "-79.2758645",
            "hours": "Mon to Sat: 10:00am to 9:00pm\nSun: 12:00am to 5:00pm"
        ],
        [
            "name": "Cellular Point",
                  "address": "Agincourt Mall, 3850 Sheppard Ave E, Scarborough, ON M1T 3L3, Canada",
                  "website": "https://www.cellularpoint.ca/store-locator/agincourt/",
                  "phone": "(416) 321-2355",
                  "lat": "43.7841776",
                  "lng": "-79.29296769999999",
            "hours": "Mon to Fri: 10:00am to 9:00pm\nSat: 10:00am to 6:00pm\nSun: 12:00am to 5:00pm"
        ],
        [
            "name": "A32 Wireless",
                  "address": "4465 Sheppard Ave E Unit 25A, Scarborough, ON M1S 5H9, Canada",
                  "website": "http://www.a-32.com/",
                  "phone": "(416) 871-8336",
                  "lat": "43.7878379",
                  "lng": "-79.2659335",
            "hours": "Mon to Sat: 11:00am to 7:00pm\nSun: Closed"
        ],
        [
            "name": "Best Buy",
            "address": "480 Progress Ave, Scarborough, ON M1P 5J, Canada",
            "phone": "(866) 237-8289",
            "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm",
            "website": "https://stores.bestbuy.ca/en-ca/on/scarborough/480-progress-ave",
            "lat" : "43.7787632",
            "lng" : "-79.2599262"
        ],
        [
            "name": "The Mobile Shop",
            "address": "8339 Kennedy Rd, Unionville, ON L3R 5T5, Canada",
            "phone": "(905) 513-0908",
            "hours": "Mon to Sun: 10:00am to 6:00pm",
            "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
            "lat" : "43.857031",
            "lng" : "-79.303463"
        ],
        [
            "name": "Best Buy",
            "address": "50 Ashtonbee Rd Unit 2, Scarborough, ON M1L 4R5, Canada",
            "phone": "(866) 237-8289",
            "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm",
            "website": "https://stores.bestbuy.ca/en-ca/on/scarborough/50-ashtonbee-rd-unit-2",
            "lat" : "43.730121",
            "lng" : "79.2892152"
        ],
        [
            "name": "The Mobile Shop",
            "address": "200 Bullock Dr, Markham, ON L3P 1W2, Canada",
            "phone": "(905) 471-9894",
            "hours": "Mon to Sat: 10:00am to 8:00pm\nSun: 10:00am to 6:00pm",
            "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
            "lat" : "43.874193",
            "lng" : "-79.284753"
        ],
        [
            "name": "Best Buy",
            "address": "147 Laird Dr, Toronto, ON M4G 4K1, Canada",
            "website": "https://stores.bestbuy.ca/en-ca/on/toronto/147-laird-dr",
            "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm",
            "phone": "(866) 237-8289",
            "lat": "43.7092551",
            "lng": "-79.3616804"
        ],
        [
            "name": "The Mobile Shop",
            "address": "51 Gerry Fitzgerald Dr, North York, ON M3J 3N4, Canada",
            "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
            "hours": "Mon to Sun: 10:am to 6:00pm",
            "phone": "(416) 661-3013",
            "lat": "43.784833",
            "lng": "-79.47177500000001"
        ],
        [
            "name": "Best Buy",
                  "address": "5000 Hwy 7 Unit 2070L, Markham, ON L3R 4M9, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/markham/5000-hwy-7-e-unit-2070l",
                  "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm",
                  "phone": "(866) 237-8289",
                  "lat": "43.8690265",
                  "lng": "-79.2889952"
        ],
        [
            "name": "Best Buy",
                  "address": "225 High Tech Rd Unit 3, Richmond Hill, ON L4B 0A6, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/richmond-hill/225-high-tech-rd-unit-3",
                  "hours": "Mon to Sat: 11:00am to 7:00pm\nSun: 11:00am to 6:00pm",
                  "phone": "(866) 237-8289",
                  "lat": "43.8419634",
                  "lng": "-79.4175206"
        ],
        [
            "name": "Best Buy",
                  "address": "695 Wilson Ave, Toronto, ON M3K 1E3, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/toronto/695-wilson-ave",
                  "hours": "Mon to Sat: 11:00am to 7:00pm\nSun: 11:00am to 6:00pm",
                  "phone": "(866) 237-8289",
                  "lat": "43.7320846",
                  "lng": "-79.4564214"
        ],
        [
            "name": "Best Buy",
                  "address": "65 Dundas St W, Toronto, ON M5G 2C3, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/toronto/65-dundas-st-w",
                  "phone": "(866) 237-8289",
                  "lat": "43.6554395",
                  "lng": "-79.3824463",
                  "hours": "Mon to Sat: 10:00am to 9:00pm\nSun: 11:00am to 7:00pm"
        ],
        [
            "name": "The Mobile Shop",
                 "address": "200 Taunton Rd W, Whitby, ON L1R 3H8, Canada",
                 "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
                 "phone": "(905) 666-2654",
                 "lat": "43.916054",
                 "lng": "-78.96187499999999",
                 "hours": "Mon to Sat: 10:00am to 8:00pm\nSun: 10:00am to 6:00pm"
        ],
        [
            "name": "Best Buy",
                  "address": "10 Old Stock Yards Rd, Toronto, ON M6N 5G8, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/toronto/10-old-stock-yards-rd",
                  "phone": "(866) 237-8289",
                  "lat": "43.6692236",
                  "lng": "-79.4715066",
                  "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm"
        ],
        [
            "name": "Best Buy",
                  "address": "7850 Weston Rd Bldg. E Unit 1, Woodbridge, ON L4L 9N8, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/woodbridge/7850-weston-rd--bldg-e-unit-1",
                  "phone": "(866) 237-8289",
                  "lat": "43.7922458",
                  "lng": "-79.5490796",
                  "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm"
        ],
        [
            "name": "The Mobile Shop",
                  "address": "1385 Harmony Rd N, Oshawa, ON L1H 7K5, Canada",
                  "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
                  "phone": "(905) 571-7674",
                  "lat": "43.941904",
                  "lng": "-78.843763",
                  "hours": "Mon to Sat: 10:00am to 8:00pm\nSun: 10:00am to 6:00pm"
        ],
        [
            "name": "Best Buy",
                  "address": "20 Kingston Rd W, Ajax, ON L1T 4K8, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/ajax/20-kingston-rd-w",
                  "phone": "(866) 237-8289",
                  "lat": "43.8617354",
                  "lng": "-79.02849379999999",
                  "hours": "Mon to Sat: 11:00am to 7:00pm\nSun: 11:00am to 6:00pm"
        ],
        [
            "name": "Best Buy",
                  "address": "167 N Queen St, Etobicoke, ON M9C 1A7, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/etobicoke/167-north-queen-st",
                  "phone": "(866) 237-8289",
                  "lat": "43.6171686",
                  "lng": "-79.5537239",
                  "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm"
        ],
        [
            "name": "The Mobile Shop",
                  "address": "171 Guelph St, Georgetown, ON L7G 4A1, Canada",
                  "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
                  "phone": "(905) 702-8434",
                  "lat": "43.651481",
                  "lng": "-79.90639399999999",
                  "hours": "Mon to Sun: 11:00am to 7:00pm"
        ],
        [
            "name": "The Mobile Shop",
                 "address": "820 Main St E, Milton, ON L9T 0J4, Canada",
                 "website": "https://www.themobileshop.ca/en/locations?utm_source=G&utm_medium=LPM&utm_campaign=PresidentsChoiceBank",
                 "phone": "(905) 875-4153",
                 "lat": "43.52540399999999",
                 "lng": "-79.866258",
                 "hours": "Mon to Sun: 10:00am to 8:00pm"
        ],
        [
            "name": "Best Buy",
                  "address": "6075 Mavis Rd Unit 1, Mississauga, ON L5R 4G6, Canada",
                  "website": "https://stores.bestbuy.ca/en-ca/on/mississauga/6075-mavis-rd-unit-1",
                  "phone": "(866) 237-8289",
                  "lat": "43.6146907",
                  "lng": "-79.6970235",
            "hours": "Mon to Fri: 10:00am to 8:00pm\nSat: 10:00am to 7:00pm\nSun: 11:00am to 6:00pm"
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        mapView.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()

        mapView.showsUserLocation = true

        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 20000, longitudinalMeters: 20000)
            mapView.setRegion(viewRegion, animated: true)
        }

        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.sendActions(for: UIControl.Event.valueChanged)

    }

    @objc func willEnterForeground() {
        (UIApplication.shared.delegate as? AppDelegate)?.overrideThemeStyle()
    }
    
    // Show the custom pins on the map and make the pins clickable
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationIdentifier") as? MKPinAnnotationView
        if !(annotation is MKUserLocation) {
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationIdentifier")
            } else {
                annotationView?.annotation = annotation
            }

            if let annotation = annotation as? MyPointAnnotation {
                annotationView?.canShowCallout = true
                let btn = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = btn
                annotationView?.pinTintColor = annotation.pinTintColor
            }
        }
        return annotationView
    }

    // Show the bottom sheet when the pin action button is clicked
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //guard let storesAnnotation = view.annotation as? MyPointAnnotation else { return }
        if let storeAnnotation = view.annotation as? MyPointAnnotation {
            storeDetailVC.store.copy(original: storeAnnotation)
            if let sheet = storeDetailVC.sheetPresentationController {
                if #available(iOS 16.0, *) {
                    sheet.detents = [.custom { context in
                        return context.maximumDetentValue * 0.45
                    },]
                } else {
                    // Fallback on earlier versions
                    sheet.detents = [.medium()]
                }
                sheet.prefersGrabberVisible = true
            }
            self.present(storeDetailVC, animated: true, completion: nil)
        }
    }

    // Handle the segmented button action. Change stores accrodingly
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            showStoresAnnotations(stores: appleStores, color: UIColor.red)
        case 1:
            showStoresAnnotations(stores: googleStores, color: UIColor.purple)
        case 2:
            showStoresAnnotations(stores: samsumgStores, color: UIColor.darkGray)
        default:
        break;
        }
    }

    // Put the pins according to the json store coordinates with specific color
    func showStoresAnnotations(stores: [[String: String]], color: UIColor) {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)

        for store in stores {
            if let name = store["name"], let lat = store["lat"], let lng = store["lng"] {
                let pin = MyPointAnnotation(pinTintColor: color, name: name, address: store["address"]!, phone: store["phone"]!, hours: store["hours"]!, website: store["website"]!)
                pin.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lng)!)
                pin.title = name
                mapView.addAnnotation(pin)
            }
        }
    }

}

class MyPointAnnotation : MKPointAnnotation {

    var pinTintColor: UIColor
    var name: String
    var address: String
    var phone: String
    var hours: String
    var website: String

    init(pinTintColor: UIColor = UIColor.black,
            name: String = "",
            address: String = "",
            phone: String = "",
            hours: String = "",
            website: String = ""
    ) {
        self.pinTintColor = pinTintColor
        self.name = name
        self.address = address
        self.phone = phone
        self.hours = hours
        self.website = website
    }

    func copy(original: MyPointAnnotation) {
        self.pinTintColor = original.pinTintColor
        self.name = original.name
        self.address = original.address
        self.phone = original.phone
        self.hours = original.hours
        self.website = original.website
    }
    
    
}
