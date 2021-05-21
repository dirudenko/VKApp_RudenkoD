//
//  TabBarController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fillUsers()
        fillGroups()
        fillPosts()
    }
  
  func fillUsers() {
    let user1 = User(name: "Tim Cook", age: 60, avatar: UIImage(named: "Tim Cook")!, photoArray: [UIImage(named: "Tim Cook 1")!, UIImage(named: "Tim Cook 2")!, UIImage(named: "Tim Cook 3")!, UIImage(named: "Tim Cook 4")!], job: "Apple")
    let user2 = User(name: "Bill Gates", age: 65, avatar: UIImage(named: "Bill Gates")!, photoArray: [UIImage(named: "Bill Gates 1")!, UIImage(named: "Bill Gates 2")!, UIImage(named: "Bill Gates 3")!, UIImage(named: "Bill Gates 4")!, UIImage(named: "Bill Gates 5")!], job: "ex-Microsoft")
    let user3 = User(name: "Elon Musk", age: 49, avatar: UIImage(named: "Elon Musk")!, photoArray: [UIImage(named: "Elon Musk 1")!, UIImage(named: "Elon Musk 2")!, UIImage(named: "Elon Musk 3")!, UIImage(named: "Elon Musk 4")!], job: "Tesla, SpaceX")
    let user4 = User(name: "Jeff Bezos", age: 57, avatar: UIImage(named: "Jeff Bezos")!, photoArray: [UIImage(named: "Jeff Bezos 1")!, UIImage(named: "Jeff Bezos 2")!, UIImage(named: "Jeff Bezos 3")!, UIImage(named: "Jeff Bezos 4")!, UIImage(named: "Jeff Bezos 5")!], job: "Amazon")
    let user5 = User(name: "Jack Doursey", age: 44, avatar: UIImage(named: "Jack Doursey")!,photoArray: [UIImage(named: "Jack Doursey 1")!, UIImage(named: "Jack Doursey 2")!, UIImage(named: "Jack Doursey 3")!, UIImage(named: "Jack Doursey 4")!, UIImage(named: "Jack Doursey 5")!], job: "Twitter")
    let user6 = User(name: "Sergey Brin", age: 47, avatar: UIImage(named: "Sergey Brin")!,photoArray: [UIImage(named: "Sergey Brin 1")!, UIImage(named: "Sergey Brin 2")!, UIImage(named: "Sergey Brin 3")!, UIImage(named: "Sergey Brin 4")!], job: "Google")
    let user7 = User(name: "Linus Torvalds", age: 51, avatar: UIImage(named: "Linus Torvalds"), photoArray: [UIImage(named: "Linus Torvalds 1")!, UIImage(named: "Linus Torvalds 2")!, UIImage(named: "Linus Torvalds 3")!, UIImage(named: "Linus Torvalds 4")!], job: "Linux Foundation")
    let user8 = User(name: "Craig Federighi", age: 51, avatar: UIImage(named: "Craig Federighi"), photoArray: [UIImage(named: "Craig Federighi 1")!, UIImage(named: "Craig Federighi 2")!, UIImage(named: "Craig Federighi 3")!, UIImage(named: "Craig Federighi 4")!], job: "Apple")
    
    let users: [User] = [user1, user2, user3, user4, user5, user6, user7, user8]
    DataStorage.shared.usersArray.append(contentsOf: users)
    let usersDictionary = Dictionary(grouping: DataStorage.shared.usersArray, by: { $0.name.first! }).sorted(by: { $0.key < $1.key }).map({ (char:$0.key, User:$0.value)})
    DataStorage.shared.groupedPeople.append(contentsOf: usersDictionary)
  }
  
  func fillGroups() {
    let group1 = Group(name: "GeekBrains", description: "Группа для студентов GeekBrains", groupImage:  UIImage(named: "gb"))
    let group2 = Group(name: "Mobile Developer", description: "Группа для мобильных разработчиков", groupImage: UIImage(named: "mobile"))
    let group3 = Group(name: "iOS Developer", description: "Группа для iOS разработчиков", groupImage: UIImage(named: "swift"))
    let group4 = Group(name: "Forbes TOP 100", description: "Группа для членов Forbes TOP 100", groupImage: UIImage(named: "forbes"))
    let group5 = Group(name: "Summer Vacation", description: "Обсуждение грядущих отпусков", groupImage: nil)
    
    let allGroups: [Group] = [group1, group2, group3, group4, group5]
    let myGroups: [Group] = [group1, group5]
    DataStorage.shared.allGroup.append(contentsOf: allGroups)
    DataStorage.shared.myGroup.append(contentsOf: myGroups)
  }
  
  func fillPosts() {
    let post1 = Post(createdBy: DataStorage.shared.usersArray[0], caption:" Apple представила новый курс для самостоятельного изучения — Apple Teacher Portfolio. Он поможет преподавателям сделать любые уроки более интересными — вне зависимости от того, где проходят занятия. Также Apple обновляет приложения «Задания» и «Класс» и популярную учебную программу Everyone Can Create — в неё будут добавлены все самые новые функции iPad и приложений Apple.\n«Уже более 40 лет компания Apple сотрудничает с учебными заведениями и создаёт продукты, которые помогают в учёбе, — отметила Сьюзан Прескотт, вице-президент Apple по взаимодействию с разработчиками и маркетингу продуктов для корпоративной сферы и образования. — Чтобы школы могли в полной мере использовать все возможности наших продуктов, мы подготовили курс профессионального обучения Apple Teacher Portfolio. Он позволит преподавателям более уверенно адаптировать свои занятия, а значок станет признанием той замечательной работы, которую они делают каждый день. После такого непростого года мы хотим поддержать преподавателей, потому что они служат примером для всех нас».", numberOfLikes: Int.random(in: 100...900), numberOfComments: Int.random(in: 10...50), numberOfShares: Int.random(in: 10...50), numberOfViews: Int.random(in: 1...13), image1: UIImage(named: "apple"), image2: nil)
    let post2  = Post(createdBy: DataStorage.shared.usersArray[1], caption: "Печальная реальность в том, что COVID-19, возможно, не последняя пандемия. Мы не знаем, когда наступит следующий удар, будет ли это грипп, коронавирус или какая-то новая болезнь, которую мы никогда раньше не видели. Но мы точно знаем, что не можем позволить, чтобы нас снова застали врасплох. Угроза следующей пандемии всегда будет висеть над нашими головами — если только мир не предпримет шаги для ее предотвращения", numberOfLikes: Int.random(in: 100...500), numberOfComments: Int.random(in: 10...50), numberOfShares: Int.random(in: 10...50), numberOfViews: Int.random(in: 1...10), image1: nil)
    let post3 = Post(createdBy: DataStorage.shared.usersArray[2], caption: "Транспортная система The LVCC Loop system была построена примерно за один год с использованием туннельной бурильной машины Godot. Стоимость LVCC Loop составила приблизительно 52,5 миллионов долларов — в эту сумму входят как затраты на туннельные работы, так и на наземные станции.\n Длина каждой из четырех секций туннеля равна 0,4 мили (0,6 км) — в общей сложности «петля» тоннеля равна 1,7 мили (2,7 км). Поездка сопровождается светом динамичных разноцветных огней, из-за чего сотрудники проекта прозвали тоннель «Радужная дорога».\n Проект создан по заказу выставочного комплекса Las Vegas Convention Center (LVCVA) в Уинчестере, Невада. Туннель соединяет новый выставочный зал LVCC с существующим кампусом из трех других залов. Идея заключалась в том, чтобы перемещать посетителей мероприятий центра по территории пространства. До пандемии коронавируса центр собирал десятки тысяч человек в четырех выставочных залах. Парк включает в себя модифицированные седаны Tesla. Благодаря тоннелю 45-минутный путь по кампусу для посетителей сократится примерно до 2 минут.", numberOfLikes: Int.random(in: 100...900), numberOfComments: Int.random(in: 10...50), numberOfShares: Int.random(in: 10...50), numberOfViews: Int.random(in: 1...10), image1: UIImage(named: "lvcc"), image2: nil)
    let post4 = Post(createdBy: DataStorage.shared.usersArray[6], caption: "Я думаю, что в частности это присутствует и у электронной почты, и я уже говорил однажды: «В интернете никто не улавливает ваших намёков». Когда вы не говорите с человеком лично, лицом к лицу, и пропускаете все обычные социальные подсказки, легко не только упустить юмор или сарказм, но и пропустить реакцию оппонента, из-за чего появляются такие вещи, как флейм, и т.п., чего не происходит при личном общении.\n Однако емейл работает до сих пор. Вам нужно потратить усилия на то, чтобы написать письмо, и у него есть определённое содержимое, техническое или какое-то другое. Вся эта модель с «лайками» и «поделиться» – это мусор. Никаких усилий, никакого контроля качества. На самом деле, всё работает, как противоположность контролю качества – клик-бейты, вещи, заточенные под эмоциональный отклик, и т.п.\n Добавьте сюда анонимность, и получите нечто отвратительное. Если вы даже не подписываете своим именем этот мусор (или мусор, которым вы делитесь или который лайкаете), это не исправляет ситуацию.\n Я один из тех, кто считает, что анонимность переоценивается. Некоторые люди путают приватность с анонимностью, считают, что они взаимосвязаны, и что защита приватности подразумевает защиту анонимности. Думаю, это неверно. Анонимность важна для информаторов, но если вы не можете доказать, что вы тот, за кого себя выдаёте, то ваша безумная болтовня на какой-нибудь социальной платформе не должна быть видна, и вы не должны иметь возможность лайкать её или делиться.\n Ну и ладно – болтайте дальше. Меня нет ни в каких соцсетях (я одно время пробовал G+, потому что в ней не было этой обычной безмозглой ерунды, но она ни к чему не пришла), но они всё равно меня раздражают.", numberOfLikes: Int.random(in: 100...900), numberOfComments: Int.random(in: 10...50), numberOfShares: Int.random(in: 10...50), numberOfViews: Int.random(in: 1...10), image1: UIImage(named: "linux"), image2: nil)
    var posts = [post1, post2, post3, post4]
    posts.shuffle()
    DataStorage.shared.postedNews.append(contentsOf: posts)
  }
  
}
