//
//  ChartViewController.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 02.03.2023.
//

import Charts
import UIKit

protocol Updateable {
    func updateLineChart()
}

class ChartViewController: UIViewController {

    private let lineChartView = LineChartView()
    
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
    var maxY: Double?
    var minY: Double?
    
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
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.drawGridBackgroundEnabled = false
        
        lineChartView.xAxis.enabled = false
        lineChartView.animate(xAxisDuration: 1)
        
        //configure legend
    }
    
    private func setupChartConstraints() {
        view.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.pinToEdges(of: view)
        
        lineChartView.center = view.center
    }
    
    private func setupData() {
        

//        var entries = [LineChartData]()
        
        
        
        let lineChartDataSet = LineChartDataSet(entries: yValues, label: "VALUE")
        
        maxY = lineChartDataSet.yMax
        minY = lineChartDataSet.yMin
        
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.mode = .cubicBezier
        lineChartDataSet.lineWidth = 1
        lineChartDataSet.setColor(.black)
        
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        
        lineChartView.legend.enabled = false
        
        lineChartView.data = lineChartData
        
        lineChartView.renderer = ChartRenderer(view: lineChartView,
                                               minValue: minY ?? 0.0,
                                               maxValue: maxY ?? 0.0)
    }
}

extension ChartViewController: Updateable {
    func updateLineChart() {
        setupData()
    }
}


