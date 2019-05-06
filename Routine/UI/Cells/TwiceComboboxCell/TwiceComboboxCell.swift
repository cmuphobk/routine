import UIKit
import Stevia

final class TwiceComboboxCell: RoutineTableViewCell<TwiceComboboxCellViewModel> {

    weak var leftCombobox: RoutineCombobox!
    weak var rightCombobox: RoutineCombobox!
    weak var delimiter: RoutineView<RoutineViewModel>!
    
    override func setupView() {
        super.setupView()
        
        let leftCombobox = RoutineCombobox()
        let rightCombobox = RoutineCombobox()
        let delimiter = RoutineView()
        
        self.paddingView.sv(
            leftCombobox,
            delimiter,
            rightCombobox
        )
        
        self.leftCombobox = leftCombobox
        self.rightCombobox = rightCombobox
        self.delimiter = delimiter
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.delimiter.width(0)
        
        layout(
            0.0,
            self.leftCombobox,
            0.0
        )
        
        layout(
            0.0,
            self.rightCombobox,
            0.0
        )
        
        let delimiterPosition = self.frame.width * CGFloat(self.viewModel.betweenPosition)
        align(horizontally: |-delimiterPosition-self.delimiter)
        
        let betweenSpace = self.viewModel.betweenSpace / 2
        align(horizontally: |self.leftCombobox-betweenSpace-self.delimiter-betweenSpace-self.rightCombobox|)
    }
    
    override func updateLayout() {
        super.updateLayout()
        
        let delimiterPosition = self.frame.width * CGFloat(self.viewModel.betweenPosition)
        self.delimiter.leftConstraint?.constant = delimiterPosition
        
        let betweenSpace = self.viewModel.betweenSpace / 2
        self.leftCombobox.rightConstraint?.constant = -betweenSpace
        self.rightCombobox.leftConstraint?.constant = -betweenSpace
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let delimiterViewModel = RoutineViewModel()
        delimiterViewModel.backgroundColor = UIColor.clear
        self.delimiter.configureView(config: delimiterViewModel)
        
        self.leftCombobox.configureView(config: self.viewModel.leftCombobox)
        self.rightCombobox.configureView(config: self.viewModel.rightCombobox)
        
        self.leftCombobox.delegate = self
        self.rightCombobox.delegate = self
    }
    
    override func localizationSetup() {
        self.leftCombobox.textField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById( self.viewModel.leftCombobox.textFieldViewModel.placeholderText )
        self.rightCombobox.textField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById( self.viewModel.rightCombobox.textFieldViewModel.placeholderText )
    }
}

// MARK: UIComboboxDelegate
extension TwiceComboboxCell: RoutineComboboxDelegate {
    
    func comboboxDidPressed(viewModel: RoutineComboboxViewModel) {
        if viewModel == self.leftCombobox.viewModel {
            self.viewModel.delegate?.expandLeft(viewModel: viewModel)
        } else if viewModel == self.rightCombobox.viewModel {
            self.viewModel.delegate?.expandRight(viewModel: viewModel)
        }
    }
    
}
