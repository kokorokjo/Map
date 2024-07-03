import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.0
import QtQuick.Window 2.0



Window{
    width: 512
    height: 512
    visible: true
    property double oldLat:48.149
    property double oldLng:17.108
    property string oldsrc:"qrc:/Interpreter_Translator_MGRS-Mapper.svg"
    property Component locationMarker: locmarker
    property Component obrazok: obr
    property var mouseCoordinates: QtObject {
            property double latitude: 0
            property double longitude: 0
        }


    Plugin{
        id: mapPlugin
        name: "osm"
    }

    Map{
        id: map
        visible: true
        anchors.fill: parent
        zoomLevel: 10
        center: QtPositioning.coordinate(oldLat,oldLng);
        plugin: mapPlugin

    }
    Component{
        id:locmarker
        MapQuickItem{
            id:markerImg
            anchorPoint.x:image.width/4
            anchorPoint.y:image.height
            coordinate: position
            sourceItem: Image{
                id:image

            }
        }
    }
    Component{
        id:obr
        Image{
            id:image
            width: 50
            height : 50
            source: oldsrc
            }

    }



    function getMousePosition(x,y){
        var mouseLatLon = map.toCoordinate(Qt.point(x-85,y-100));
        console.log("Mouse clicked at: Latitude " + mouseLatLon.latitude + ", Longitude " + mouseLatLon.longitude);
        mouseCoordinates.latitude = mouseLatLon.latitude;
        mouseCoordinates.longitude = mouseLatLon.longitude;
    }

    function setMarker(lat,lng,src){
        var nieco = obrazok.createObject
                (locmarker,
                {source:src}
                )
        var item = locationMarker.createObject
                (window,
                {coordinate:QtPositioning.coordinate(mouseCoordinates.latitude,mouseCoordinates.longitude),
                sourceItem:nieco}
                )


        map.addMapItem(item)

    }

}

