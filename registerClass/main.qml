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
    property var knizka: {0:"test"}
    property var mouseCoordinates: QtObject {
            property double latitude: 0
            property double longitude: 0
        }
    property Component locationMarker: locmarker
    property Component obrazok: obr
    property var svgFiles: []
    property var itemiky:[]
    property var nazvy:[]
    property int pocitadlo:0
    property bool mazat:false
    property bool beforeMove:false
    id: root
    width: 1240
    height: 800
    visible: true
    title: "map"





        Plugin{
            id: mapPlugin
            name: "osm"
        }
        property int asi:1
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
                    searchField.clear()
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
                            Layout.alignment: Qt.AlignTop
                            height: popup.height-240
                            Layout.fillWidth: true

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
                                height: 10
                                width: 10
                                anchors.left: parent.right
                                anchors.top: parent.bottom

                                Rectangle {
                                    anchors.fill: parent
                                    color: "grey"
                                }

                                property real startX: 0
                                property real startY: 0
                                property real startWidth: 0
                                property real startHeight: 0
                                // item2.x =QtPositioning.coordinate(deltaX);
                                // item2.y =QtPositioning.coordinate(deltaY);
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
                    if(beforeMove===false){



                    if (mazat===false){
                        stvorcekTrash.visible = true
                        mazat=true
                        console.log("a")
                        cursorChanger.changeCursorShape("delete")

                    }
                    else{
                        stvorcekTrash.visible = false
                        mazat=false
                        console.log("b")
                        cursorChanger.changeCursorShape("default")

                    }

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
                    if(mazat===false){

                    if (beforeMove===false){
                        stvorcekDrag.visible = true
                        beforeMove=true
                        console.log("c")
                        cursorChanger.changeCursorShape("beforeMove")

                    }
                    else{
                        stvorcekDrag.visible = false
                        beforeMove=false
                        console.log("d")
                        cursorChanger.changeCursorShape("default")

                    }
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
            itemiky.push(item)
            knizka[Object.keys(knizka).length]=item
            console.log(Object.keys(knizka).length)
            map.addMapItem(item)
            pocitadlo+=1
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
                        robim(markerImg.objectName)
                    }
                    onPressed: {
                        if(beforeMove===true){
                            drag.target=parent
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

        //function for delete marker
        function robim(a){
            if(mazat===true){
                var item = knizka[a-1]
                map.removeMapItem(item)
            }
        }



        ListModel {
            id: fileModel
            ListElement { displayName: "friendly\nair\ndefense"; iconSource: "qrc:/friendly_air_defense.svg" }

            Component.onCompleted: {
                // console.log("asdsa")
                    svgFiles = fileHelper.listSvgFiles("/Images/MilitarySymbols");
                    for (var i = 0; i < svgFiles.length; i++) {
                        // console.log(svgFiles[i])
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

