import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.0
import Marker 1.0


Map{
    id: map
    anchors.fill: parent
    plugin: mapPlugin
    center: QtPositioning.coordinate(15.4561,73.8021);
    zoomLevel: 14
    Marker{
        coordinate: marker_model.current
    }
    MapItemView{
        model: marker_model
        delegate: Marker{
            coordinate: model.position
        }
    }
}
