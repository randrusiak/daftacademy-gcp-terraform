# Daftacademy GCP Infrastructure

Infrastruktura dla [demo-app](https://github.com/randrusiak/daftacademy-gcp-demo-app) przygotowana na potrzeby zajęć DaftAcademy - Google Cloud Computing Foundations. 

Więcej szczegółów: 
 - [daftacademy.pl](https://daftacademy.pl/courses/ZPptVZ)
 
## Wymagania wstępne

Na zajęciach skupimy się na omówieniu konceptu **Infrastruktura jako kod** (IaC) z wykorzystaniem narzędzia [terraform](https://www.terraform.io/). 
Zagadnienia niezwiązane bezpośrednio z IaC lub terraformem będa powierzchownie wytłumaczone. 
Żeby w pełni wykorzystać zajęcia proszę o odświeżenie wiedzy z zakresu:
 - [Czym są kontenery?](https://cloud.google.com/learn/what-are-containers)
 - [Cloud Run](https://cloud.google.com/run)

Oprócz tego proszę o zainstalowanie i skonfigurowanie poniższych narzędzi. 

- [terraform](https://www.terraform.io/downloads.html) >= 0.15.4 
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) >= 342.0.0

### Konfiguracja Google Cloud SDK

Po zainstalowaniu i zweryfikowaniu wersji Google Cloud SDK: `gcloud version` możemy przystąpić do konfiguracji.

Najprostszą metodą jest wykorzystanie polecenia `init`:

    gcloud init

Jeśli wcześniej nie korzystaliśmy z narzędzia `gcloud` zostanie wygenerowany link, pod który trzeba wejść i wybrać konto google, które zostanie powiązane z konfiguracją `gcloud`.

Po zakończeniu konfiguracji konta zostaniemy zapytani o wybór projektu. Wybieramy ostatnią opcję tj. `Create a new project` i podajemy nazwę nowego projektu.

W kolejnym kroku włączymy API, z których będziemy korzystać poprzez terraforma.*

    gcloud services enable compute.googleapis.com
    gcloud services enable vpcaccess.googleapis.com
    gcloud services enable servicenetworking.googleapis.com
    gcloud services enable secretmanager.googleapis.com
    gcloud services enable run.googleapis.com  

Jeśli przy próbie włączenia compute.googlapis.com pojawi się błąd dotyczący brakującego `billing account` należy je aktywować dla projektu, wchodząc na: https://console.cloud.google.com/billing/projects

\* *Aktywacja konkretnych APIs może być również wykonana bezpośrednio przez terraforma. Czasem włączenie API w nowym projekcie trwa dłuższą chwilę, przez co może wystąpić błąd po stronie terraforma. Dlatego w przypadku naszych zajęć lepiej je włączyć chwile wcześniej, żeby uniknąć niepotrzebnych problemów.*
