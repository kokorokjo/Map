#include "markers.h"
#include <QPoint>
#include <QDebug>

Markers::Markers()
{

}
void Markers::doNieco(const QPoint &asi){
    qDebug() << "aSuradky:" << asi;
}

QPoint Markers::nieco(){
    return m_nieco;
}

void Markers::setNieco(QPoint value){
    if(m_nieco !=value){
        m_nieco=value;
        niecoChanged();
        doNieco(m_nieco);
    }
}
