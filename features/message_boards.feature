# language: bg
Функционалност: Форуми
  За да мога да науча повече, да споделя нещо интересно или да задам въпрос
  като студент
  искам да мога да участвам в дискусионен форум с преподавателите и другите студенти

  Сценарий: Създаване на тема
    Дадено че съм студент
    Когато отида на заглавната страница на форумите
    И проследя "Нова тема"
    И попълня:
      | Заглавие   | Моята тема           |
      | Съдържание | Текста на моята тема |
    И натисна "Публикувай"
    То трябва да съм на темата "Моята тема"
    И трябва да виждам "Текста на моята тема"
