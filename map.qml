import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.0



Rectangle{
    id:window
    property double oldLat:48.149
    property double oldLng:17.108
    property string oldsrc:"qrc:/Interpreter_Translator_MGRS-Mapper.svg"
    property double mouseX: 0
    property double mouseY: 0
    property var mouseCoordinates: QtObject {
            property double latitude: 0
            property double longitude: 0
        }




    property Component locationMarker: locmarker

    Plugin{
        id: mapPlugin
        name: "osm"
    }

    Map{
        id: map
        anchors.fill: parent
        zoomLevel: 10
        center: QtPositioning.coordinate(oldLat,oldLng);
        plugin: mapPlugin

    }


    // MouseArea {
    // id: mapViewMouseArea
    // anchors.fill: parent
    // }

    function getMousePosition(x,y){
        var mouseLatLon = map.toCoordinate(Qt.point(x-185,y-125));
        console.log("Mouse clicked at: Latitude " + mouseLatLon.latitude + ", Longitude " + mouseLatLon.longitude);
        mouseCoordinates.latitude = mouseLatLon.latitude;
        mouseCoordinates.longitude = mouseLatLon.longitude;
    }






    function setMarker(lat,lng,src){

        var item = locationMarker.createObject(window,{
                                                coordinate:QtPositioning.coordinate(mouseCoordinates.latitude,mouseCoordinates.longitude)
                                                }
                                                )
        oldsrc=src
        map.addMapItem(item)
        console.log("qmlxdd",
                    map.center)

    }

    //get coordinates od mouse
    //use them in component insted of position
    //add more markers
    //maybe fix moving qlineEdit maybe + fix clear qlineedit

    Component{
        id:locmarker
        MapQuickItem{
            id:markerImg
            anchorPoint.x:image.width/4
            anchorPoint.y:image.height
            coordinate: position
            sourceItem: Image{
                id:image
                width: 50
                height : 50
                source: oldsrc
            }
        }
    }
}
