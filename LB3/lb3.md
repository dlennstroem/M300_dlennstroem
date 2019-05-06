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

## K2
### 2.1. Container
Ein Container ist ein Prozess (oder eine Sammlung davon), welcher abgekapselt auf einem separatem Image ausgeführt wird. Alle benötigten Ressourcen werden von diesem Image bereitgestellt. Dies verschaft dem Container den Vorteil der Portabillität. Ausserdem sind Container ressourcenschonend und schnell.


## K3
### 3.1. Verwendete Docker-Container

### 3.2. Docker Befehle
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
## K4

## K5

## K6
