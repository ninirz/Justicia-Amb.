//
//  Vertex.swift
//  Coppel
//
//  Created by Wendy Sanchez Cortes on 24/04/24.
//

import Foundation

struct Vertex {
    let question: String
    let possibleAnswers: [String]
    let valorAnswers: [Int] // Agrega un array de valores de puntaje para cada respuesta
    let possibleJobs: [Int]
    let nextQuestionIndices: [Int]
}

let testTec = [
    Vertex(question: "¿Cuál es la capital de Francia?", possibleAnswers: ["Londres", "París", "Roma"], valorAnswers: [10, 12, 3], possibleJobs: [0, 1, 2], nextQuestionIndices: [1, 0, 0]),
    Vertex(question: "¿Quién escribió 'Don Quijote de la Mancha'?", possibleAnswers: ["Miguel de Cervantes", "Pablo Neruda", "Gabriel García Márquez"], valorAnswers: [3, 4, 7], possibleJobs: [2, 3, 0], nextQuestionIndices: [2, 1, 0]),
    Vertex(question: "¿Cuál es la raíz cuadrada de 16?", possibleAnswers: ["4", "8", "16"], valorAnswers: [6, 2, 4], possibleJobs: [1, 2, 3], nextQuestionIndices: [0, 0, -1])
]

