#ifndef MARKERS_H
#define MARKERS_H

#include <QObject>
#include <QPoint>

class Markers : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QPoint nieco READ nieco WRITE setNieco NOTIFY niecoChanged)


public:
    Markers();
public slots:
    void doNieco(const QPoint &asi);
public:
    QPoint nieco();
    void setNieco(QPoint value);

private:
    QPoint m_nieco;
signals:
    void niecoChanged();

};

#endif // MARKERS_H
