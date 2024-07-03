import QtQuick 2.15
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import QtLocation 5.15
import QtPositioning 5.0
import com.yourcompany.xyz 1.0
import QtQuick.Controls 2.15


Window {
    property double oldLat:48.149
    property double oldLng:17.108
    property double mX
    property double mY
    property var mouseCoordinates: QtObject {
            property double latitude: 0
            property double longitude: 0
        }
    property Component locationMarker: locmarker
    property Component obrazok: obr
    id: root
    width: 1240
    height: 800
    visible: true
    title: "map"


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
            MouseArea{
                id: mapViewMouseArea
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: (mouse)=> {
                    if(mouse.button === Qt.RightButton){
                    mX=mouseX
                    mY=mouseY
                    var mouseLatLon = map.toCoordinate(Qt.point(mouseX-25,mouseY-25))
                    popup.open()
                    mouseCoordinates.latitude = mouseLatLon.latitude;
                    mouseCoordinates.longitude = mouseLatLon.longitude;
                    }
                    else{
                        console.log("toto je labe")
                    }
                }
            }
            Popup {
                    id: popup
                    x: mX
                    y: mY
                    // function updateXY(){

                    // }

                    width: 600
                    height: 400
                    // modal: true
                    // focus: true
                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
                    ColumnLayout {
                        anchors.fill: parent
                    RowLayout {
                        width: parent.width
                        spacing: 10
                        TextField {
                            id: searchField
                            placeholderText: "search..."
                            Layout.fillWidth: true
                            onTextChanged: fileFilter.filter = text
                        }
                    }
                    GridView {

                        id: gridView
                        model: fileFilter
                        cellWidth: 100
                        cellHeight: 100

                        delegate: Item {
                            width: 100
                            height: 100

                            Column {
                                anchors.centerIn: parent
                                Image {

                                    source: model.iconSource
                                    width: 64
                                    height: 64
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            console.log(model.iconSource)
                                            setMarker(mouseCoordinates.latitude,mouseCoordinates.longitude,model.iconSource)
                                        }
                                    }
                                }
                                Text {
                                    text: model.displayName
                                    horizontalAlignment: Text.AlignHLeft

                                }
                            }
                        }
                        Layout.fillWidth: true
                        Layout.fillHeight: true


                    }
                    }
                    //resize
                    MouseArea {
                                height: 40
                                width: 40
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom

                                Rectangle {
                                    anchors.fill: parent
                                    color: "red"
                                }

                                property real startX: 0
                                property real startY: 0
                                property real startWidth: 0
                                property real startHeight: 0

                                onPressed: {
                                    var pos = mapToItem(root.contentItem, mouseX, mouseY)
                                    startX = pos.x;
                                    startY = pos.y;

                                    startWidth = popup.width;
                                    startHeight = popup.height;
                                }

                                function fnc_updatePos() {
                                    if (pressed) {
                                        var pos = mapToItem(root.contentItem, mouseX, mouseY)
                                        //console.log(pos)
                                        var deltaX = pos.x-startX;
                                        var deltaY = pos.y-startY;
                                        popup.width = startWidth + deltaX;
                                        popup.height = startHeight + deltaY;

                                    }
                                }

                                onPositionChanged: fnc_updatePos()
                            }
                    //move popup
                    MouseArea {
                                height: 10
                                width: 100
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.top

                                Rectangle {
                                    anchors.fill: parent
                                    color: "grey"
                                }

                                property real startX: popup.x
                                property real startY: popup.y

                                onPressed: {
                                    var pos = mapToItem(root.contentItem, mouseX, mouseY)
                                    startX =  popup.x- pos.x
                                    startY =  popup.y- pos.y

                                }

                                function fnc_updateXY() {
                                    if (pressed) {
                                        var pos = mapToItem(root.contentItem, mouseX, mouseY)
                                        //console.log(pos)
                                        var deltaX =startX+ pos.x;
                                        var deltaY =startY+ pos.y;
                                        popup.x =deltaX;
                                        popup.y = deltaY;

                                    }
                                }

                                onPositionChanged: fnc_updateXY()
                            }

                }

        }
        function setMarker(lat,lng,src){
            var nieco = obrazok.createObject
                    (locmarker,
                    {source:src}
                    )
            var item = locationMarker.createObject
                    (root,
                    {coordinate:QtPositioning.coordinate(mouseCoordinates.latitude,mouseCoordinates.longitude),
                    sourceItem:nieco}
                    )

            popup.close()
            map.addMapItem(item)

        }
        Component{
            id:locmarker
            MapQuickItem{
                id:markerImg
                anchorPoint.x:image.width
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

        ListModel {
            id: fileModel
            ListElement { displayName: "Neutral
    Mapper"; iconSource: "qrc:/Interpreter_Translator_MGRS-Mapper.svg" }
            ListElement { displayName: "Neutral
    Mapper"; iconSource: "qrc:/Interpreter_Translator_MGRS-Mapper.svg" }
            ListElement { displayName: "Neutral
    Mapper"; iconSource: "qrc:/Interpreter_Translator_MGRS-Mapper.svg" }
            ListElement { displayName: "Neutral
    Mapper"; iconSource: "qrc:/Interpreter_Translator_MGRS-Mapper.svg" }
            ListElement { displayName: "Hostile
    Mapper"; iconSource: "qrc:/Armored-Track-Unit_MGRS-Mapper.svg" }
            ListElement { displayName: "Unknown
    Mapper"; iconSource: "qrc:/Information-Operations_MGRS-Mapper.svg" }
            ListElement { displayName: "Friendly
    Mapper"; iconSource: "qrc:/Infantry_MGRS-Mapper.svg" }
            ListElement { displayName: "Neutral
    Mapper"; iconSource: "qrc:/Interpreter_Translator_MGRS-Mapper.svg" }
            ListElement { displayName: "Hostile
    Mapper"; iconSource: "qrc:/Armored-Track-Unit_MGRS-Mapper.svg" }
            // Add more elements as needed
        }

        SortFilterProxyModel {
            id: fileFilter
            sourceModel: fileModel
            filterRole: 1
        }

}
