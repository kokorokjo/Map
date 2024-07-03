#include "sortfilterproxymodel.h"

SortFilterProxyModel::SortFilterProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{
}

QString SortFilterProxyModel::filter() const
{
    return m_filter;
}

void SortFilterProxyModel::setFilter(const QString &filter)
{
    if (m_filter != filter) {
        m_filter = filter;
        invalidateFilter();
        emit filterChanged();
    }
}

bool SortFilterProxyModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    if (m_filter.isEmpty())
        return true;

    QModelIndex index = sourceModel()->index(sourceRow, 0, sourceParent);
    return sourceModel()->data(index, filterRole()).toString().contains(m_filter, Qt::CaseInsensitive);
}
