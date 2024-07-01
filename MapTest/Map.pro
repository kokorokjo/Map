QT       += core gui
QT += quickwidgets
QT +=qml
QT +=svg
QT += core quick quickcontrols2 location


greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++17
CONFIG += qmltypes
QML_IMPORT_NAME = Marker
QML_IMPORT_MAJOR_VERSION = 1
QML_IMPORT_PATH = /home/martin/Qt/5.15.2/gcc_64/QML

INCLUDEPATH += /Sources





# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    main.cpp \
    mainwindow.cpp \
    markermodel.cpp

HEADERS += \
    mainwindow.h \
    markermodel.h

FORMS += \
    mainwindow.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

RESOURCES += \
    gml.qrc
