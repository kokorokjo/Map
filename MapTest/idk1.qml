import QtQuick 2.15
import QtLocation 5.11

MapQuickItem {
    id: marker
    anchorPoint.x: image.width/4
    anchorPoint.y: image.height

    HoverHandler {
        id: hoverHandler
    }
    TapHandler {
        id: tapHandler
        acceptedButtons: Qt.RightButton
        gesturePolicy: TapHandler.WithinBounds
        onTapped: {
            mapview.currentMarker = -1
            for (var i = 0; i< mapview.markers.length; i++){
                if (marker === mapview.markers[i]){
                    mapview.currentMarker = i
                    break
                }
            }
            mapview.showMarkerMenu(marker.coordinate)
        }
    }
    DragHandler {
        id: dragHandler
        grabPermissions: PointerHandler.CanTakeOverFromItems | PointerHandler.CanTakeOverFromHandlersOfDifferentType
    }

    sourceItem: Image {
        id: image
    }
}
