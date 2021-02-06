import Foundation

@propertyWrapper
public struct Clamped<Value: Comparable> {
  var value: Value
  let range: ClosedRange<Value>

  init(
    wrappedValue: Value,
    _ range: ClosedRange<Value>
  ) {
    precondition(range.contains(wrappedValue))
    self.value = wrappedValue
    self.range = range
  }

  public var wrappedValue: Value {
    get { value }
    set { value = clamp(newValue, with: range) }
  }
}

func clamp<T: Comparable>(_ value: T, with range: ClosedRange<T>) -> T {
  return min(max(range.lowerBound, value), range.upperBound)
}
