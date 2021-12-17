begin
  if (Partner.present? and not Partner.exists?)
    Partner.create name: "КОНОПЕЛЬ", 
        code: 'kono',  kind: 3, role: 0, 
        title: 'ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ "ПРОИЗВОДСТВЕННАЯ КОМПАНИЯ "КОНОПЕЛЬ"', 
        email: 'kono@dummy.com', url: "https://konopel.ru",
        inn: '5250062707', kpp: '525001001',
        ogrn: '1155250001125', ogrnip: '',
        okpo: '48314529', okato: '',
        comment: 'Олег Петрухин, Специалист оптовых продаж'

    Partner.create name: "ЯндексМаркет", 
        code: 'yamrkt', kind: 3, role: 1, 
        title: 'ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ "ЯНДЕКС.МАРКЕТ"',
        url: "https://market.yandex.ru", 
        inn: '7704357909', kpp: '997750001', ogrn: '1167746491395',
        comment: "Прекратило деятельность 01.09.2021",
        status: 1

    Partner.create name: "Яндекс", 
        code: 'yndx', kind: 3, role: 1, 
        title: 'ООО "ЯНДЕКС"',
        url: "https://market.yandex.ru", 
        inn: '7736207543', kpp: '997750001', ogrn: '1027700229193'

        Partner.create name: "МОДУЛЬКАССА",
        code: 'mokas', role: 2, 
        title: 'Общество с ограниченной ответственностью"Аванпост"',
        email: 'info@modulkassa.ru', url: "https://modulkassa.ru",
        inn: '5403011237', kpp: '5403011237', ogrn: '1155476129753'

        Partner.create name: "HempForLife",
        code: 'hfl', kind: 1, role: 0,
        title: 'Индивидуальный предприниматель Ларин Сергей Александрович',
        url: "https://modulkassa.ru",
        inn: '526106622190', okpo: '0164755845', ogrnip: '316527500010692'
        
    Partner.create name: "BFactor",
        code: 'bf', kind: 1, role: 0,
        title: 'Индивидуальный предприниматель Губаева Диана Дамировна', 
        email: 'info@bfactor.ru', url: "https://bfactor.ru",
        inn: '770504186260', okpo: '0193850636', ogrnip: '314774628701512'

    puts "===== 'Partner' record(s) created"
  else
    puts "===== 'Partner' seeding skipped"
  end
rescue
  puts "----- Achtung! Something went wrong ('Partner' entity does not exist?)"
end