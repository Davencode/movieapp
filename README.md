# 🎬 **Moviepedia**

**Moviepedia** è un'applicazione mobile sviluppata in **Flutter** che permette di scoprire film in modo semplice e intuitivo. L'app utilizza il **BLoC pattern** per la gestione dello stato e si interfaccia con l'API di **TheMovieDB** per ottenere informazioni aggiornate sui film.

---

## 🚀 **Caratteristiche principali**
- **Esplorazione di film:** Visualizza i film più popolari, in uscita e consigliati.
- **Ricerca avanzata:** Trova i film tramite ricerca testuale.
- **Dettagli completi:** Visualizza trama, valutazioni e trailer dei film.
- **Gestione dello stato con BLoC:** Architettura reattiva e gestione chiara degli stati.

---

## 🛠 **Tecnologie utilizzate**
- **Flutter**: Framework UI open-source per lo sviluppo multipiattaforma.
- **BLoC (Business Logic Component)**: Pattern per la gestione dello stato.
- **TheMovieDB API**: Fonte dati per film, trailer e dettagli.

---

## 📂 **Struttura del progetto**
```
movieapp/
├── lib/
│   ├── bloc/
│   │   └── movie_bloc/                 
│   │       ├── movie_bloc.dart    
│   │       ├── movie_event.dart
│   │       └── movie_state.dart     
│   │           
│   ├── datamodel/
│   │   └── movie_model.dart        
│   │
│   ├── repositories/
│   │   └── movie_repository.dart 
│   │
│   ├── screens/
│   │   ├── homepage.dart          
│   │   ├── movie_detail.dart      
│   │   ├── search_movie.dart        
│   │   ├── settings.dart           
│   │   └── top_rated_movie.dart           
│   │
│   ├── services/
│   │   ├── authentication.dart      
│   │   └── movies.dart   
│   │
│   ├── theme/
│   │
│   ├── utilies/
│   │   └── strings.dart
│   │
│   └── widgets/
│
└── pubspec.yaml                  
```

---

## 💡 **Prossimi sviluppi**
- Implementazione di una sezione "TopRated".
- Notifiche push per nuove uscite.
- Supporto multilingua.

---
