#ifndef MYGLOBALOBJECT_H
#define MYGLOBALOBJECT_H

#include <QObject>

class MyGlobalObject : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int counter READ counter WRITE setCounter NOTIFY counterChanged)

public:
    MyGlobalObject();
public slots:
    void doSomething(const QString &text);
public:
    int counter() const;
    void setCounter(int value);

private:
    int m_counter;
signals:
    void counterChanged();
};

#endif // MYGLOBALOBJECT_H
