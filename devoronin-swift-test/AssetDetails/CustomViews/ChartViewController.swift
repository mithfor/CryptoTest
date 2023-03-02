//
//  ChartViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 02.03.2023.
//

import Charts
import UIKit

class ChartViewController: UIViewController {

    private let barChart = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createChart()
    }
    

    private func createChart() {
        //create bar chart
        
        
        setupChartConstraints()
        
        //configure the axis
        
        //configure legend
        
        //supply data
        var entries = [BarChartDataEntry]()
        for x in 0..<10 {
            entries.append(BarChartDataEntry(x: Double(x),
                                             y: Double.random(in: 0...30)
            ))
        }
        
        let set = BarChartDataSet(entries: entries, label: "Cost")
        let data = BarChartData(dataSet: set)
        
        barChart.data = data
        
        view.addSubview(barChart)
        barChart.center = view.center
        

    }
    
    private func setupChartConstraints() {
        view.addSubview(barChart)
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.pinToEdges(of: view)
        
        barChart.center = view.center
    }

}


