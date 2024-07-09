#ifndef CURSORCHANGER_H
#define CURSORCHANGER_H

#include <QObject>

class CursorChanger : public QObject
{
    Q_OBJECT
public:
    explicit CursorChanger(QObject *parent = nullptr);

signals:
};

#endif // CURSORCHANGER_H
