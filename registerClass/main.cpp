#include "markers.h"
#include "menu.h"

#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QQmlApplicationEngine engine;

    Markers* myMarker = new Markers();
    // myGlobal->doSomething("TEXT FROM C++");

    //register classes
    engine.rootContext()->setContextProperty("markers", myMarker);

    //custom component
    qmlRegisterType<menu>("com.yourcompany.xyz", 1, 0, "SortFilterProxyModel");
    engine.load(url);

    return app.exec();
}
