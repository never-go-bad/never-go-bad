
import UIKit


//@objc protocol DieteryConsiderationCellDelegate {
//    optional func dieteryConsiderationCell(dieteryConsiderationCell: DieteryConsiderationCell, didChangeValue value: Bool)
//}

class DieteryConsiderationCell: UITableViewCell, CheckboxDelegate {
    
    //weak var delegate: DieteryConsiderationCellDelegate?
    
    @IBOutlet weak var dieteryConsiderationLabel: UILabel!
    @IBOutlet weak var checkbox: Checkbox!
    
    var dieteryConsideration: DieteryConsideration? {
        didSet{
            self.dieteryConsiderationLabel.text = dieteryConsideration!.displayName
            self.checkbox.isChecked = SettingsService.getDieteryConsideration(dieteryConsideration!.dietType)
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // self.view.addSubview(onSwitch)
        checkbox.delegate = self
        checkbox.checkedImage = UIImage(named: "checkbox-checked-red")
        checkbox.uncheckedImage = UIImage(named: "checkbox-unchecked")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func checkbox(sender: Checkbox, didValueChange value: Bool) {
        if(self.dieteryConsideration != nil) {
            self.dieteryConsideration!.selected = value
            SettingsService.setDieteryConsideration(dieteryConsideration!.dietType, value: value)
            NSNotificationCenter.defaultCenter().postNotificationName(notificationFoodListDidChange, object: nil)
        }
    }
}