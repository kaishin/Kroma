#if DEBUG
import SwiftUI

struct PillView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      HStack {
        Circle().fill(Color.red.lighter(by: 0.2))
          .frame(width: 50, height: 50)
        Circle().fill(Color.red)
          .frame(width: 50, height: 50)
        Circle().fill(Color.red.darker(by: 0.2))
          .frame(width: 50, height: 50)
      }

      HStack {
        Circle().fill(Color.purple.lighter(by: 0.2))
          .frame(width: 50, height: 50)
        Circle().fill(Color.purple)
          .frame(width: 50, height: 50)
        Circle().fill(Color.purple.darker(by: 0.2))
          .frame(width: 50, height: 50)
      }
    }
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
#endif
