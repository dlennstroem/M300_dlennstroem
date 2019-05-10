# Doku LB3
Dokumentation der LB3 von David Lennström.

## K1
Folgende Software habe ich installiert, damit alles so läuft wie es sollte:
 - VirtualBox für das Virtualisieren
 - Vagrant damit VMs automatisiert aufgesetzt werden können.
 - VS-Code (Bereits installiert) -> Vagrant Extension wurde auch noch   
   installiert.
 - Git-Client für die Versionskontrolle
 - SSH-Key für den Client hinterlegt
 - Docker-extension installiert.

## K2 Repository
### 2.1. GitHub
Ich hatte schon vor dem Modul einen GitHub-Account. -> Username: dlennstroem, Repo: https://github.com/dlennstroem/M300_dlennstroem

### 2.2. Markdown
Ich habe den Markdown vor allem in VsCode geschrieben, da alles bereits installiert war.

## K3 Applikation
### 3.1. Theorie
#### Container
Ein Container ist ein Prozess (oder eine Sammlung davon), welcher abgekapselt auf einem separatem Image ausgeführt wird. Alle benötigten Ressourcen werden von diesem Image bereitgestellt. Dies verschaft dem Container den Vorteil der Portabillität. Ausserdem sind Container ressourcenschonend und schnell.

### Docker Befehle
Docker arbeitet mit so genannten "Dockerfiles". In diesen Dateien wird die Konfig für ein Container reingeschrieben.
Nachfolgend sind die wichtigsten Befehle für die verwendung von Docker aufgelistet:
  - *docker run [Argumente]* -> Startet ein Container.
    * -d -> Startet den Container im Hintergrund.
    * --rm -> Löscht den Container
  - *docker ps* -> Zeigt alle laufenden Container an.
    * -a -> Zeigt alle Container an. (aktive und inakktive)
    * -q -> Zeigt nur die IDs an.
- *docker images* -> Zeigt alle lokalen images an.
- *docker rm* -> Löscht einen oder mehrere Container.
- *docker rmi* -> Löscht images

Wenn man nun ein Dockerfile hat, kann man mit *docker build -t [image_name] .* ein Dockerimage erstellen. Kontrollieren, ob das Image erstellt wurde kann man mit dem Befehl *docker images*.

### 3.2. Umsetzung
#### Die Container
Ich habe eine Entwicklungsumgebung für php aufgesetzt mit Verbindung zu einer MySQL-DB über einen Apache-Webserver. Alle Container habe ich in einem YML-File definiert. So kann alles gleichzeitig gestartet werden. Zuerst wollte ich alles mit Docker for Windows erstellen, dies ist aber nicht gegangen, obwohl ich Windows 10 Pro installiert habe. Also habe ich stattdessen schnell eine Ubuntu-VM mit Docker drauf über Vagrant erstellt, und alles darauf gemacht. 

#### Aufbau

Folgende Dateien / Verzeichnisse werden bennötigt:

| <tab>              | <tab>                                                       |
| ------------------ | ----------------------------------------------------------- |
| **Datei**          | Verwendung                                                  |
| docker-compose.yml | In dieser Datei werden alle Container definiert             |
| Ordner PHP         | Dieser Ordner wird für den Container WEB benötigt           |
| index.php          | Die Datei "index.php" dient als Testdatei für den Webserver |
 
#### Docker-Compose
Hier ist noch das YML-File. Ich musste die Parameter zur CPU und Memory-Begrenzung auskommentieren, das es nicht funktioniert hat mit ihnen. Im nachhinein habe ich noch herausgefunden, dass ich eine andere Version hätte nehmen können, dan hätte es funktioniert.

~~~~
version: "2.2"

services:

  pihole:
      container_name: pihole
      image: pihole/pihole:latest
      ports:
        - "53:53/tcp"
        - "53:53/udp"
        - "67:67/udp"
        - "80:80/tcp"
        - "443:443/tcp"
      environment:
        TZ: 'Europe/Zurich'
        WEBPASSWORD: '1234'
      volumes:
        - './etc-pihole/:/etc/pihole/'
        - './etc-dnsmasq.d/:/etc/dnsmasq.d/'
      dns:
        - 127.0.0.1
        - 1.1.1.1
      restart: unless-stopped

      #cpus: 1
      #mem_limit: 1024m


  db:
    image: mysql:5.7
    container_name: db_mysql
    environment:
      MYSQL_ROOT_PASSWORD: 1234
      MYSQL_DATABASE: dbteset
      MYSQL_USER: dbuser
      MYSQL_PASSWORD: 1234
    ports:
      - "9906:3306"
    #cpus: 1
    #mem_limit: 1024m


  web:
    image: php:7.2.2-apache
    container_name: php_web
    volumes:
      - ./php/:/var/www/html/
    ports:
      - "8100:80"
    stdin_open: true
    tty: true
      
    #cpus: 1
    #mem_limit: 1024m


  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    container_name: phpmyadmin
    links:
        - db:db
    ports:
        - 8080:80
    restart: on-failure
    environment:
        MYSQL_ROOT_PASSWORD: 1234
    #cpus: 1
    #mem_limit: 1024m

# monitoring gui
  cadvisor:
    image: google/cadvisor:v0.29.0
    container_name: cadvisor
    command: -storage_driver_db=cadvisor
    restart: on-failure
    ports:
      - "8888:8080"
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:rw
      - /sys:/sys:ro
      - /var/lib/docker/:/var/lib/docker:ro
    #cpus: 1
#mem_limit: 1024m
~~~~

#### Centos-VM (Vagrant)
Ursprünglich wollte ich alles auf meinem Notebook lokal machen, dies hat aber leider nicht geklappt, deshalb habe ich mit Vagrant kurzerhand eine CentOS 7 Box installiert und alles darauf gemacht.

##### Vagrantfile
~~~~# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "centos/7"
    #config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "private_network", type: "dhcp"
    config.vm.synced_folder ".", "/docker_dl", nfs: true
    
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"  
    end
  end
~~~~

##### Konfig auf der VM
Diese Schritte hätte man auch direkt ins Vagrantfile schreiben können, ich habe dies aber erst im nachhinein bemerkt.

- Docker installieren: `yum install -y docker`
- Gemäss dieser anleitung habe ich noch docker-compose installiert: https://linuxize.com/post/how-to-install-and-use-docker-compose-on-centos-7/
- Docker-Gruppe erstellt und User reingetan: `groupadd docker ; usermod -aG docker $USER `
- Danach habe ich docker-compose gestartet, im Verzeichniss vom YML-File. `docker-compose up -d`

#### Pihole

| <tab>             | <tab>                                                       |
| ----------------- | ----------------------------------------------------------- |
| **Configuration** | Value                                                       |
| Container Name    | pihole                                                      |
| Image             | pihole/pihole:latest                                        |
| Ports             | 53:53/tcp , 53:53/udp , 67:67/udp , 80:80/tcp , 443:443/tcp |
| Volumes           | -                                                           |
| DNS               | 127.0.0.1, 1.1.1.1                                          |

#### MySQL
Dieser Container beinhaltet eine MySQL Datenbank

| <tab>               | <tab>     |
| ------------------- | --------- |
| **Configuration**   | Value     |
| Container Name      | db_mysql  |
| Image               | mysql:5.7 |
| Ports               | 9906:3306 |
| Volumes             | -         |
| MYSQL_ROOT_PASSWORD | 1234      |
| MYSQL_DATABASE      | dbteset   |
| MYSQL_USER          | dbuser    |
| MYSQL_PASSWORD      | 1234      |
 
#### Web
Dieser Container beinhaltet einen Apache2 Webserver

| <tab>             | <tab>                 |
| ----------------- | --------------------- |
| **Configuration** | Value                 |
| container_name    | php_web               |
| Image             | php:7.2.2-apache      |
| Ports             | 8100:80               |
| Volumes           | ./php/:/var/www/html/ |


#### Phpmyadmin
Dieser Container beinhaltet PHP MyAdmin, welche auf den Contaienr db_mysql verlinkt ist. 

| <tab>             | <tab>                  |
| ----------------- | ---------------------- |
| **Configuration** | Value                  |
| container_name    | phpmyadmin             |
| Image             | phpmyadmin/phpmyadmin. |
| Ports             | 8080:80                |
| Volumes           | -                      |

#### Cadvisor
Dieser Container beinhaltet das Überwachungstool Cadvisor. 

| <tab>             | <tab>                                                                                      |
| ----------------- | ------------------------------------------------------------------------------------------ |
| **Configuration** | Value                                                                                      |
| container_name    | cadvisor                                                                                   |
| Image             | google/cadvisor:v0.29.0                                                                    |
| Ports             | 8888:8080                                                                                  |
| Volumes           | /:/rootfs:ro ,/var/run:/var/run:rw ,  /sys:/sys:ro , /var/lib/docker/:/var , lib/docker:ro |



## K4 Containerabsicherung
### Cadvisor
cAdvisor ist ein Überwachungstool von Google, welches selber als Container läuft. In dieser Umgebung überwacht es die zu Verfügung gestellten CPUs und den Zugriff auf den RAM. Ebenfalls wird die Aulastung der Netzwerkkarten angezeigt. 

### Limitierung der Ressourcen
Da unser Hostsystem nur begrenz Ressourcen hat, wird für jeden Container ein CPU und Memory Limit gesetzt. Somit ist gewährleistet, dass kein Container zu viele Ressourcen benötigt und somit den Host zum abstürzen bringen kann. Beim testen hat dies leider nicht ganz geklappt, die Parameter zu CPU und Memory hat es im YML-File nicht erkannt. Im nachhinein habe ich herausgefunden, dass es am Versions-Tag gelegen hat.

### Benchmark Security Tool
Mit dem Skript Docker Bench Security kann die Sicherheit der Container überprüft werden. 
Das Skript ist als Github Repository verfügbar: https://github.com/docker/docker-bench-security
Sobald das Skript erfolgreich durchgelaufen ist, kann der Report des Skriptes angeschaut werden und die dementsprechenden Sicherheitseinstellungen konfiguriert werden. Ich hatte leider keine Zeit mehr, um das Skript laufen zu lassen.


## K5 Reflexion 

Ich habe in diesem Modul sehr viel neues dazugelernt. Zu beginn von M300 waren mir Container nur ein wager Begriff. Dank der LB3 habe ich nochmals sehr viel dazugelernt, vor allem über Docker-Compose und YML-Files. Zwar hatte ich zu Beginn ein wenig Mühe das Konzept mit den Container zu verstehen. Aber mit der Zeit hat es mir sehr Spass gemacht. Leider musste ich gegen Ende des Moduls recht stressen und konnte nicht alles fertig machen.  
