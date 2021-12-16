begin
  if (Partner.present? and not Partner.exists?)
    Partner.create name: "КОНОПЕЛЬ",     code: 'kono',  kind: 3, role: 0, url: "https://konopel.ru"
    Partner.create name: "ЯндексМаркет", code: 'ymrkt', kind: 3, role: 1, url: "https://market.yandex.ru", comment: "Прекратило деятельность 01.09.2021", status: 1
    Partner.create name: "МОДУЛЬКАССА",  code: 'mokas',          role: 2, url: "https://modulkassa.ru"
    puts "===== 'Partner' record(s) created"
  else
    puts "===== 'Partner' seeding skipped"
  end
rescue
  puts "----- Achtung! Something went wrong ('Partner' entity does not exist?)"
end