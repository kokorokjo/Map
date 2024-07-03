#include "myglobalobject.h"
#include <QDebug>

MyGlobalObject::MyGlobalObject()
{
    // perform custom initialization steps here
}

void MyGlobalObject::doSomething(const QString &text) {
    qDebug() << "MyGlobalObject doSomething called with" << text;
}
int MyGlobalObject::counter() const {
    return m_counter;
}

void MyGlobalObject::setCounter(int value) {
    if(m_counter != value) {
        m_counter = value;
        counterChanged();
    }
}

