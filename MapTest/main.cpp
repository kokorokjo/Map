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

    qmlRegisterType<MarkerModel>("com.example.markermodel", 1, 0, "MakerModel");
    MainWindow w;
    w.show();
    return a.exec();
}
