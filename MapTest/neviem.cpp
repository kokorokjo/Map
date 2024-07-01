

#include <QGraphicsItem>
#include <QPainter>
#include <QMenu>
#include <QGraphicsSceneContextMenuEvent>
#include <QMessageBox>

class TItem : public QGraphicsItem
{
    bool _selected = false;
public:
    TItem(QGraphicsItem* parent = nullptr) : QGraphicsItem(parent) {}
    QRectF  boundingRect() const override { return QRectF(0,0,20,20); }
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget) override {
        painter->fillRect(QRectF(0,0,20,20),_selected ? QColor(0,255,255) : QColor(255,255,0));
    }
    void mousePressEvent(QGraphicsSceneMouseEvent* e) override {
        QGraphicsItem::mousePressEvent(e);
        if (e->button() & Qt::RightButton) {
            QMenu menu;
            QAction* a1 = menu.addAction(QString("test1"));
            QAction* a2 = menu.addAction(QString("test2"));
            if(a2 == menu.exec(e->screenPos())) {
                test2();
                _selected = true;
                update();
            }
        }
    }
    void test2() {
        QMessageBox::information(nullptr,"test2","test2");
    }
};
