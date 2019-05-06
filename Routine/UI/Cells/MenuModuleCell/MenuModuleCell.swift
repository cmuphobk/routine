import UIKit

final class MenuModuleCell: RoutineTableViewCell<MenuModuleCellViewModel> {
    
    @IBOutlet weak var label: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.label.text = self.viewModel.text
        self.label.font = self.viewModel.isSelected ? FontProvider.menuFonts.selectedMenu : FontProvider.menuFonts.menu
        self.label.textColor = ColorProvider.default.whiteColor
    }
    
}
