#ifndef SVGITEMS_H
#define SVGITEMS_H
#include <QStyledItemDelegate>
#include <QPainter>
#include <QSvgRenderer>
#include <QDebug>

class SvgItemDelegate : public QStyledItemDelegate{
    Q_OBJECT

public:
    SvgItemDelegate(QObject *parent =nullptr) : QStyledItemDelegate(parent){}

    void paint(QPainter *painter, const QStyleOptionViewItem &option, const QModelIndex &index) const override{
        qInfo()<<"aj tu";
        painter->save();

        QString iconPath =index.data(Qt::DecorationRole).toString();
        QSvgRenderer svgRenderer(iconPath);
        QRect iconRect = option.rect.adjusted(5,5,-5,-5);
        svgRenderer.render(painter, iconRect);

        QRect textRect = option.rect.adjusted(40,0,0,0);
        QString text = index.data(Qt::DisplayRole).toString();
        painter->drawText(textRect,Qt::AlignVCenter | Qt::AlignLeft, text);

        qInfo() << "som tu";
        painter->restore();

    }

};



#endif // SVGITEMS_H
