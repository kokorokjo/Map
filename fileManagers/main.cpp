#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "sortfilterproxymodel.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<SortFilterProxyModel>("CustomModels", 1, 0, "SortFilterProxyModel");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
