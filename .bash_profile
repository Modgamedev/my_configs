# ~/.bash_profile — загружается при логине Bash

export LANG=en_US.UTF-8        # базовая локаль, английский, UTF-8
export LC_CTYPE=ru_RU.UTF-8    # чтобы русские буквы отображались корректно
export LC_TIME=en_US.UTF-8     # формат даты и времени на английском
export LC_COLLATE=C             # сортировка по ASCII, предсказуемая
export LC_MESSAGES=en_US.UTF-8 # язык сообщений программ на английском
export LC_NUMERIC=en_US.UTF-8  # формат чисел (десятичная точка и т.д.)
export LC_MONETARY=en_US.UTF-8 # формат денежных сумм
export LC_PAPER=en_US.UTF-8    # формат бумаги (размеры страниц)

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"  # путь к пользовательским бинарникам

[[ -f ~/.bashrc ]] && . ~/.bashrc  # подключение интерактивных настроек Bash
