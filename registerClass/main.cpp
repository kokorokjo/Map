#include "menu.h"
#include "filehelper.h"
#include "cursorChanger.h"

#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>



int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QQmlApplicationEngine engine;


    FileHelper fileHelper;
    CursorChanger cursorChanger;


    //register classes
    engine.rootContext()->setContextProperty("fileHelper", &fileHelper);
    engine.rootContext()->setContextProperty("cursorChanger", &cursorChanger);


    //custom component
    qmlRegisterType<menu>("com.yourcompany.xyz", 1, 0, "SortFilterProxyModel");
    engine.load(url);

    return app.exec();
}

