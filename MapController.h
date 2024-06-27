#ifndef MAPCONTROLLER_H
#define MAPCONTROLLER_H


#include <QObject>
#include <QGeoCoordinate>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlComponent>
#include <QQuickItem>
#include <QQuickView>

class MapController : public QObject {
    Q_OBJECT

public:
    explicit MapController(QQmlApplicationEngine *engine, QObject *parent = nullptr);
    Q_INVOKABLE void addMapQuickItem(double latitude, double longitude, const QString &imagePath);

private:
    QQmlApplicationEngine *m_engine;
    QQuickItem *m_map;
};



#endif // MAPCONTROLLER_H
