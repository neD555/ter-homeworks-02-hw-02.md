### Домашнее задание к занятию «Основы Terraform. Yandex Cloud»
Цели задания:

1.Создать свои ресурсы в облаке Yandex Cloud с помощью Terraform.

2.Освоить работу с переменными Terraform.

Чек-лист готовности к домашнему заданию

1.Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.

2.Установлен инструмент Yandex CLI.

3.Исходный код для выполнения задания расположен в директории 02/src.

### Задание 0.

Ознакомьтесь с документацией к security-groups в Yandex Cloud. Этот функционал понадобится к следующей лекции.

Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!

### Задание 1.

В качестве ответа всегда полностью прикладывайте ваш terraform-код в git. Убедитесь что ваша версия Terraform ~>1.12.0

1.Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.

2.Создайте сервисный аккаунт и ключ. service_account_key_file.

3.Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную vms_ssh_public_root_key.

4.Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.

5.Подключитесь к консоли ВМ через ssh и выполните команду  curl ifconfig.me. Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: "ssh ubuntu@vm_ip_address". Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: eval $(ssh-agent) && ssh-add Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;

6.Ответьте, как в процессе обучения могут пригодиться параметры preemptible = true и core_fraction=5 в параметрах ВМ.

### В качестве решения приложите:

Скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;

Скриншот консоли, curl должен отобразить тот же внешний ip-адрес;

Ответы на вопросы.

### Ответ.

<img width="649" height="608" alt="Задание 1(1)" src="https://github.com/user-attachments/assets/6082162a-a329-4541-90f9-c5168c1719b2" />

<img width="1480" height="790" alt="Задание 1(2)" src="https://github.com/user-attachments/assets/3ef42202-5c2e-42c8-aa77-d2c10dd75523" />

preemptible = true

– очень дешёвая ВМ

– может быть остановлена облаком

– идеальна для обучения, лабораторных, тестов

core_fraction = 5

– ядро CPU работает с нагрузкой 5%

– ВМ стоит минимально

– подходит для малых задач, демо, лабораторных

### Задание 2.
1.Замените все хардкод-значения для ресурсов yandex_compute_image и yandex_compute_instance на отдельные переменные. К названиям переменных ВМ добавьте в начало префикс vm_web_ . Пример: vm_web_name.

2.Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их default прежними значениями из main.tf.

3.Проверьте terraform plan. Изменений быть не должно.

### Ответ.

Вынесены все константные значения ресурса yandex_compute_instance.vm1 в переменные с префиксом vm_web_:

vm_web_name

vm_web_platform_id

vm_web_zone

vm_web_cores

vm_web_memory

vm_web_core_fraction

vm_web_preemptible

vm_web_image_id

vm_web_nat

Каждой переменной указан type и default, равный прежнему хардкод-значению из main.tf.

В main.tf ресурс yandex_compute_instance.vm1 теперь использует переменные var.vm_web_* вместо прямых значений.

После изменений выполнено:

terraform validate -OK

terraform plan.

### Задание 3.

1.Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.

2.Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: "netology-develop-platform-db" , cores  = 2, memory = 2, core_fraction = 20. Объявите её переменные с префиксом vm_db_ в том же файле ('vms_platform.tf'). ВМ должна работать в зоне "ru-central1-b"

3.Примените изменения.

### Задание 4.

1.Объявите в файле outputs.tf один output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)

2.Примените изменения.

### Задание 5.

1.В файле locals.tf опишите в одном local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.

2.Замените переменные внутри ресурса ВМ на созданные вами local-переменные.

3.Примените изменения.

### Задание 6.
1.Вместо использования трёх переменных ".._cores",".._memory",".._core_fraction" в блоке resources {...}, объедините их в единую map-переменную vms_resources и внутри неё конфиги обеих ВМ в виде вложенного map(object).

пример из terraform.tfvars:

vms_resources = {
  web={
    cores=2
    memory=2
    core_fraction=5
    hdd_size=10
    hdd_type="network-hdd"
    ...
  },
  db= {
    cores=2
    memory=4
    core_fraction=20
    hdd_size=10
    hdd_type="network-ssd"
    ...
  }
}

2.Создайте и используйте отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ.

пример из terraform.tfvars:

metadata = {
  serial-port-enable = 1
  ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
}
3.Найдите и закоментируйте все, более не используемые переменные проекта.

4.Проверьте terraform plan. Изменений быть не должно.
### Ответ.

### vms_platform.tf

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))

  default = {
    web = {
      cores         = 2
      memory        = 2
      core_fraction = 5
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}

### variables.tf
# variable "vms_ssh_public_root_key" {
#   type = string
# }

variable "metadata" {
  type = map(string)
}

### main.tf

resources {
  cores         = var.vms_resources["web"].cores
  memory        = var.vms_resources["web"].memory
  core_fraction = var.vms_resources["web"].core_fraction
}

metadata = var.metadata

### terraform.tfvars

metadata = {
  ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINwDlw8SPFFvDWxzyZiThG/2COif0auGHXVu7C93VzK7 den@rmq01"
}






