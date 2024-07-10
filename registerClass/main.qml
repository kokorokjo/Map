import QtQuick 2.15
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import QtLocation 5.15
import QtPositioning 5.0
import com.yourcompany.xyz 1.0
import QtQuick.Controls 2.15
import QtTest 1.2


Window {
    property double oldLat:48.149
    property double oldLng:17.108
    property double mX
    property double mY
    property var knizka: {0:"test"}
    property var mouseCoordinates: QtObject {
            property double latitude: 0
            property double longitude: 0
        }
    property Component locationMarker: locmarker
    property Component obrazok: obr
    property var svgFiles: []
    property bool mazat:false
    property bool beforeMove:false
    id: root
    width: 1240
    height: 800
    visible: true
    title: "map"


Timer{
    id: deleter
    objectName: "1"
    interval: 10; running: false; repeat: false
    onTriggered:{
        var item = knizka[deleter.objectName-1]
        map.removeMapItem(item)
        }

}


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
            focus: true

            onHeightChanged: {
                resizeBugTimer.restart();
            }

            onWidthChanged: {
                resizeBugTimer.restart();
            }

            Timer {
                id: resizeBugTimer
                interval: 10
                repeat: false
                running: false
                onTriggered: {
                    map.fixPositionOnResizeBug();
                }
            }

            function fixPositionOnResizeBug() {
                pan(1, 1);
                pan(-1, -1);
            }

            MouseArea{
                id: mapViewMouseArea
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: (mouse)=> {
                    if(mouse.button === Qt.RightButton){
                    mX=mouseX
                    mY=mouseY
                    var mouseLatLon = map.toCoordinate(Qt.point(mouseX-25,mouseY-25))
                    searchField.clear()
                    popup.width=600
                    popup.height=400
                    popup.x=mX
                    popup.y=mY
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
                    width: 600
                    height: 400
                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

                    ColumnLayout {
                        anchors.fill: parent
                        RowLayout {
                            id: row
                            Layout.alignment: Qt.AlignTop
                            width: parent.width
                            spacing: 10
                            TextField {
                                focus: true
                                id: searchField
                                placeholderText: "search..."
                                Layout.fillWidth: true
                                onTextChanged: fileFilter.filter = text
                            }
                        }
                        GridView {
                            ScrollBar.vertical: ScrollBar {
                                    visible: true
                            }
                            cacheBuffer:400
                            height: popup.height-80
                            Layout.alignment: Qt.AlignTop
                            Layout.topMargin: 0
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            clip: true

                            id: gridView
                            model: fileFilter
                            cellWidth: 120
                            cellHeight: 120

                            delegate: Item {
                                width: 100
                                height: 100

                                Column {
                                    Image {
                                        source: model.iconSource
                                        Layout.alignment:Qt.AlignVCenter
                                        width: 64
                                        height: 64
                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {
                                                setMarker(mouseCoordinates.latitude,mouseCoordinates.longitude,model.iconSource)
                                            }
                                        }
                                    }
                                    Text {
                                        text: model.displayName
                                        horizontalAlignment: Text.AlignHCenter

                                    }
                                }
                            }
                        }
                    }

                    //resize
                    MouseArea {
                                height: 15
                                width: 15
                                anchors.horizontalCenter : parent.right
                                anchors.verticalCenter : parent.bottom
                                Image{
                                    anchors.fill: parent
                                    source: "qrc:/resize1.svg"
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
                                        var deltaX = pos.x-startX;
                                        var deltaY = pos.y-startY;
                                        popup.width = startWidth + deltaX;
                                        popup.height = startHeight + deltaY;
                                        cursorChanger.changeCursorShape("resizeBottomRight");

                                    }
                                }
                                function back(){
                                    cursorChanger.changeCursorShape("default")
                                }

                                onReleased: back()

                                onPositionChanged: fnc_updatePos()
                            }
                    //move popup
                    MouseArea {
                                height: 10
                                width: parent.width
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.top

                                Rectangle {
                                    anchors.fill: parent
                                    color: "#D3D3D3"
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
                                        var deltaX =startX+ pos.x;
                                        var deltaY =startY+ pos.y;
                                        popup.x =deltaX;
                                        popup.y = deltaY;
                                        cursorChanger.changeCursorShape("move");

                                    }

                                }
                                function back(){
                                    cursorChanger.changeCursorShape("default")
                                }

                                onReleased: back()
                                onPositionChanged: fnc_updateXY()

                            }

                }

        }
        //trash and move buttons
        ColumnLayout{
            anchors.right: parent.right
            anchors.top: parent.top
            MouseArea {
                height: 40
                width: 40


                Rectangle {
                    id:stvorcekTrash
                    anchors.fill: parent
                    color: "red"
                    visible: false

                }
                Image{
                    anchors.fill: parent
                    source: "qrc:/trash.svg"
                }

                onPressed: {
                    beforeMove=false
                    stvorcekDrag.visible=false
                    if (mazat===false){
                        stvorcekTrash.visible = true
                        mazat=true
                        cursorChanger.changeCursorShape("delete")

                    }
                    else{
                        stvorcekTrash.visible = false
                        mazat=false
                        cursorChanger.changeCursorShape("default")

                    }


                }
            }
            MouseArea{
                height: 40
                width: 40
                Rectangle {
                    id:stvorcekDrag
                    anchors.fill: parent
                    color: "lightBlue"
                    visible: false

                }
                Image{
                    anchors.fill: parent
                    source: "dragIcon.png"
                }

                onPressed: {
                    mazat=false
                    stvorcekTrash.visible=false

                    if (beforeMove===false){
                        stvorcekDrag.visible = true
                        beforeMove=true
                        cursorChanger.changeCursorShape("beforeMove")

                    }
                    else{
                        stvorcekDrag.visible = false
                        beforeMove=false
                        cursorChanger.changeCursorShape("default")

                    }


                }
            }
        }
        //create Marker
        function setMarker(lat,lng,src){
            var ok = (Object.keys(knizka).length + 1)
            var nieco = obrazok.createObject
                    (locmarker,
                    {source:src}

                    )
            var item = locationMarker.createObject
                    (root,
                    {coordinate:QtPositioning.coordinate(mouseCoordinates.latitude,mouseCoordinates.longitude),
                    sourceItem:nieco,
                    objectName=ok}
                    )

            popup.close()
            knizka[Object.keys(knizka).length]=item
            map.addMapItem(item)

        }

        Component{
            id:locmarker
            MapQuickItem{
                objectName:"obr_"
                id:markerImg
                sourceItem: Image{
                    id:image
                }
                property real startX: markerImg.x
                property real startY: markerImg.y
                anchorPoint.x:image.width/4
                anchorPoint.y:image.height
                coordinate: position
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    drag.target: map
                    onClicked: {
                        if(mazat===true){
                            deleter.objectName=markerImg.objectName
                            deleter.start()
                        }
                    }
                    onPressed: {
                        if(beforeMove===true){
                            drag.target= parent
                        }
                        else{
                            drag.target= map
                        }

                    }
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
            ListElement { displayName: "friendly\nair\ndefense"; iconSource: "qrc:/friendly_air_defense.svg" }

            Component.onCompleted: {
                    svgFiles = fileHelper.listSvgFiles("/Images/MilitarySymbols");
                    for (var i = 0; i < svgFiles.length; i++) {
                        var name=svgFiles[i]
                        var nameA=name.slice(23,name.length-4)
                        var side=nameA.slice(0,nameA.search("_"))
                        var zostatok=nameA.slice(nameA.search("_")+1,nameA.length)
                        var koniec = " "
                        if(zostatok.search("_")!==-1){
                            koniec=zostatok.slice(zostatok.search("_")+1,zostatok.length)
                            var pomocna=zostatok.slice(0,zostatok.search("_"))
                            zostatok=pomocna
                        }

                        fileModel.append({ displayName: side + "\n"  + zostatok+"\n"  +koniec, iconSource: svgFiles[i] });
                    }
                }
        }

        SortFilterProxyModel {
            id: fileFilter
            sourceModel: fileModel
            filterRole: 0
        }

}

