#ifndef CURSORSHAPE_H
#define CURSORSHAPE_H

#include <QCursor>
#include <QObject>


class cursorShape : public QObject
{
public:
    explicit cursorShape(QObject *parent = nullptr) : QObject(parent) {}
public slots:
    void changeCursorShape(const QString &shape);

};

#endif // CURSORSHAPE_H
