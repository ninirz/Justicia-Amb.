//
//  Course.swift
//  Coppel
//
//  Created by Wendy Sanchez Cortes on 23/04/24.
//

import Foundation
import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var caption: String
    var color: Color
    var image: Image
    var imageProgram : Image
}

var courses: [Course] = [
    Course(title: "Confección", subtitle: "Descubre el mundo de la moda", caption: "Aprende las técnicas básicas de corte y confección de prendas de vestir. Desde la toma de medidas hasta la creación de diseños únicos.", color: .yellowCoppel, image: Image("Topic 2"), imageProgram: Image("Programa3")),
    Course(title: "Panadería", subtitle: "Deliciosos aromas y sabores", caption: "Sumérgete en el arte de la panadería y la repostería. Desde los secretos de los panes artesanales hasta las exquisitas creaciones de pasteles y postres.", color: .blueCoppel, image: Image("Topic 2"), imageProgram: Image("Programa2"))
]

