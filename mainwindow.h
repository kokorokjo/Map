#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QMouseEvent>
#include <QEvent>
#include <QCompleter>
#include <QtWidgets>
#include <QLineEdit>



QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();



private:
    Ui::MainWindow *ui;
    void mousePressEvent(QMouseEvent *event) override;
    void clicked(const QModelIndex &index);

signals:
    // void setCenter(QVariant,QVariant);
    void setMarker(QVariant,QVariant,QVariant);
    void getMousePosition(QVariant,QVariant);

private slots:
    void showCompleter();
    void handleCompletion(const QModelIndex &index);

private:
    QMenu *contextMenu;
    QLineEdit *completerLineEdit;
    QCompleter *completer;
    QStandardItemModel *model;

    QListView *completerPopup;


};

#endif // MAINWINDOW_H
