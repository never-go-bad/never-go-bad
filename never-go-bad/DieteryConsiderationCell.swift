
import UIKit


//@objc protocol DieteryConsiderationCellDelegate {
//    optional func dieteryConsiderationCell(dieteryConsiderationCell: DieteryConsiderationCell, didChangeValue value: Bool)
//}

class DieteryConsiderationCell: UITableViewCell {
    
    //weak var delegate: DieteryConsiderationCellDelegate?
    
    @IBOutlet weak var dieteryConsiderationLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    
    var dieteryConsideration: DieteryConsideration? {
        didSet{
            self.dieteryConsiderationLabel.text = dieteryConsideration!.displayName
            self.onSwitch.on = SettingsService.getDieteryConsideration(dieteryConsideration!.dietType)
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // self.view.addSubview(onSwitch)
        onSwitch.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func switchValueChanged()
    {
        if(self.dieteryConsideration != nil) {
            self.dieteryConsideration!.selected = onSwitch.on
            SettingsService.setDieteryConsideration(dieteryConsideration!.dietType, value: onSwitch.on)
            NSNotificationCenter.defaultCenter().postNotificationName(notificationFoodListDidChange, object: nil)

        }
    }
}