import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var swiftTook: UITextField!
    @IBOutlet weak var objcTook: UITextField!
    @IBOutlet weak var rustTook: UITextField!

    @IBAction func recalculate(_ sender: AnyObject) {
        print("Recalculating")
        updateCalculations()
    }

    func doCalculation(_ language: String, vector1: [Double], vector2: [Double], function: ([Double], [Double]) -> Double) -> String {
        let startTime = CFAbsoluteTimeGetCurrent()
        let result = function(vector1, vector2)
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("\(language) : \(result)")
        return "\(floor(timeElapsed * 1000)) ms"
    }

    func updateCalculations() {
        let vector1: [Double] = generateRandomArrayOfSize(1000000)
        let vector2: [Double] = generateRandomArrayOfSize(1000000)

        objcTook.text = ""
        swiftTook.text = ""
        rustTook.text = ""

        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            let objctext = self.doCalculation("Obj-c", vector1: vector1, vector2: vector2) {
                (v1: [Double], v2: [Double]) -> Double in
                ObjectiveUtil.dotProduct(v1, vector2: v2)
            }
            DispatchQueue.main.async {
                self.objcTook.text = objctext
            }
        }

        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            let swifttext = self.doCalculation("Swift", vector1: vector1, vector2: vector2, function: dotProduct)
            DispatchQueue.main.async {
                self.swiftTook.text = swifttext
            }
        }

        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            let rusttext = self.doCalculation("Rust ", vector1: vector1, vector2: vector2) {
                (v1: [Double], v2: [Double]) -> Double in
                let cArray1 = UnsafePointer<Double>(vector1)
                let cArray2 = UnsafePointer<Double>(vector2)
                return rust_dot_product(cArray1, cArray2, v1.count)
            }
            DispatchQueue.main.async {
                self.rustTook.text = rusttext
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateCalculations()
    }

}
