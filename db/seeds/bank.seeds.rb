begin
  if (Bank.present? and not Bank.exists?)
    Bank.create name: "sber", 
    title:          'Публичное акционерное общество «Сбербанк России»',
    brief_title:    'ПАО Сбербанк',
    legal_address:  'Россия, Москва, 117312, ул. Вавилова, д. 19',
    postal_address: 'Москва, 117997, ул. Вавилова, д. 19',
    phone:          '+74959575731',
    email:          'sberbank@sberbank.ru',
    url:            'www.sberbank.ru',
    corr_acc:       '30101810400000000225', 
    corr_acc_with:  'ГУ Банка России по ЦФО',
    bic:            '044525225',
    inn:            '7707083893',
    kpp:            '773601001',
    ogrn:           '1027700132195',
    okpo:           '00032537',
    okato:          '45293554000'

    Bank.create name: "tinkoff", 
    title:          'Акционерное общество «Тинькофф Банк»',
    brief_title:    'АО «Тинькофф Банк»',
    legal_address:  '127287, г. Москва, ул. Хуторская 2-я, д. 38А, стр. 26',
    postal_address: 'Москва, 127287, ул. Хуторская 2-я, д. 38А, стр. 26; а/я 23, г. Москва, 102001',
    phone:          '88007557549',
    email:          'business.welcome@tinkoff.ru',
    url:            'https://www.tinkoff.ru',
    corr_acc:       '30101810145250000974', 
    corr_acc_with:  'ГУ Банка России по ЦФО',
    bic:            '044525974',
    inn:            '7710140679',
    kpp:            '771301001',
    ogrn:           '1027700132195',
    okpo:           '29290881',
    okato:          '45277586000',
    comment:        'Контакты для (малого) бизнеса'

    if 1 == 2 # Fake for testing
      Bank.create name: "looser", 
      title:          'Закрытое акционерное общество «Лузер Банк»',
      brief_title:    'ЗАО «Лузер Банк»',
      legal_address:  '123456, г. Москва, Виртуальная ул, д. 11',
      postal_address: '123456, г. Москва, Красная пл, д.5 ',
      phone:          '+74951234567',
      email:          'biz@lb.ru',
      url:            'https://www.lb.ru',
      corr_acc:       '30101810145250000974', 
      corr_acc_with:  'ГУ Банка России по ЦФО',
      bic:            '044525974',
      inn:            '9047966340',
      kpp:            '012701909',
      ogrn:           '2067925009470',
      # okpo:           '',
      # okato:          '',
      comment:        'Контакты для (малого) бизнеса'
  
    end

    puts "===== 'Bank' record(s) created"
  else
    puts "===== 'Bank' seeding skipped"
  end
rescue
  puts "----- Achtung! Something went wrong ('Bank' entity does not exist?)"
end
