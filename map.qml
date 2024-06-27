import QtQuick 2.15
import QtLocation 5.15

Rectangle{
    Plugin{
        id: mapPlugin
        name: "osm"
    }

    Map{
        id: map
        anchors.fill: parent
        zoomLevel: 15
        // center: QtPositioning.coordinate();
        plugin: mapPlugin

    }
}
