#ifndef FILEHELPER_H
#define FILEHELPER_H

#include <QObject>
#include <QDir>
#include <QQmlListProperty>

class FileHelper : public QObject {
    Q_OBJECT
public:
    explicit FileHelper(QObject *parent = nullptr);

    Q_INVOKABLE QStringList listSvgFiles(const QString &path);
};

#endif // FILEHELPER_H
