
import Foundation

public enum Spacing: CGFloat {
    /// value = 2
    case xxxxTiny  = 2
    /// value = 3
    case xxxTiny   = 3
    /// value = 4
    case xxTiny    = 4
    /// value = 5
    case xTiny     = 5
    /// value = 6
    case tiny      = 6
    
    /// value = 7
    case xxxxSmall = 7
    /// value = 8
    case xxxSmall  = 8
    /// value = 9
    case xxSmall   = 9
    /// value = 10
    case xSmall    = 10
    /// value = 11
    case small     = 11
    
    /// value = 12
    case medium    = 12
    /// value = 14
    case medium2   = 14
    /// value = 16
    case medium3   = 16
    /// value = 18
    case medium4   = 18
    /// value = 20
    case medium5   = 20
    
    /// value = 22
    case large     = 22
    /// value = 24
    case xLarge    = 24
    /// value = 26
    case xxLarge   = 26
    /// value = 30
    case xxxLarge  = 30
    /// value = 35
    case xxxxLarge = 36
    
    //...
    
    var value: CGFloat { rawValue }
}
