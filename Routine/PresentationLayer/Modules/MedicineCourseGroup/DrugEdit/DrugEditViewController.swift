import UIKit

final class DrugEditViewController: RoutineViewController {
    var output: DrugEditViewOutput!
    
    private var tableViewModel = { () -> RoutineTableViewModel in
        return RoutineTableViewModel()
    }()
    
    weak private var tableView: RoutineTableView<RoutineTableViewModel>!
    
    private var cellViewModels: [RoutineTableViewCellViewModel] {
        return self.cellViewModelsBeforeTimes + self.cellViewModelsTimes + self.cellViewModelsAfterTimes
    }
    
    private var cellViewModelsBeforeTimes: [RoutineTableViewCellViewModel] = []
    private var cellViewModelsAfterTimes: [RoutineTableViewCellViewModel] = []
    private var cellViewModelsTimes: [RoutineTableViewCellViewModel] = []
    
    private var tableViewManager: UniversalTableViewManager!
    
    weak private var modalView: StandartModalView!
    weak private var drugtypePickerView: StandartPickerView!
    weak private var drugunitPickerView: StandartPickerView!
    weak private var startDatePickerView: StandartDatePickerView!
    
    weak private var usageTimePickerView: StandartDatePickerView!
    
    private var timeIndex: Int!
    
    var moduleService: ModuleServiceInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = RoutineTableView()
        self.view.sv(
            tableView
        )
        self.tableView = tableView
        
        self.tableView.configureView(config: self.tableViewModel)
        
        self.tableView.fillContainer()
        
        self.output.didTriggerViewReadyEvent()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.output.didTriggerViewWillAppear()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func localizationSetup() {
        super.localizationSetup()
    }
    
    @objc private func backButtonPressed() {
        self.output.closeModule()
    }
    
    @objc private func deleteButtonPressed() {
        self.output.deleteButtonAction()
    }
    
    @objc func createDrug() {
        self.output.acceptDrug()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.tableView.bottomConstraint?.constant = -keyboardHeight
            })
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.tableView.bottomConstraint?.constant = 0
        })
    }
}

// MARK: - DrugEditViewInput
extension DrugEditViewController: DrugEditViewInput {
    func setupInitialState(editMode: DrugEditMode) {
        self.navigationController?.configureNavigationBarWithColor(ColorProvider.default.blueColor)
        self.customBarLeftButtonAction(icon: ImageProvider.default.backArrow.imageWithMask(color: ColorProvider.default.whiteColor), action: #selector(backButtonPressed))
        self.customBarRightButtonAction(icon: ImageProvider.drugEditImages.agreeIcon, action: #selector(createDrug))
        
        self.tableViewManager = UniversalTableViewManager(tableView: self.tableView, delegate: self)
        
    }
    
    func updateNavTitle(_ text: String) {
        self.navigationItem.title = text
    }
    
    func updateTableView(model: MedicineDrug?, editMode: DrugEditMode) {
        self.cellViewModelsBeforeTimes = DrugEditTableViewFactory.makeCellViewModelsBeforeTimes(model: model, delegate: self)
        self.cellViewModelsTimes = DrugEditTableViewFactory.makeTimeCellViewModel(model: model, delegate: self)
        self.cellViewModelsAfterTimes = DrugEditTableViewFactory.makeCellObjectsAfterTimes(model: model, delegate: self, editMode: editMode)
        self.tableViewManager.configure(cellViewModels: self.cellViewModels)
    }
    
    func updateDrugType(_ type: MedicineType?) {
        
        var newText: String = ""
        if let type = type {
            newText = type.toString()
        }

        for (index, cellViewModel) in self.cellViewModels.enumerated() {
            guard let cellViewModel = cellViewModel as? TwiceComboboxCellViewModel else { continue }
            if cellViewModel.leftCombobox.viewName == "drug_type" {
                cellViewModel.leftCombobox.textFieldViewModel.text = newText
                self.tableViewManager.configure(cellViewModels: self.cellViewModels, reloadData: false)
                self.tableViewManager.updateRowAtIndex(index)
                break
            }
        }
    }
    
    func updateDrugUnit(_ type: MedicineUnit?) {
        
        var newText: String = ""
        if let type = type {
            newText = type.toString()
        }
        
        for (index, cellViewModel) in self.cellViewModels.enumerated() {
            
            guard let cellViewModel = cellViewModel as? TwiceComboboxCellViewModel else { continue }
            if cellViewModel.rightCombobox.viewName == "drug_unit" {
                cellViewModel.rightCombobox.textFieldViewModel.text = newText
                self.tableViewManager.configure(cellViewModels: self.cellViewModels, reloadData: false)
                self.tableViewManager.updateRowAtIndex(index)
                break
            }
            
        }

    }
    
    func updateStartDate(_ date: Date) {
        
        for (index, cellViewModel) in self.cellViewModels.enumerated() {
            
            guard let cellViewModel = cellViewModel as? TwiceComboboxCellViewModel else { continue }
            if cellViewModel.leftCombobox.viewName == "start_using" {
                cellViewModel.leftCombobox.textFieldViewModel.text = date.format(with: "dd.MM.yyyy")
                self.tableViewManager.configure(cellViewModels: self.cellViewModels, reloadData: false)
                self.tableViewManager.updateRowAtIndex(index)
                break
            }
        }
        
    }
    
    func updateEndingTime(_ value: String) {
        
        for (index, cellViewModel) in self.cellViewModels.enumerated() {
            
            guard let cellViewModel = cellViewModel as? TwiceComboboxCellViewModel else { continue }
            if cellViewModel.rightCombobox.viewName == "end_using" {
                cellViewModel.rightCombobox.textFieldViewModel.text = value
                self.tableViewManager.configure(cellViewModels: self.cellViewModels, reloadData: false)
                self.tableViewManager.updateRowAtIndex(index)
                break
            }
        }
        
    }
    
    func updatePeriodTime(_ value: String) {
        
        for (index, cellViewModel) in self.cellViewModels.enumerated() {
            
            guard let cellViewModel = cellViewModel as? ComboboxCellViewModel else { continue }
            if cellViewModel.combobox.viewName == "periodic" {
                cellViewModel.combobox.textFieldViewModel.text = value
                self.tableViewManager.configure(cellViewModels: self.cellViewModels, reloadData: false)
                self.tableViewManager.updateRowAtIndex(index)
                break
            }
            
        }
        
    }
    
    func openModal(view: UIView, completion: @escaping (Bool, StandartModalView) -> Void) {
        
        
        if self.modalView == nil {
            let modalView = StandartModalView()
            modalView.delegate = self
            
            modalView.frame = CGRect.zero
            
            self.modalView = modalView
            
            if !self.modalView.isDescendant(of: view) {
                view.addSubview(self.modalView)
                self.modalView.layoutIfNeeded()
            }
        }
        
        self.hideKeyboard()
        
        self.showModalAnimate(self.modalView, toFrame: view.bounds) { [unowned self] (isCompletion) in
            completion(isCompletion, self.modalView)
        }
        
    }
    
    func closeModal(completion: @escaping (Bool) -> Void) {
        
        self.closeModalAnimate(self.modalView) { (isCompletion) in
            completion(isCompletion)
        }
        
    }
}

// MARK: - UniversalTableViewManager
extension DrugEditViewController: UniversalTableViewManagerDelegate {
    func didTriggerCell(index: Int, actionType: TriggerActionType) {
        
        if actionType != .select {
            return
        }
        
        let cellViewModel = self.cellViewModels[index]
        
        self.hideAllPickers()
        self.hideKeyboard()
        
        // FIXME: - перенести всю логику добавления строк в презентер
        if cellViewModel.viewName == "add_times_view_model" {
            if actionType == .deselect { return }
            
            // не позволяем добавлять время приема, если не введено значение
            let prevCellViewModel = self.cellViewModels[index-1]
            if prevCellViewModel.viewName == "using_times_cell" {
                if let prevCellViewModel = prevCellViewModel as? UsingTimesCellViewModel {
                    if prevCellViewModel.countField.text.count == 0 {
                        return
                    }
                }
            }
            
            self.cellViewModelsTimes += [DrugEditTableViewFactory.makeTimeCellViewModel(index: self.cellViewModelsTimes.count + 1, delegate: self)]
            self.tableViewManager.configure(cellViewModels: self.cellViewModels, reloadData: false)
            self.tableViewManager.insertRowToIndex(self.cellViewModelsBeforeTimes.count - 1 + self.cellViewModelsTimes.count)
            
            self.output.usageTimeAdd()
        }
        
        self.output.rowDidPressed(index: index)
    }
}

// MARK: - UsingTimesCellViewModelDelegate
extension DrugEditViewController: UsingTimesCellViewModelDelegate {
    
    func timeStartEdited(sender: UsingTimesCellViewModel) {
        
        self.timeIndex = self.cellViewModelsTimes.indexOf(sender)
        
        guard let usageTimePickerView = self.usageTimePickerView else {
            let usageTimePickerView = StandartDatePickerView(frame: self.view.bounds, delegate: self, leftTitle: AppDelegate.serviceProvider.makeStringService().localizeById("back_string"), rightTitle: AppDelegate.serviceProvider.makeStringService().localizeById("ok_string"), datePickerMode: .time)
            self.view.addSubview(usageTimePickerView)
            self.usageTimePickerView = usageTimePickerView
            self.hideKeyboard()
            return
        }
        self.hideKeyboard()
        self.view.addSubview(usageTimePickerView)
        
    }
    
    func textChanged(sender: UsingTimesCellViewModel) {
        self.timeIndex = self.cellViewModelsTimes.indexOf(sender)
        
        let value = sender.countField.text.doubleValue
        self.output.usageTimeChanged(index: self.timeIndex, value: value)
    }
    
}

// MARK: - TextFieldCellProtocol
extension DrugEditViewController: TextFieldCellProtocol {

    func textChanged(object: RoutineTextFieldViewModel, newValue: String) {
        self.output.drugNameChanged(newValue)
    }
    
}

// MARK: - TextAreaCellProtocol
extension DrugEditViewController: TextAreaCellProtocol {
    
    func textBeginEdited(object: RoutineTextViewModel) {
        
        for (index, cellViewModel) in self.cellViewModels.enumerated() {
            
            guard let cellViewModel = cellViewModel as? TextAreaCellViewModel else { continue }
            if cellViewModel.textAreaConfiguration.viewName == "comment_textarea" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.tableViewManager.scrollToIndex(index, scrollPosition: .bottom, animated: true)
                }
                break
            }
            
        }
        
    }
    
    func textChanged(object: RoutineTextViewModel, newValue: String) {
        self.textAreaHandler(object, newText: newValue)
    }
    
}

// MARK: - StandartModalViewDelegate
extension DrugEditViewController: StandartModalViewDelegate {
    
    func didTriggerCloseModalAction(modal: StandartModalView) {
        
        self.closeModalAnimate(self.modalView) { (_) in }
        
    }
    
}

// MARK: - SingleButtonCellProtocol
extension DrugEditViewController: SingleButtonCellProtocol {
    
    func buttonDidPressed(sender: RoutineButton<RoutineButtonViewModel>) {
        self.buttonsHandler(sender)
    }
    
}

// MARK: - TwiceComboboxCellProtocol
extension DrugEditViewController: TwiceComboboxCellProtocol {
    
    func expandLeft(viewModel: RoutineComboboxViewModel) {
        self.comboboxHandler(viewModel)
    }
    
    func expandRight(viewModel: RoutineComboboxViewModel) {
        self.comboboxHandler(viewModel)
    }
    
}

// MARK: - ComboboxCellProtocol
extension DrugEditViewController: ComboboxCellProtocol {
    
    func expand(viewModel: RoutineComboboxViewModel) {
        self.comboboxHandler(viewModel)
    }
    
}

// MARK: - StandartPickerDelegate
extension DrugEditViewController: StandartPickerDelegate {
    
    func leftButtonAction(_ pickerView: StandartPickerView) {
        pickerView.removeFromSuperview()
    }
    
    func rightButtonAction(_ pickerView: StandartPickerView) {
        self.standartPickerView(pickerView, didSelectRow: pickerView.pickerView.selectedRow(inComponent: 0))
        pickerView.removeFromSuperview()
    }
    
    func standartPickerView(_ pickerView: StandartPickerView, didSelectRow row: Int) {
        
        if pickerView == self.drugtypePickerView {
            self.output.drugTypeChanged(row)
            
        } else if pickerView == self.drugunitPickerView {
            self.output.drugUnitChanged(row)
        }
        
    }
    
}

// MARK: - StandartDatePickerViewDelegate
extension DrugEditViewController: StandartDatePickerViewDelegate {
    
    func leftButtonAction(_ pickerView: StandartDatePickerView) {
        pickerView.removeFromSuperview()
    }
    
    func rightButtonAction(_ pickerView: StandartDatePickerView) {
        self.standartDatePickerViewDelegate(pickerView, didSelectDate: pickerView.date)
        pickerView.removeFromSuperview()
    }
    
    func standartDatePickerViewDelegate(_ datePickerView: StandartDatePickerView, didSelectDate date: Date) {
        if datePickerView == self.startDatePickerView {
            self.output.startDateChanged(date)
        } else if datePickerView == self.usageTimePickerView {
            self.output.usageTimeChanged(index: self.timeIndex, date: date)
            guard let cellViewModel = self.cellViewModelsTimes[self.timeIndex] as? UsingTimesCellViewModel else { return }
            
            // FIXME: -
            var time = Time()
            time.setTime(milisec: Int(date.timeIntervalFromStartDay))
            
            cellViewModel.timesBox.textFieldViewModel.text = time.toString()
            self.tableViewManager.updateRowAtIndex(self.cellViewModelsBeforeTimes.count + self.timeIndex)
        }
    }
    
}

// MARK: - Private part
extension DrugEditViewController {
    
    private func showModalAnimate(_ modal: StandartModalView, toFrame: CGRect, completion: @escaping (Bool) -> Void) {
        
        modal.center = CGPoint(x: toFrame.width/2, y: toFrame.height/2)
        for element in modal.modalContainer.subviews {
            element.alpha = 0.0
        }
        
        modal.bounds = CGRect.zero
        
        self.view.setNeedsDisplay()
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseIn, animations: {
            
            modal.center = CGPoint(x: toFrame.width/2, y: toFrame.height/2)
            modal.bounds = toFrame
            modal.layoutIfNeeded()
            
        }, completion: { [unowned modal] (isCompletion) in
            
            for element in modal.modalContainer.subviews {
                element.alpha = 1.0
            }
            
            completion(isCompletion)
            
        })
        
    }
    
    private func closeModalAnimate(_ modal: StandartModalView, completion: @escaping (Bool) -> Void) {
        
        for element in modal.modalContainer.subviews {
            element.alpha = 0.0
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            
            modal.bounds = CGRect.zero
            modal.layoutSubviews()
            
        }, completion: { (isCompletion) in
            
            completion(isCompletion)
            
        })
        
    }
    
    private func buttonsHandler(_ button: RoutineButton<RoutineButtonViewModel>) {
        
        switch button.viewName {
            
        case "delete_button":
            self.output.deleteButtonAction()
            
        default: break
            
        }
        
    }
    
    private func comboboxHandler(_ viewModel: RoutineComboboxViewModel) {
        
        switch viewModel.viewName {
            
        case "drug_type":
            guard let drugtypePickerView = self.drugtypePickerView else {
                let list = self.output.obtainTypeList()
                let drugtypePickerView = StandartPickerView(models: list, currentValue: viewModel.textFieldViewModel.text, frame: self.view.bounds, delegate: self, leftTitle: AppDelegate.serviceProvider.makeStringService().localizeById("back_string"), rightTitle: AppDelegate.serviceProvider.makeStringService().localizeById("ok_string"))
                self.view.addSubview(drugtypePickerView)
                self.drugtypePickerView = drugtypePickerView
                self.hideKeyboard()
                return
            }
            self.hideKeyboard()
            self.view.addSubview(drugtypePickerView)
            
        case "drug_unit":
            guard let drugunitPickerView = self.drugunitPickerView else {
                let list = self.output.obtainUnitList()
                let drugunitPickerView = StandartPickerView(models: list, currentValue: viewModel.textFieldViewModel.text, frame: self.view.bounds, delegate: self, leftTitle: AppDelegate.serviceProvider.makeStringService().localizeById("back_string"), rightTitle: AppDelegate.serviceProvider.makeStringService().localizeById("ok_string"))
                self.view.addSubview(drugunitPickerView)
                self.drugunitPickerView = drugunitPickerView
                self.hideKeyboard()
                return
            }
            self.hideKeyboard()
            self.view.addSubview(drugunitPickerView)
            
        case "start_using":
            guard let startDatePickerView = self.startDatePickerView else {
                let startDatePickerView = StandartDatePickerView(frame: self.view.bounds, delegate: self, leftTitle: AppDelegate.serviceProvider.makeStringService().localizeById("back_string"), rightTitle: AppDelegate.serviceProvider.makeStringService().localizeById("ok_string"))
                self.view.addSubview(startDatePickerView)
                self.startDatePickerView = startDatePickerView
                self.hideKeyboard()
                return
            }
            self.hideKeyboard()
            self.view.addSubview(startDatePickerView)
            
        case "end_using":
            self.hideKeyboard()
            self.output?.endUsingDidPressed()
            
        case "periodic":
            self.hideKeyboard()
            self.output?.periodicDidPressed()
            
        default: break
            
        }
        
    }
    
    private func textAreaHandler(_ textArea: RoutineTextViewModel, newText: String) {
        
        switch textArea.viewName {
        case "comment_textarea":
            self.output.drugCommentChanged(newText)
        default: break
        }
        
    }
    
    private func hideKeyboard() {
        
        for index in self.cellViewModels.indices {
            
            guard let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) else { continue }
            if let cell = cell as? TextFieldCell {
                cell.textField.resignFirstResponder()
            } else if let cell = cell as? UsingTimesCell {
                cell.countField.resignFirstResponder()
            }
            
        }
        
    }
    
    private func hideAllPickers() {
        
        self.drugtypePickerView?.removeFromSuperview()
        self.drugunitPickerView?.removeFromSuperview()
        self.startDatePickerView?.removeFromSuperview()
        self.usageTimePickerView?.removeFromSuperview()
        
    }
    
}
