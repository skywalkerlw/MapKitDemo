//
//  Helper.swift
//  SwiftUIMapView
//
//  Created by liang.wang on 21/11/2022.
//

import Foundation
import UIKit
import MapKit
import SwiftUI

extension UIViewController {
    func makeRandomCoordinates(_ number: Int = 200, in region: MKCoordinateRegion) -> [CLLocationCoordinate2D] {
        let minLat = region.center.latitude - (region.span.latitudeDelta * 2)
        let maxLat = region.center.latitude + (region.span.latitudeDelta * 2)
        
        let minLon = region.center.longitude - (region.span.longitudeDelta)
        let maxLon = region.center.longitude + (region.span.longitudeDelta)
        
        let adjusted: [Int] = [minLat, maxLat, minLon, maxLon].map { Int($0 * 10000) }
        let latDelta = adjusted[1] - adjusted[0]
        let lonDelta = abs(adjusted[3] - adjusted[2])
        
        var coordinates = [CLLocationCoordinate2D]()
        for _ in 0...number {
            let latRand = Int(arc4random_uniform(UInt32(latDelta)))
            let lonRand = Int(arc4random_uniform(UInt32(lonDelta))) * -1
            
            let lat: Double = minLat + (Double(latRand) / 10000.0)
            let lon: Double = minLon - (Double(lonRand) / 10000.0)
            
            coordinates.append(CLLocationCoordinate2D(latitude: lat, longitude: lon))
        }
        
        return coordinates
    }
}


// MARK: - PartialSheet

private struct PartialSheetModifier<PartialSheetContent>: ViewModifier
where PartialSheetContent: View {
    @Binding var isActive: Bool
    let content: PartialSheetContent

    init(isActive: Binding<Bool>, @ViewBuilder content: () -> PartialSheetContent) {
        _isActive = isActive
        self.content = content()
    }

    func body(content: Content) -> some View {
        content.overlay(
            ZStack(alignment: .bottom) {
                if self.isActive {
                    Rectangle()
                        .fill(Color.black.opacity(0.4))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onTapGesture {
                            withAnimation {
                                self.isActive = false
                            }
                        }
                        .zIndex(1)
                        .transition(.opacity)

                    VStack(spacing: 0) {
//                        TopHandleBar() // For future
                        self.content
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                    }
                    .padding(.bottom)
                    .zIndex(2)
                    .transition(.move(edge: .bottom))
                }
            }
            .ignoresSafeArea()
        )
    }
}

private struct TopHandleBar: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: CGFloat(5.0) / 2.0)
                .frame(width: 40, height: 5)
                .foregroundColor(.secondary)
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10, corners: [.topLeft, .topRight])
    }
}

extension View {
    func partialSheet<Content>(
        _ showPartialSheet: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View
    where Content: View {
        modifier(
            PartialSheetModifier(isActive: showPartialSheet, content: content)
        )
    }
}

// MARK: - rounded corner

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// Notification utitles
extension View {
    func onNotification(
        _ notificationName: Notification.Name,
        perform action: @escaping () -> Void
    ) -> some View {
        onReceive(NotificationCenter.default.publisher(
            for: notificationName
        )) { _ in
            action()
        }
    }
}
