#ifndef MENU_H
#define MENU_H

#include <QSortFilterProxyModel>

class menu : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(QString filter READ filter WRITE setFilter NOTIFY filterChanged)

public:
    explicit menu(QObject *parent = nullptr);

    QString filter() const;
    void setFilter(const QString &filter);

signals:
    void filterChanged();

protected:
    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const override;

private:
    QString m_filter;
};
#endif // MENU_H
