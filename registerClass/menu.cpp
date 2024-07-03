#include "menu.h"

menu::menu(QObject *parent)
    : QSortFilterProxyModel(parent)
{
}

QString menu::filter() const
{
    return m_filter;
}

void menu::setFilter(const QString &filter)
{
    if (m_filter != filter) {
        m_filter = filter;
        invalidateFilter();
        emit filterChanged();
    }
}

bool menu::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    if (m_filter.isEmpty())
        return true;

    QModelIndex index = sourceModel()->index(sourceRow, 0, sourceParent);
    return sourceModel()->data(index, filterRole()).toString().contains(m_filter, Qt::CaseInsensitive);
}
