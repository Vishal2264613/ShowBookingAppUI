//
//  CustomShape.swift
//  ShowBookingApp
//
//  Created by vishal pawar on 23/07/21.
//

import SwiftUI

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            let w = rect.width / 2/3
            let h = rect.height / 3/4
            let width = rect.width
            let height = rect.height
            path.move(to: CGPoint(x: w, y: 0))
            path.addLine(to: CGPoint(x: width - w, y: 0))
            path.addQuadCurve(to: CGPoint(x: width, y: h), control: CGPoint(x: width, y: 0))
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: h))
            path.addQuadCurve(to: CGPoint(x: w, y: 0), control: CGPoint(x: 0, y: 0))
        }
    }
}


struct CustomShape_Previews: PreviewProvider {
    static var previews: some View {
        Image("chair")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
                
            
        CustomShape()
            .stroke(lineWidth: 4)
            .frame(width: 300, height: 640, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}
