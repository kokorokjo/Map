import QtQuick 2.15
import QtLocation 5.11

MapQuickItem {
    id: mapQuickItem
    anchorPoint.x : image.width/2
    anchorPoint.y : image.height/2
    coordinate : QtPositioning.coordinate(0,0)
    Image{
        id: image
        source: MapQuickItem.source
        anchors.centerIn: parent

    }
}
