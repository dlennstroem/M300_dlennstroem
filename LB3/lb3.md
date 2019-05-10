# Doku LB3
Dokumentation der LB3 von D<bid Lennström.

## Links:
https://github.com/mc-b/M300/tree/master/30-Container
https://github.com/mc-b/M300/blob/master/30-Container/LB3.md

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
#### 3.1.1.  Container
Ein Container ist ein Prozess (oder eine Sammlung davon), welcher abgekapselt auf einem separatem Image ausgeführt wird. Alle benötigten Ressourcen werden von diesem Image bereitgestellt. Dies verschaft dem Container den Vorteil der Portabillität. Ausserdem sind Container ressourcenschonend und schnell.

### 3.1.2. Docker Befehle
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
#### 3.2.1. Die Container
Ich habe eine Entwicklungsumgebung für php aufgesetzt mit Verbindung zu einer MySQL-DB über einen Apache-Webserver. Alle Container habe ich in einem YML-File definiert. So kann alles gleichzeitig gestartet werden. Zuerst wollte ich alles mit Docker for Windows erstellen, dies ist aber nicht gegangen, obwohl ich Windows 10 Pro installiert habe. Also habe ich stattdessen schnell eine Ubuntu-VM mit Docker drauf über Vagrant erstellt, und alles darauf gemacht. 

#### 3.2.2. Aufbau

##### Netzplan

##### Ordnerstruktur
Folgende Dateien / Verzeichnisse werden bennötigt:

| <tab>              | <tab>                                                       |
| ------------------ | ----------------------------------------------------------- |
| **Datei**          | Verwendung                                                  |
| docker-compose.yml | In dieser Datei werden alle Container definiert             |
| Ordner PHP         | Dieser Ordner wird für den Container WEB benötigt           |
| index.php          | Die Datei "index.php" dient als Testdatei für den Webserver |

#### 3.2.3. Ubuntu-VM (Vagrant)
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

#### 3.2.4. MySQL

#### 3.2.5. PHP

##### Dockerfile


#### 3.2.6. Apache

##### apache.conf
Hier noch das Config-File für den Apache-Dienst

##### Dockerfile


#### 3.2.8. Testwebsite




## K4 Testing

## K5

## K6
