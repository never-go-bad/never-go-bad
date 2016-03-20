
import UIKit


@objc protocol DieteryConsiderationCellDelegate {
    optional func dieteryConsiderationCell(dieteryConsiderationCell: DieteryConsiderationCell, didChangeValue value: Bool)
}

class DieteryConsiderationCell: UITableViewCell {
    
    weak var delegate: DieteryConsiderationCellDelegate?
    
    @IBOutlet weak var dieteryConsiderationLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    //@IBOutlet weak var onSwitch: SevenSwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // self.view.addSubview(onSwitch)
        onSwitch.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    //
    func switchValueChanged()
    {
        print ("Switch value changed")
       delegate!.dieteryConsiderationCell?(self, didChangeValue: onSwitch.on)
    }
}