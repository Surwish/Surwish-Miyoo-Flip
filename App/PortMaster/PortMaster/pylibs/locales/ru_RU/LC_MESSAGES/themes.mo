��          �      |      �  9   �  Z   +  �   �  �   �  �     �   
     �  �   �  b   j     �  �   M  C     X   J  �   �  =   '	  �   e	  �   Y
  �   �
  k   �  �     f     >  j  B   �  a   �  U  N  �   �    k  �   �     P  �   h  �   A  �   �    �  C   �  �   �  �   n  J     ^  X  �   �  �   m  �   $    �  {   �                                 
                       	                                         Creator: {theme_info.creator}
Status: {theme_info.status} Filters: {if:!ports_list.total_ports::ports_list.filter_ports} {ports_list.filters}{endif} Free Space: {system.free_space}

Porter: {port_info.porter}
Genres: {port_info.genres}
Download Size: {port_info.download_size}{if:port_info.runtime}
Runtime: {port_info.runtime} ({port_info.runtime_status}){endif}

Instruction: {port_info.instructions} Genres: {port_info.genres}
Download Size: {port_info.download_size}{if:port_info.runtime}
Runtime: {port_info.runtime} ({port_info.runtime_status}){endif} Genres: {port_info.genres}
{if:port_info.install_size}Installed Size: {port_info.install_size}{else}Download Size: {port_info.download_size}{endif}{if:port_info.runtime}
Runtime: {port_info.runtime} ({port_info.runtime_status}){endif} Genres: {port_info.genres}    Download Size: {port_info.download_size}{if:port_info.runtime}    Runtime: {port_info.runtime} ({port_info.runtime_status}){endif} IP: {system.ip_address} Name: {runtime_info.name}
Status: {runtime_info.status}
Ports: {runtime_info.ports}
Download Size: {runtime_info.download_size}
Install Size: {runtime_info.disk_size} PM: {system.portmaster_version}
HM: {system.harbourmaster_version}
Space: {system.free_space} free PM: {system.portmaster_version}
HM: {system.harbourmaster_version}
Space: {system.free_space} free / {system.total_space} total PM: {system.portmaster_version}
HM: {system.harbourmaster_version}
Space: {system.free_space} free / {system.total_space} total
Time: {system.time_24hr}
Battery: {system.battery_level} PM: {system.portmaster_version}, HM: {system.harbourmaster_version} Time: {system.time_24hr}
Battery: {system.battery_level}
Space: {system.free_space} free Time: {system.time_24hr}
CFW: {system.cfw_name} ({system.cfw_version})
Device: {system.device_name}
Battery: {system.battery_level} Time: {system.time_24hr}      Battery: {system.battery_level} Title: {port_info.title}
Porter: {port_info.porter}
Genres: {port_info.genres}
Download Size: {port_info.download_size}{if:port_info.runtime}
Runtime: {port_info.runtime} ({port_info.runtime_status}){endif}
Description: {port_info.description} {if:!ports_list.total_ports::ports_list.filter_ports}Available Ports: {ports_list.filter_ports} / {ports_list.total_ports} 
Filters: {ports_list.filters}{endif} {if:!ports_list.total_ports::ports_list.filter_ports}Available Ports: {ports_list.filter_ports} / {ports_list.total_ports}  
Filters: {ports_list.filters}{endif} • Creator: {theme_info.creator}
• Status: {theme_info.status}
• Description:
{theme_info.description} • Genres: {port_info.genres}
• Download Size: {port_info.download_size}{if:port_info.runtime}
• Runtime: {port_info.runtime} ({port_info.runtime_status}){endif}
• Description: {port_info.description}
• Instructions:
{port_info.instructions} • Porter: {port_info.porter}
• Genres: {port_info.genres}
• Description: {port_info.description} Project-Id-Version: portmaster
Report-Msgid-Bugs-To: 
PO-Revision-Date: 2025-03-05 09:46
Last-Translator: 
Language-Team: Russian
Language: ru_RU
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Plural-Forms: nplurals=4; plural=((n%10==1 && n%100!=11) ? 0 : ((n%10 >= 2 && n%10 <=4 && (n%100 < 12 || n%100 > 14)) ? 1 : ((n%10 == 0 || (n%10 >= 5 && n%10 <=9)) || (n%100 >= 11 && n%100 <= 14)) ? 2 : 3));
X-Crowdin-Project: portmaster
X-Crowdin-Project-ID: 610497
X-Crowdin-Language: ru
X-Crowdin-File: themes.pot
X-Crowdin-File-ID: 3
 Автор: {theme_info.creator}
Статус: {theme_info.status} Фильтры: {if:!ports_list.total_ports::ports_list.filter_ports} {ports_list.filters}{endif} Свободное место: {system.free_space}

Создатель: {port_info.porter}
Жанры: {port_info.genres}
Размер скачивания: {port_info.download_size}{if:port_info.runtime}
Время выполнения: {port_info.runtime} ({port_info.runtime_status}){endif}

Инструкция: {port_info.instructions} Жанры: {port_info.genres}
Размер загрузки: {port_info.download_size}{if:port_info.runtime}
Время выполнения: {port_info.runtime} ({port_info.runtime_status}){endif} Жанры: {port_info.genres}
{if:port_info.install_size}Установленный размер: {port_info.install_size}{else}Размер загрузки: {port_info.download_size}{endif}{if:port_info.runtime}
Runtime: {port_info.runtime} ({port_info.runtime_status}){endif} Жанры: {port_info.genres}    Размер загрузки: {port_info.download_size}{if:port_info.runtime}    Время выполнения: {port_info.runtime} ({port_info.runtime_status}){endif} IP: {system.ip_address} Имя: {runtime_info.name}
Статус: {runtime_info.status}
Порты: {runtime_info.ports}
Размер установки: {runtime_info.download_size}
Размер установки: {runtime_info.disk_size} PM: {system.portmaster_version}
HM: {system.harbourmaster_version}
Сколько на карте занято: Свободно {system.free_space} / всего PM: {system.portmaster_version}
HM: {system.harbourmaster_version}
Сколько на карте занято: Свободно {system.free_space} / {system.total_space} всего PM: {system.portmaster_version}
HM: {system.harbourmaster_version}
Сколько на карте занято: Свободно: {system.free_space} Свободно / {system.total_space} всего
Время: {system.time_24hr}
Батарея: {system.battery_level} PM: {system.portmaster_version}, HM: {system.harbourmaster_version} Время: {system.time_24hr}
Батарея: {system.battery_level}
Накопитель: {system.free_space} свободно Время: {system.time_24hr}
CFW: {system.cfw_name} ({system.cfw_version})
Устройство: {system.device_name}
Батарея: {system.battery_level} Время: {system.time_24hr}      Батарея: {system.battery_level} Заголовок: {port_info.title}
Портер: {port_info.porter}
Жанры: {port_info.genres}
Размер скачивания: {port_info.download_size}{if:port_info.runtime}
Время выполнения: {port_info.runtime} ({port_info.runtime_status}){endif}
Описание информации о порте: {port_info.description} {if:!ports_list.total_ports::ports_list.filter_ports}Доступные порты: {ports_list.filter_ports} / {ports_list.total_ports} 
Фильтры: {ports_list.filters}{endif} {if:!ports_list.total_ports::ports_list.filter_ports}Доступные порты: {ports_list.filter_ports} / {ports_list.total_ports}  
Фильтры: {ports_list.filters}{endif} • Создатель: {theme_info.creator}
• Статус: {theme_info.status}
• Описание:
{theme_info.description} • Жанры: {port_info.genres}
• Скачать Size: {port_info.download_size}{if:port_info.runtime}
• Runtime: {port_info.runtime} ({port_info.runtime_status}){endif}
• Описание: {port_info.description}
• Инструкции:
{port_info.instructions} • Создатель: {port_info.porter}
• Жанры: {port_info.genres}
• Описание: {port_info.description} 