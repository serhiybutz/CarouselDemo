//
//  Shapes.swift
//  CarouselDemo
//
//  Created by Serhiy Butz on 2022-11-27.
//

import SwiftUI

struct CarouselToModalClipShape: Shape {
    enum RoundedCornersLocation {
        case top, bottom, all
    }
    
    let geo: ShapeGeo
    let pct: CGFloat

    func path(in rect: CGRect) -> Path {
        
        // Card starts at the horizontal center.
        // Rect is the target shape, which is Modal view's size.
        let cardSize = CGSize(
            width: (rect.width - geo.size.width) * pct + geo.size.width,
            height: (rect.height - geo.size.height) * pct + geo.size.height
        )

        let cardRect = CGRect(
            origin: CGPoint(x: rect.midX - cardSize.width / 2,
                            y: rect.minY + Conf.Modal.topOffset * pct),
            size: cardSize
        )
        
        return Path(roundedRect: cardRect,
                    cornerSize: CGSize(width: geo.roundedCornerRadius,
                                       height: geo.roundedCornerRadius))
//        return makeRoundedCornerRectPath(rect: cardRect, roundedCornersLocation: .all, cornerRadius: geo.roundedCornerRadius)
    }
    
    func makeRoundedCornerRectPath(rect: CGRect, roundedCornersLocation: RoundedCornersLocation, cornerRadius: CGFloat) -> Path {

        Path { path in
            let width: CGFloat = rect.size.width
            let height: CGFloat = rect.size.height
            
            let topLeftCorner: Bool = [.top, .all].contains(roundedCornersLocation)
            let topRightCorner: Bool = [.top, .all].contains(roundedCornersLocation)
            let bottomLeftCorner: Bool = [.bottom, .all].contains(roundedCornersLocation)
            let bottomRightCorner: Bool = [.bottom, .all].contains(roundedCornersLocation)

            if topLeftCorner {
                path.move(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
            } else {
                path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            }
            if topRightCorner {
                path.addLine(to: CGPoint(x: rect.minX + width - cornerRadius, y: rect.minY))
                path.addArc(center: CGPoint(x: rect.minX + width - cornerRadius, y: rect.minY + cornerRadius),
                            radius: cornerRadius,
                            startAngle: Angle(degrees: -90),
                            endAngle: Angle(degrees: 0),
                            clockwise: false)
            } else {
                path.addLine(to: CGPoint(x: rect.minX + width, y: rect.minY))
            }
            if bottomRightCorner {
                path.addLine(to: CGPoint(x: rect.minX + width, y: rect.minY + height - cornerRadius))
                path.addArc(center: CGPoint(x: rect.minX + width - cornerRadius, y: rect.minY + height - cornerRadius),
                            radius: cornerRadius,
                            startAngle: Angle(degrees: 0),
                            endAngle: Angle(degrees: 90),
                            clockwise: false)
            } else {
                path.addLine(to: CGPoint(x: rect.minX + width, y: rect.minY + height))
            }
            if bottomLeftCorner {
                path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + height))
                path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + height - cornerRadius),
                            radius: cornerRadius,
                            startAngle: Angle(degrees: 90),
                            endAngle: Angle(degrees: 180),
                            clockwise: false)
            } else {
                path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + height))
            }
            if topLeftCorner {
                path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
                path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                            radius: cornerRadius,
                            startAngle: Angle(degrees: 180),
                            endAngle: Angle(degrees: 270),
                            clockwise: false)
            } else {
                path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            }
        }
    }
}

struct FavoritesToModalClipShape: Shape {

    let pct: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        // Card starts at the horizontal center.
        // Rect is the target shape, which is Modal view's size.
        let cardSize = CGSize(
            width: (rect.width - Conf.Favorites.height) * pct + Conf.Favorites.height,
            height: (rect.height - Conf.Favorites.height) * pct + Conf.Favorites.height
        )
        let cardRect = CGRect(
            origin: CGPoint(x: rect.midX - cardSize.width / 2,
                            y: rect.minY + Conf.Modal.topOffset * pct),
            size: cardSize
        )
        
        let cornerRadius = (Conf.Modal.roundedCornerRadius - Conf.Favorites.height / 2) * pct + Conf.Favorites.height / 2
        
        return Path(roundedRect: cardRect,
                    cornerSize: CGSize(width: cornerRadius,
                                       height: cornerRadius))
    }
}

struct RoundedRectangleShape: Shape {
    let cornerRadius: CGFloat
    func path(in rect: CGRect) -> Path {
        Path(roundedRect: rect,
             cornerSize: CGSize(width: cornerRadius,
                                height: cornerRadius))
    }
}

struct IdentityShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path(roundedRect: rect,
             cornerSize: .zero)
                
    }
}

struct CardViewToFavoriteShape: InsettableShape {

    var pct: CGFloat
    
    func path(in rect: CGRect) -> Path {

        let width = (Conf.Favorites.height - Conf.Card.geo.size.width) * pct + Conf.Card.geo.size.width
        let height = (Conf.Favorites.height - Conf.Card.geo.size.height) * pct + Conf.Card.geo.size.height
        
        let cardRect = CGRect(
            origin: CGPoint(x: rect.midX - width / 2,
                            y: rect.midY - height / 2),
            size: CGSize(width: width, height: height)
        )
        
        let targetCornerRadius: CGFloat = Conf.Favorites.height / 2
        let currentCornerRadius = (targetCornerRadius - Conf.Card.geo.roundedCornerRadius) * pct + Conf.Card.geo.roundedCornerRadius
        
        return Path(roundedRect: cardRect,
                    cornerSize: CGSize(width: currentCornerRadius,
                                       height: currentCornerRadius))
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        return SquareToCircle_Inset(pct: pct, base: self, amount: amount)
    }

    struct SquareToCircle_Inset: InsettableShape {

        var pct: CGFloat

        var base: CardViewToFavoriteShape
        var amount: CGFloat

        func path(in rect: CGRect) -> Path {
            CardViewToFavoriteShape(pct: pct)
                .path(in: rect.insetBy(dx: amount, dy: amount))
        }

        func inset(by amount: CGFloat) -> some InsettableShape {
            var copy = self
            copy.amount += amount
            return copy
        }
    }
}
