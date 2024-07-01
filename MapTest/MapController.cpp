#include "MapController.h"
#include<QGeoCoordinate>



MapController::MapController(QQmlApplicationEngine *engine, QObject *parent)
    : QObject(parent), m_engine(engine) {
    QObject *rootObject = m_engine->rootObjects().first();
    m_map = rootObject->findChild<QQuickItem*>("map");
}

void MapController::addMapQuickItem(double latitude, double longitude, const QString &imagePath) {
    if (!m_map) {
        qWarning() << "Map object not found!";
        return;
    }

    QQmlComponent component(m_engine, QUrl(QStringLiteral("qrc:/MapQuickItem.qml")));
    QQuickItem *mapQuickItem = qobject_cast<QQuickItem*>(component.create());

    if (!mapQuickItem) {
        qWarning() << "Failed to create MapQuickItem!";
        return;
    }

    mapQuickItem->setParentItem(m_map);
    mapQuickItem->setProperty("coordinate", QGeoCoordinate(latitude, longitude));
    mapQuickItem->setProperty("source", imagePath);
}
