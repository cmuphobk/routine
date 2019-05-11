import UIKit

protocol StandartPagePickerDelegate: class {
    func columnDidPressed(index: Int)
}

class StandartPagePicker: UIView {
    private var pages: Int = 1
    
    private var widthStandartPagePickerCell: CGFloat {
        return self.frame.width / CGFloat(pages)
    }
    private var rectSelectedView: CGRect {
        return CGRect(x: CGFloat(self.selectedIndex) * self.widthStandartPagePickerCell, y: self.height - 1.0, width: self.widthStandartPagePickerCell, height: 1.0)
    }

    private var pagesArray: [String]!
    private var height: CGFloat!
    private var font: UIFont!
    private var textColor: UIColor!
    private var cellsBackgroundColor: UIColor!
    
    weak var delegate: StandartPagePickerDelegate?
    
    var selectedIndex: NSInteger = 0
    
    weak var selectedView: UIView!
    weak var collectionView: RoutineCollectionView<RoutineCollectionViewModel>!
    
    var collectionViewLayout = UICollectionViewFlowLayout()
    
    var collectionViewManager: RoutineCollectionViewManager!
    
    func configureWithPagesNames(_ names: [String], height: CGFloat, font: UIFont, textColor: UIColor, cellsBackgroundColor: UIColor) {
        
        self.pagesArray = names
        self.pages = names.count
        self.height = height
        self.font = font
        self.textColor = textColor
        self.cellsBackgroundColor = cellsBackgroundColor
        
    }
    
    func selectColumnAtIndex(_ index: NSInteger) {
        
        self.selectedIndex = index
        
        if self.collectionViewManager != nil {
            self.collectionViewManager.selectRow(index)
            self.collectionViewManager.updateRowAtIndex(index)
        }
        
    }
    
    override func layoutSubviews() {
        
        if self.collectionView == nil {
            let collectionView = RoutineCollectionView(frame: self.frame, collectionViewLayout: self.collectionViewLayout)
            self.collectionView = collectionView
            
            if !self.collectionView.isDescendant(of: self) {
                self.addSubview(self.collectionView)
                
                self.collectionViewManager = RoutineCollectionViewManager(collectionView: self.collectionView, delegate: self)
                
                let size = CGSize(width: self.frame.width / CGFloat(self.pagesArray.count), height: self.height)
                let viewModels = StandartPagePickerCollectionViewFactory.standartPagePickerCellViewModels(models: self.pagesArray,
                                                                                                          size: size,
                                                                                                          font: self.font,
                                                                                                          textColor: self.textColor,
                                                                                                          backgroundColor: self.cellsBackgroundColor)
                
                self.collectionViewManager.configure(cellViewModels: viewModels)
                
                self.collectionViewManager.selectRow(self.selectedIndex)
            }
        }
        
        if self.selectedView == nil {
            let selectedView = UIView()
            
            self.selectedView = selectedView
            
            if !self.selectedView.isDescendant(of: self.collectionView) {
                
                self.selectedView.frame = self.rectSelectedView
                self.collectionView.addSubview(self.selectedView)
                self.collectionView.bringSubviewToFront(self.selectedView)
                
            }
        }
        
        super.layoutSubviews()
        
        self.collectionViewLayout.scrollDirection = .horizontal
        
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.backgroundColor = UIColor.clear
        
        self.selectedView.backgroundColor = self.textColor
        
        
    }
    
}

extension StandartPagePicker: RoutineCollectionViewManagerDelegate {
    
    func didTriggerCell(index: Int, actionType: RoutineActionType) {
        self.delegate?.columnDidPressed(index: index)
        self.selectedIndex = index
        
        self.selectedView.frame = self.rectSelectedView
        self.collectionView.bringSubviewToFront(self.selectedView)
    }
    
}
