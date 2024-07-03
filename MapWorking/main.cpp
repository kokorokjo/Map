#include "mainwindow.h"

#include <QApplication>
#include <QQuickView>
#include <QQmlContext>
#include <QQuickItem>
#include <QQmlApplicationEngine>


int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/map.qml")));
    MainWindow w;
    w.show();
    return a.exec();
}
