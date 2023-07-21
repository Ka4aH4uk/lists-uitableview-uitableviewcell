//
//  ViewControllerTwo.swift
//  m14.123
//
//  Created by Ka4aH on 21.01.2023.
//

import UIKit

struct NewsRecordModel {
    let title: String
    let publishedAt: String
}

class ViewControllerTwo: UITableViewController {
    var cellId = "NewsCell"
    
    let models: [NewsRecordModel] = [
        NewsRecordModel(
            title: "Airbus Ventures invests in Tokyo-based ispace",
            publishedAt: "2021-10-25T11:23:09.000Z"
        ),
        NewsRecordModel(
            title: "SpaceX fires up first upgraded Starship engine",
            publishedAt: "2021-10-25T09:13:32.000Z"
        ),
        NewsRecordModel(
            title: "IAI announces new small GEO satellite bus",
            publishedAt: "2021-10-25T08:33:11.000Z"
        ),
        NewsRecordModel(
            title: "Here’s how SpaceX is (probably) going to refuel Starships in space",
            publishedAt: "2021-10-24T19:53:33.000Z"
        ),
        NewsRecordModel(
            title: "Chang Zheng 3B lifts Shijian 21 to orbit",
            publishedAt: "2021-10-24T18:26:25.000Z"
        ),
        NewsRecordModel(
            title: "BepiColombo completes first Mercury flyby, science provides insight into planet’s unique environment",
            publishedAt: "2021-10-24T17:22:02.000Z"
        ),
        NewsRecordModel(
            title: "China launches classified space debris mitigation technology satellite",
            publishedAt: "2021-10-24T10:23:11.000Z"
        ),
        NewsRecordModel(
            title: "Arianespace breaks payload mass record on final Ariane 5 launch before Webb",
            publishedAt: "2021-10-24T08:13:08.000Z"
        ),
        NewsRecordModel(
            title: "Conference seeks to build interest in space among elected officials",
            publishedAt: "2021-10-24T02:23:10.000Z"
        ),
        NewsRecordModel(
            title: "Ariane 5 launches civilian, military satellites; mission to clear way for James Webb launch",
            publishedAt: "2021-10-23T21:10:54.000Z"
        ),
        NewsRecordModel(
            title: "Under watchful eye of NASA, teams prep for final Ariane 5 flight before Webb",
            publishedAt: "2021-10-23T19:13:07.000Z"
        ),
        NewsRecordModel(
            title: "NASA sets Artemis 1 launch for no earlier than February",
            publishedAt: "2021-10-23T03:33:12.000Z"
        ),
        NewsRecordModel(
            title: "L3 Harris wins $120 million contract to upgrade Space Force electronic jammers",
            publishedAt: "2021-10-22T23:13:11.000Z"
        ),
        NewsRecordModel(
            title: "NASA targets February launch for Artemis 1 moon mission",
            publishedAt: "2021-10-22T20:33:07.000Z"
        ),
        NewsRecordModel(
            title: "NASA Commits $28 Million to Underfunded US Jurisdictions",
            publishedAt: "2021-10-22T20:23:00.000Z"
        ),
        NewsRecordModel(
            title: "Ship 20 completes milestone RVac Static Fire – Musk cites ambitious path to launch",
            publishedAt: "2021-10-22T20:09:14.000Z"
        ),
        NewsRecordModel(
            title: "China’s hypersonic vehicle test a ‘significant demonstration’ of space technology",
            publishedAt: "2021-10-22T19:23:10.000Z"
        ),
        NewsRecordModel(
            title: "Space Adventures no longer planning Crew Dragon flight",
            publishedAt: "2021-10-22T19:23:10.000Z"
        ),
        NewsRecordModel(
            title: "NASA Invites Media to Launch of IXPE Mission to Study X-rays in Space",
            publishedAt: "2021-10-22T18:33:00.000Z"
        ),
        NewsRecordModel(
            title: "Ariane 5 launch delayed for more ground systems checks",
            publishedAt: "2021-10-22T16:43:06.000Z"
        )
    ]
    
    struct NewsRecordModelDate { // новая структура с Date
        let title: String
        let publishedAt: Date
    }
    
    fileprivate func stringToDate() -> [NewsRecordModelDate] { // конвертация массива
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        let newsRecordModelDate: [NewsRecordModelDate] = models.map { NewsRecordModelDate.init(title: $0.title, publishedAt: dateFormatter.date(from: $0.publishedAt) ?? Date())
        }
        return newsRecordModelDate
    }
    
    fileprivate func createDictionary() -> [Date: [NewsRecordModelDate]] { // словарь
        let updateDataArray = stringToDate()
        let dictionary = Dictionary(grouping: updateDataArray) { (element: NewsRecordModelDate) -> Date in
            let calendar = Calendar.current.dateComponents([.day, .month, .year], from: element.publishedAt)
            let newDate = Calendar.current.date(from: calendar)
            return newDate ?? Date()
        }
        return dictionary
    }
   
    struct FinalSectionModel {
        let nameSection: Date
        let cells: [NewsRecordModelDate]
    }
    
    var sections: [FinalSectionModel] = []
    
    fileprivate func dictToArray() -> [FinalSectionModel] {
        let sections: [Date: [NewsRecordModelDate]] = createDictionary()
        let section: [FinalSectionModel] = sections.map { (key, values) in
            return FinalSectionModel(nameSection: key, cells: values)
        }
        return section
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sections = dictToArray().sorted(by: { $0.nameSection > $1.nameSection } )
    }
    
    //MARK: - UITableViewDataSource
    
    //количество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    //заголовок секций
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.sections[section]
        let date = section.nameSection
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    //количество строк в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.sections[section]
        return section.cells.count
    }
    //наполнение ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MyTableViewCell {
            let section = self.sections[indexPath.section]
            let textInCell = section.cells[indexPath.row]
            
            cell.newsLabel?.text = textInCell.title
            cell.imageView?.image = Constants.Image.news
            
            func getLabelString() -> String {
                let date = textInCell.publishedAt
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
                return dateFormatter.string(from: date)
            }
            cell.dateLabel?.text = getLabelString()
            return cell
        }
        return UITableViewCell()
    }
    //ширина ячейки
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    //высота хедера
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    //цвет текста в хедере
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
}

