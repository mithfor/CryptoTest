//
//  ChartViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 02.03.2023.
//

import Charts
import UIKit

class ChartViewController: UIViewController {

    private let lineChart = LineChartView()
    
//    var yValues: [ChartDataEntry] = [
//        ChartDataEntry(x: 0, y: 0),
//        ChartDataEntry(x: 1, y: 4),
//        ChartDataEntry(x: 2, y: 6),
//        ChartDataEntry(x: 3, y: 8),
//        ChartDataEntry(x: 4, y: 100),
//        ChartDataEntry(x: 5, y: 6),
//        ChartDataEntry(x: 6, y: 7),
//        ChartDataEntry(x: 7, y: 8),
//        ChartDataEntry(x: 8, y: 50),
//        ChartDataEntry(x: 9, y: 0)
//
//    ]
    
    var yValues = [ChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createChart()
    }
    

    private func createChart() {
        //create bar chart
        setupChartConstraints()
        
        //supply data
        setupData()
        
        //configure the axis
        lineChart.rightAxis.enabled = false
        lineChart.leftAxis.enabled = false
        lineChart.drawGridBackgroundEnabled = false
        
        lineChart.xAxis.enabled = false
        lineChart.animate(xAxisDuration: 1)
        
        //configure legend
        


    }
    
    private func setupChartConstraints() {
        view.addSubview(lineChart)
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.pinToEdges(of: view)
        
        lineChart.center = view.center
    }
    
    private func setupData() {
        

//        var entries = [LineChartData]()
        
        let set = LineChartDataSet(entries: yValues, label: "VALUE")
        
        set.drawCirclesEnabled = false
        set.mode = .cubicBezier
        set.lineWidth = 1
        set.setColor(.black)
        
        let data = LineChartData(dataSet: set)
        
        data.setDrawValues(false)
        lineChart.data = data
    }
}


