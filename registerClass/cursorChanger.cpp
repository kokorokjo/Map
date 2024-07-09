#include "cursorChanger.h"

#include <QCursor>
#include <QObject>
#include <QGuiApplication>
#include <QPixmap>

CursorChanger::CursorChanger(QObject *parent)
    : QObject(parent)
{
}

void CursorChanger::changeCursorShape(const QString &shape) {
    if (shape == "delete") {
        QPixmap cursor_pixmap = QPixmap(":/trash.svg");
        cursor_pixmap = cursor_pixmap.scaled(32, 32);
        QCursor cursor(cursor_pixmap, 0, 0);
        QGuiApplication::setOverrideCursor(cursor);
    }
    else if (shape == "default"){
        QCursor cursor(Qt::ArrowCursor);
        QGuiApplication::setOverrideCursor(cursor);
    }
    else if (shape == "move"){
        QCursor cursor(Qt::ClosedHandCursor);
        QGuiApplication::setOverrideCursor(cursor);
    }
    else if(shape == "beforeMove"){
        QCursor cursor(Qt::OpenHandCursor);
        QGuiApplication::setOverrideCursor(cursor);
    }
    else if (shape == "resizeBottomRight"){
        QCursor cursor(Qt::SizeFDiagCursor);
        QGuiApplication::setOverrideCursor(cursor);
    }

}
