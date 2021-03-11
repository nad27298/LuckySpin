//
//  HomePageVC.swift
//  RotationLucky
//
//  Created by Macbook on 2/5/21.
//

import UIKit
import Charts

class HomePageVC: UIViewController, SmartDelegate {

    @IBOutlet weak var pieChart: PieChartView!
    
    var rotateData = [RotateModel]()
    
    var timer:Timer!
    var goc: Int = 0
    var isPlaying: Bool = false
    var x: Int = 0
    var index: Int = 0
    
    var chart1 = PieChartDataEntry()
    var chart2 = PieChartDataEntry()
    var chart3 = PieChartDataEntry()
    var chart4 = PieChartDataEntry()
    var chart5 = PieChartDataEntry()
    var chart6 = PieChartDataEntry()
    var chart7 = PieChartDataEntry()
    
    var allchart = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateData = RotateEntity.shared.getData()
        if rotateData.count == 0 {
            RotateEntity.shared.insertData("10$", "20$", "50$", "100$", "200$", "500$", "1000$")
        }
        pieChart.chartDescription?.text = ""
        pieChart.holeRadiusPercent = 0.1
        pieChart.drawCenterTextEnabled = true
        pieChart.holeColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        pieChart.centerText = "R"
        pieChart.entryLabelColor = .black
        pieChart.setExtraOffsets(left: 0, top: 20, right: 0, bottom: 0)
        pieChart.entryLabelFont = UIFont(name: "Futura Medium", size: 13)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rotateData = RotateEntity.shared.getData()
        chart1 = PieChartDataEntry(value: 1, label: rotateData[index].name1)
        chart2 = PieChartDataEntry(value: 1, label: rotateData[index].name2)
        chart3 = PieChartDataEntry(value: 1, label: rotateData[index].name3)
        chart4 = PieChartDataEntry(value: 1, label: rotateData[index].name4)
        chart5 = PieChartDataEntry(value: 1, label: rotateData[index].name5)
        chart6 = PieChartDataEntry(value: 1, label: rotateData[index].name6)
        chart7 = PieChartDataEntry(value: 1, label: rotateData[index].name7)
        allchart = [chart1, chart2, chart3, chart4, chart5, chart6, chart7]
        updateChart()
    }
    
    func updateAnswer(_ answer: Int) {
        index = answer
    }
    
    func updateChart() {
        let chartDataSet = PieChartDataSet(entries: allchart)
        let chartData = PieChartData(dataSet: chartDataSet)
        let color = [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.7125640703, green: 0.6598314757, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.379232008, blue: 0.3438969326, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.873854878, blue: 0.3550228174, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.9376247697, blue: 0.6711843351, alpha: 1)]
        chartDataSet.colors = color
        chartDataSet.valueTextColor = .clear
        pieChart.data = chartData
    }
    
    @IBAction func btn_Rotate(_ sender: Any) {
        if isPlaying == false {
            isPlaying = true
            let randomInt = Int.random(in: 130...180)
            timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (time) in
                self.goc += (randomInt - self.x)
                self.x += 1
                self.pieChart.transform = CGAffineTransform(rotationAngle: (CGFloat(self.goc) * .pi) / 180)
                if (randomInt - self.x) == 0 {
                    self.timer.invalidate()
                    self.timer = nil
                    self.isPlaying = false
                    self.goc = 0
                    self.x = 0
                }
            })
        } else {
            self.showMessage("Running ...")
        }
    }
    
    @IBAction func btn_Next(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rotatelist = storyboard.instantiateViewController(withIdentifier: RotateListVC.className) as! RotateListVC
        rotatelist.rotatelistData = rotateData
        rotatelist.delegate = self
        self.present(rotatelist, animated: true, completion: nil)
    }
    
}
