//
//  ContentView.swift
//  Bataiua2
//
//  Created by Adrian Otamendi Laspiur on 31/08/2023.
//

import SwiftUI
import Charts


struct ContentView: View {
    var body: some View {
        TabView {
            // First View (Your Existing Content)
            NavigationView {
                ElectaContentView()
                    .navigationBarTitle("ELECTIA", displayMode: .inline)
            }
            .tabItem {
                Image(systemName: "1.circle.fill")
                Text("ELECTIA")
            }
            
            // Second View (Another View with the Same Structure)
            NavigationView {
                CisContentView()
                    .navigationBarTitle("CIS", displayMode: .inline)
            }
            .tabItem {
                Image(systemName: "2.circle.fill")
                Text("CIS")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ElectaContentView() // Use ElectaContentView instead of ContentView
    }
}


// Define ElectaContentView by copying your existing ContentView code here
struct ElectaContentView: View {
    var body: some View {
        VStack {
            Text("Elecciones Generales 2027")
                .font(.title)
                .padding(.top, 20)
                .padding(.bottom, 20)

            PieChartView(dataPoints: [
                DataPoint(value: 40, label: "PSOE", color: Color.red),
                DataPoint(value: 30, label: "PP", color: Color.blue),
                DataPoint(value: 20, label: "VOX", color: Color.green),
                DataPoint(value: 25, label: "PNV", color: Color.init(red: 0.0, green: 0.5, blue: 0.0)),
                DataPoint(value: 15, label: "Bildu", color: Color.init(red: 0.5, green: 1.0, blue: 0.5)),
                DataPoint(value: 4, label: "ERC", color: Color.yellow),
                DataPoint(value: 34, label: "Sumar", color: Color.purple),
            ])
            .padding(.bottom, -150.0)

            Text("Distribución de escaños")
                .font(.headline)
                .padding(.bottom, 10)

            // Sort dataPoints array before passing it to PartyList
            let sortedDataPoints = [
                DataPoint(value: 40, label: "PSOE", color: Color.red),
                DataPoint(value: 30, label: "PP", color: Color.blue),
                DataPoint(value: 20, label: "VOX", color: Color.green),
                DataPoint(value: 25, label: "PNV", color: Color.init(red: 0.0, green: 0.5, blue: 0.0)),
                DataPoint(value: 15, label: "Bildu", color: Color.init(red: 0.5, green: 1.0, blue: 0.5)),
                DataPoint(value: 4, label: "ERC", color: Color.yellow),
                DataPoint(value: 34, label: "Sumar", color: Color.purple),
            ].sorted(by: { $0.value > $1.value }) // Sort the data points

            PartyList(dataPoints: sortedDataPoints)
            .padding(.bottom, 20)
        }
    }
}


struct CisContentView: View {
    var body: some View {
        VStack {
            Text("Elecciones Generales 2027")
                .font(.title)
                .padding(.top, 20)
                .padding(.bottom, 20)

            PieChartView(dataPoints: [
                DataPoint(value: 37, label: "PSOE", color: Color.red),
                DataPoint(value: 32, label: "PP", color: Color.blue),
                DataPoint(value: 23, label: "VOX", color: Color.green),
                DataPoint(value: 21, label: "PNV", color: Color.init(red: 0.0, green: 0.5, blue: 0.0)),
                DataPoint(value: 13, label: "Bildu", color: Color.init(red: 0.5, green: 1.0, blue: 0.5)),
                DataPoint(value: 8, label: "ERC", color: Color.yellow),
                DataPoint(value: 40, label: "Sumar", color: Color.purple),
            ])
            .padding(.bottom, -130)

            Text("Distribución de escaños")
                .font(.headline)
                .padding(.bottom, 10)

            // Sort dataPoints array before passing it to PartyList
            let sortedDataPoints = [
                DataPoint(value: 37, label: "PSOE", color: Color.red),
                DataPoint(value: 32, label: "PP", color: Color.blue),
                DataPoint(value: 23, label: "VOX", color: Color.green),
                DataPoint(value: 21, label: "PNV", color: Color.init(red: 0.0, green: 0.5, blue: 0.0)),
                DataPoint(value: 13, label: "Bildu", color: Color.init(red: 0.5, green: 1.0, blue: 0.5)),
                DataPoint(value: 8, label: "ERC", color: Color.yellow),
                DataPoint(value: 40, label: "Sumar", color: Color.purple),
            ].sorted(by: { $0.value > $1.value }) // Sort the data points

            PartyList(dataPoints: sortedDataPoints)
            .padding(.bottom, 20)
        }
    }
}



struct DataPoint: Identifiable {
    let id = UUID()  // Add a unique identifier
    let value: Double
    let label: String
    let color: Color
}


struct PieChartView: View {
    let dataPoints: [DataPoint]

    var body: some View {
        ZStack {
            HalfPieChart(dataPoints: dataPoints)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .frame(height: 330) // Adjust the frame height as needed
        }
    }
}


struct HalfPieChart: View {
    var dataPoints: [DataPoint]
    let innerRadius: CGFloat = 70

    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            // Increase the outer radius here
            let outerRadius: CGFloat = min(geometry.size.width, geometry.size.height) / 1.8
            
            let startAngle: Angle = .degrees(180) // Start at 0 degrees
            let endAngle: Angle = .degrees(360) // Half of a circle is 180 degrees
            let segments = createSegments(startAngle: startAngle, endAngle: endAngle)

            ForEach(segments, id: \.self) { segment in
                ZStack {
                    Path { path in
                        path.move(to: CGPoint(x: center.x + outerRadius * CGFloat(cos(segment.startAngle.radians)),
                                              y: center.y + outerRadius * CGFloat(sin(segment.startAngle.radians))))
                        path.addArc(center: center, radius: outerRadius, startAngle: segment.startAngle, endAngle: segment.endAngle, clockwise: false)

                        path.addLine(to: CGPoint(x: center.x + innerRadius * CGFloat(cos(segment.endAngle.radians)),
                                                  y: center.y + innerRadius * CGFloat(sin(segment.endAngle.radians))))
                        path.addArc(center: center, radius: innerRadius, startAngle: segment.endAngle, endAngle: segment.startAngle, clockwise: true)
                    }
                    .fill(segment.color)

                }
            }
        }
    }


    private func createSegments(startAngle: Angle, endAngle: Angle) -> [PieSegment] {
        let sortedDataPoints = dataPoints.sorted(by: { $0.value > $1.value })
        let totalValue = sortedDataPoints.reduce(0) { $0 + $1.value }
        var currentStartAngle: Angle = startAngle
        return sortedDataPoints.map { dataPoint in
            let segment = PieSegment(
                startAngle: currentStartAngle,
                endAngle: currentStartAngle + .degrees(180 * (dataPoint.value / totalValue)), // Half-circle is 180 degrees
                color: dataPoint.color,
                value: dataPoint.value
            )
            currentStartAngle += .degrees(180 * (dataPoint.value / totalValue))
            return segment
        }
    }
}

struct PieChartSegment: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let radius: CGFloat
    let center: CGPoint

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        return path
    }
}

struct PieSegment: Hashable {
    let startAngle: Angle
    let endAngle: Angle
    let color: Color
    let value: Double // Add the value property

    init(startAngle: Angle, endAngle: Angle, color: Color, value: Double) {
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.color = color
        self.value = value
    }
}


struct PartyList: View {
    let dataPoints: [DataPoint]

    var body: some View {
        List(dataPoints, id: \.label) { dataPoint in
            HStack {
                Text(dataPoint.label)
                    .foregroundColor(dataPoint.color)  // Apply the color to the text
                Spacer()
                Text("\(Int(dataPoint.value))")
            }
        }
    }
}

