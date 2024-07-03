#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QMainWindow>
#include <QMouseEvent>
#include <QEvent>
#include <QCompleter>
#include <QtWidgets>
#include <QLineEdit>

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private:
    void mousePressEvent(QMouseEvent *event) override;
    void clicked(const QModelIndex &index);

signals:
    // void setCenter(QVariant,QVariant);
    void setMarker(QVariant,QVariant,QVariant);
    void getMousePosition(QVariant,QVariant);

private slots:
    // void onActionTriggered();
    void onCompleterActivated(const QString &text);

    void showCompleter();
    // void handleCompletion(const QModelIndex &index);

private:
    QMenu *contextMenu;
    QLineEdit *completerLineEdit;
    QCompleter *completer;
    QStandardItemModel *model;

    QListView *completerPopup;
};
#endif // MAINWINDOW_H
