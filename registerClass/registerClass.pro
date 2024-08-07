QT       += core gui qml

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++17
CONFIG += qmltypes
QML_IMPORT_NAME = com.yourcompany.xyz
QML_IMPORT_MAJOR_VERSION = 1


# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    cursorChanger.cpp \
    filehelper.cpp \
    main.cpp \
    menu.cpp

HEADERS += \
    cursorChanger.h \
    filehelper.h \
    menu.h

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

RESOURCES += \
    qrc.qrc
