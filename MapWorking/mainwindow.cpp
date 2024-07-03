#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QUrl>
#include <QQuickWidget>
#include <QMenu>
#include <QMouseEvent>
#include <QDebug>
#include <QCompleter>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlProperties>

#include <QApplication>
#include <QQuickView>
#include <QQmlContext>
#include <QQuickItem>
#include <QQmlComponent>
#include <QtPositioning/QGeoCoordinate>

QStringList symbols ={"Assumed Friendly","Assumed Hostile","Unknown","Neutral"};
QStringList iconPaths = {":/Infantry_MGRS-Mapper.svg",":/Armored-Track-Unit_MGRS-Mapper.svg",":/Information-Operations_MGRS-Mapper.svg",":/Interpreter_Translator_MGRS-Mapper.svg"};

QPoint nieco;


MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);



    //map
    ui->quickWidget->setSource(QUrl(QStringLiteral("qrc:/map.qml")));
    ui->quickWidget->show();

    auto obj = ui->quickWidget->rootObject();
    // connect(this,SIGNAL(setCenter(QVariant,QVariant)),obj,SLOT(setCenter(QVariant,QVariant)));
    connect(this,SIGNAL(setMarker(QVariant,QVariant,QVariant)),obj,SLOT(setMarker(QVariant,QVariant,QVariant)));
    connect(this,SIGNAL(getMousePosition(QVariant,QVariant)),obj,SLOT(getMousePosition(QVariant,QVariant)));

    // emit setCenter(48.149,17.108);


    // qmenu
    contextMenu = new QMenu(this);
    completerLineEdit =new QLineEdit(this);
    completerLineEdit->hide();

    model = new QStandardItemModel(this);

    for(int i=0;i<symbols.size();i++){
        auto col1= new QStandardItem(QIcon(iconPaths[i]),symbols[i]);
        col1->setData(iconPaths[i],Qt::UserRole + 1);
        model->appendRow(QList<QStandardItem*>()<<col1);
    }

    completer = new QCompleter(this);
    completer-> setModel(model);
    completer-> setModelSorting(QCompleter::CaseSensitivelySortedModel);
    completer-> setCompletionRole(Qt::DisplayRole);
    completer-> setCaseSensitivity(Qt::CaseInsensitive);
    completer-> setCompletionMode(QCompleter:sortfilterproxymodel.);

    completerLineEdit->setCompleter(completer);

    connect(completer, QOverload<const QString &>::of(&QCompleter::activated),
            this, &MainWindow::onCompleterActivated);

    // for (int i = 0; i < model->rowCount(); ++i) {
    //     QAction *action = new QAction(model->item(i)->text(), this);
    //     contextMenu->addAction(action);
    //     connect(action, &QAction::triggered, this, &MainWindow::onActionTriggered);
    // }
}


MainWindow::~MainWindow()
{
    delete ui;
}
// void MainWindow::contextMenuEvent(QContextMenuEvent *event) {
//     contextMenu->exec(event->globalPos());
// }



void MainWindow::onCompleterActivated(const QString &text) {
    QString iconPath;
    for (int i = 0; i < model->rowCount(); ++i) {
        QStandardItem *item = model->item(i);
        if (item->text() == text) {
            iconPath = item->data(Qt::UserRole + 1).toString();
            qDebug() << "Completer Selected Text:" << text;
            qDebug() << "Completer Icon Path:" << iconPath;
            // Perform additional actions if needed
            break;
        }
    }
    completerLineEdit->hide();
    completerLineEdit->clear();
    emit setMarker(48.149,17.108,"qrc"+iconPath);

}




void MainWindow::mousePressEvent(QMouseEvent *event){
    if (event->button() == Qt::RightButton) {
        emit getMousePosition(QCursor::pos().x(),QCursor::pos().y());

        QMenu menu;
        QAction* a1 = menu.addAction(QString("Add Unit"));
        QAction* a2 = menu.addAction(QString("test2"));
        if(a1 == menu.exec(QCursor::pos())) {


            // qInfo() << "C++ a2 Info Message";
            showCompleter();



        }
        else if(a2 == menu.exec(QCursor::pos())) {
            qInfo() << "C++ a1 Info Message";
        }
        // qInfo() << "C++ Style Info Message";
        // qInfo() << event->pos();
        nieco=event->pos();

    }

}

void MainWindow::showCompleter(){
    completerLineEdit->move(contextMenu->pos());
    completerLineEdit->show();
    completerLineEdit->setFocus();
}


// void MainWindow::handleCompletion(const QModelIndex &index) {
//     // QStandardItem *item = model->itemFromIndex(index);
//     qInfo() << "Selected option index:"<<index.row();
//     // QString string=item->data(Qt::UserRole +1).toString();
//     int r=index.row();
//     qInfo() << symbols[r]<<" "<<"qrc"+iconPaths[r];
//     // qInfo()<<string;


//     completerLineEdit->hide();
//     emit setMarker(48.149,17.108,"qrc"+iconPaths[r]);
// }
// void MainWindow::onActionTriggered() {
//     QAction *action = qobject_cast<QAction*>(sender());
//     if (!action) return;

//     QString selectedText = action->text();

//     for (int i = 0; i < model->rowCount(); ++i) {
//         QStandardItem *item = model->item(i);
//         if (item->text() == selectedText) {
//             QString iconPath = item->data(Qt::UserRole + 1).toString();
//             qDebug() << "Selected Text:" << selectedText;
//             qDebug() << "Icon Path:" << iconPath;
//             // Perform additional actions if needed
//             break;
//         }
//     }
// }


