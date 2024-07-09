#ifndef CURSORCHANGER_H
#define CURSORCHANGER_H

#include <QCursor>
#include <QObject>
#include <QGuiApplication>

class CursorChanger : public QObject
{
    Q_OBJECT
public:
    explicit CursorChanger(QObject *parent = nullptr);

public slots:
    void changeCursorShape(const QString &shape);
};

#endif // CURSORCHANGER_H
