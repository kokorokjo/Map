#include "filehelper.h"
#include <QQmlListProperty>


FileHelper::FileHelper(QObject *parent)
    : QObject(parent)
{
}

QStringList FileHelper::listSvgFiles(const QString &path) {
    QDir directory(":" + path);
    QStringList svgFiles = directory.entryList(QStringList() << "*.svg", QDir::Files);
    for (QString &file : svgFiles) {
        file.prepend("Images/MilitarySymbols/");

    }
    return svgFiles;
}
