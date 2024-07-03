import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import CustomModels 1.0

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "File Manager"

    ColumnLayout {
        anchors.fill: parent

        // Search bar
        RowLayout {
            width: parent.width
            spacing: 10
            TextField {
                id: searchField
                placeholderText: "Search..."
                Layout.fillWidth: true
                onTextChanged: fileFilter.filter = text
            }
        }

        // Grid view for icons
        GridView {
            id: gridView
            model: fileFilter
            delegate: Item {
                width: gridView.width / 5
                height: gridView.height / 4

                Column {
                    anchors.centerIn: parent
                    Image {
                        source: model.iconSource
                        width: 64
                        height: 64
                    }
                    Text {
                        text: model.displayName
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
            Layout.fillWidth: true
            Layout.fillHeight: true
            cellWidth: gridView.width / 5
            cellHeight: gridView.height / 4
        }
    }

    ListModel {
        id: fileModel
        ListElement { displayName: "Interpreter_Translator \n _MGRS-Mapper"; iconSource: "qrc:/Interpreter_Translator_MGRS-Mapper.svg" }
        ListElement { displayName: "Interpreter_Translator \n _MGRS-Mapper"; iconSource: "qrc:/Interpreter_Translator_MGRS-Mapper.svg" }
        // Add more elements as needed
    }

    SortFilterProxyModel {
        id: fileFilter
        sourceModel: fileModel
        filterRole: 0
    }
}
