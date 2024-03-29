//
//  ModelsDTO+fake.swift
//  TripPlanner
//
//  Created by Andrew Savitskiy on 30.01.2024.
//

import Foundation



// MARK: - ConnectionsResponse
extension ConnectionsResponse {
    static var fake: [ConnectionDTO] {
        let jsonConnectionsData = """
{
  "connections": [
    {
      "from": "London",
      "to": "Tokyo",
      "coordinates": {
        "from": {
          "lat": 51.5285582,
          "long": -0.241681
        },
        "to": {
          "lat": 35.652832,
          "long": 139.839478
        }
      },
      "price": 220
    },
    {
      "from": "Tokyo",
      "to": "London",
      "coordinates": {
        "from": {
          "lat": 35.652832,
          "long": 139.839478
        },
        "to": {
          "lat": 51.5285582,
          "long": -0.241681
        }
      },
      "price": 200
    },
    {
      "from": "London",
      "to": "Porto",
      "price": 50,
      "coordinates": {
        "from": {
          "lat": 51.5285582,
          "long": -0.241681
        },
        "to": {
          "lat": 41.14961,
          "long": -8.61099
        }
      }
    },
    {
      "from": "Tokyo",
      "to": "Sydney",
      "price": 100,
      "coordinates": {
        "from": {
          "lat": 35.652832,
          "long": 139.839478
        },
        "to": {
          "lat": -33.865143,
          "long": 151.2099
        }
      }
    },
    {
      "from": "Sydney",
      "to": "Cape Town",
      "price": 200,
      "coordinates": {
        "from": {
          "lat": -33.865143,
          "long": 151.2099
        },
        "to": {
          "lat": -33.918861,
          "long": 18.4233
        }
      }
    },
    {
      "from": "Cape Town",
      "to": "London",
      "price": 800,
      "coordinates": {
        "from": {
          "lat": -33.918861,
          "long": 18.4233
        },
        "to": {
          "lat": 51.5285582,
          "long": -0.241681
        }
      }
    },
    {
      "from": "London",
      "to": "New York",
      "price": 400,
      "coordinates": {
        "from": {
          "lat": 51.5285582,
          "long": -0.241681
        },
        "to": {
          "lat": 40.73061,
          "long": -73.935242
        }
      }
    },
    {
      "from": "New York",
      "to": "Los Angeles",
      "price": 120,
      "coordinates": {
        "from": {
          "lat": 40.73061,
          "long": -73.935242
        },
        "to": {
          "lat": 34.052235,
          "long": -118.243683
        }
      }
    },
    {
      "from": "Los Angeles",
      "to": "Tokyo",
      "price": 150,
      "coordinates": {
        "from": {
          "lat": 34.052235,
          "long": -118.243683
        },
        "to": {
          "lat": 35.652832,
          "long": 139.839478
        }
      }
    }
  ]
}
""".data(using: .utf8)!
        return try! JSONDecoder().decode(ConnectionsResponse.self, from: jsonConnectionsData).connections
    }
}
