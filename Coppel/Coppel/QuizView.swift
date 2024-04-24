import SwiftUI



struct QuizView: View {
    @State private var currentQuestionIndex = 0
    @State private var puntaje = 0 // Nuevo estado para almacenar el puntaje total
    @State private var selectedAnswerIndex: Int?
    @State private var arrayPsi = [Int](repeating: 0, count: 27)
    
    @State private var Jobs: [(nombreOficio: String, contador: Int)] = [
        ("Electricista", 0),
        ("Plomero", 0),
        ("Carpintero", 0),
        ("Mecánico automotriz", 0)
    ]
    
    var currentVertex: Vertex {
        testTec[currentQuestionIndex]
    }
    
    var body: some View {
        VStack {
            if currentQuestionIndex >= 0 { // Verifica si el índice de la pregunta es válido
                HStack {
                    Text(currentVertex.question)
                        .font(.custom("Poppins-Bold", size: 30))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .frame(width: 300, alignment: .center)
                
                
                ForEach(currentVertex.possibleAnswers.indices, id: \.self) { index in
                    Button(action: {
                        self.selectedAnswerIndex = index
                    }) {
                        Text(currentVertex.possibleAnswers[index])
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 300, alignment: .center)
                            .background(self.selectedAnswerIndex == index ? Color.yellowCoppel : Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                }
                Spacer()
                    .frame(height: 50)
                
                Button(action: {
                    self.moveToNextQuestion()
                }) {
                    Text("Siguiente")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                }
                .disabled(selectedAnswerIndex == nil)
            } else {
                Text("Puntaje: \(puntaje)")
                    .font(.title)
                    .padding()
                
                let tresMayoresOficios = obtenerTresMayoresOficios(oficios: Jobs)
                    Text(tresMayoresOficios.joined(separator: ", "))
            }
        }
    }
    
    func moveToNextQuestion() {
        if selectedAnswerIndex! < 0 { // Verifica si el índice seleccionado es menor que 0
            currentQuestionIndex = -1 // Establece el índice de la pregunta como -1 para indicar que el cuestionario ha terminado
        } else if let nextQuestionIndex = selectedAnswerIndex {
            // Suma el valor del puntaje de la respuesta seleccionada al puntaje total
            puntaje += currentVertex.valorAnswers[nextQuestionIndex]
            currentQuestionIndex = currentVertex.nextQuestionIndices[nextQuestionIndex]
            
            if selectedAnswerIndex! < 0 {Jobs[currentVertex.possibleJobs[nextQuestionIndex]].contador += 1}
            selectedAnswerIndex = nil
        }
    }
    
    func obtenerTresMayoresOficios(oficios: [(nombreOficio: String, contador: Int)]) -> [String] {
        // Ordena el arreglo de oficios por contador en orden descendente
        let oficiosOrdenados = oficios.sorted { $0.contador > $1.contador }
        
        // Extrae los nombres de los tres primeros oficios del arreglo ordenado
        let tresMayoresOficios = Array(oficiosOrdenados.prefix(3)).map { $0.nombreOficio }
        
        return tresMayoresOficios
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
