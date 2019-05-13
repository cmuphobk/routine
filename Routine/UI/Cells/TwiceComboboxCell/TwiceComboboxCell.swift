import UIKit
import Stevia

final class TwiceComboboxCell: RoutineTableViewCell<TwiceComboboxCellViewModel> {

    lazy var leftCombobox = RoutineCombobox()
    lazy var rightCombobox = RoutineCombobox()
    lazy var delimiter = RoutineView()
    
    lazy var delimiterViewModel = { () -> (RoutineViewModel) in
        let delimiterViewModel = RoutineViewModel(routineDelegate: self.viewModel.routineDelegate)
        delimiterViewModel.backgroundColor = UIColor.clear
        return delimiterViewModel
    }()
    
    override func setupView() {
        super.setupView()
        
        self.paddingView.sv(
            self.leftCombobox,
            self.delimiter,
            self.rightCombobox
        )
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
        
        self.delimiter.configureView(config: delimiterViewModel)
        
        self.leftCombobox.configureView(config: self.viewModel.leftCombobox)
        self.rightCombobox.configureView(config: self.viewModel.rightCombobox)
        
        self.leftCombobox.delegate = self
        self.rightCombobox.delegate = self
    }
    
    override func localizationSetup() {
        self.leftCombobox.textField.placeholder = self.viewModel.routineDelegate?.localize(self.viewModel.leftCombobox.textFieldViewModel.placeholderText) ?? ""
        self.rightCombobox.textField.placeholder = self.viewModel.routineDelegate?.localize(self.viewModel.rightCombobox.textFieldViewModel.placeholderText) ?? ""
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
