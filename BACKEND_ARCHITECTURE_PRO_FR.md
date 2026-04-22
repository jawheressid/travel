# Architecture Backend Professionnelle Complete - HKEYETNA

## 1. Objectif

Cette version ne decrit pas seulement un MVP. Elle decrit une **architecture cible professionnelle** pour une plateforme de planification, recommandation et reservation touristique complete pour la Tunisie, avec :

- planification intelligente porte a porte
- catalogue multi-fournisseurs
- inventaire et disponibilites
- prix dynamiques
- reservation et paiement
- assurance optionnelle
- portail partenaires
- backoffice admin
- analytics business
- securite et exploitabilite de niveau production

Le point cle est le suivant :

**on peut implementer cette architecture en une seule codebase modulaire au debut, mais elle doit etre pensee comme un systeme de domaines separables.**

## 2. Principes d'architecture

### 2.1 Principes directeurs

- source de verite unique pour reservations, stock et finance
- domaine metier explicite, pas de logique critique dans le mobile
- architecture event-driven pour les effets secondaires
- APIs synchrones pour les cas transactionnels, events async pour le reste
- separation stricte entre lecture publique, operations partenaires, operations admin et workflows financiers
- moteur de planning explicable et auditable
- multi-tenant leger cote partenaires
- exploitation simple au debut, evolutive ensuite

### 2.2 Style cible

Je recommande une architecture **modular monolith first, service-ready by design** :

- un repo principal
- plusieurs modules metier fortement encapsules
- contrats API internes stables
- events de domaine publies via outbox
- possibilite d'extraire certains modules en services independants plus tard

Ce style est plus professionnel qu'un monolithe "plat", et beaucoup plus maitrisable qu'un parc de microservices premature.

## 3. Topologie cible

## 3.1 Vue d'ensemble

### Couche d'entree

- Mobile App Flutter
- Admin Web
- Partner Portal Web
- API Gateway / Edge

### Couche applicative

- Identity & Access
- Traveler Profile
- Catalog
- Search & Discovery
- Availability & Inventory
- Pricing
- Planner & Recommendation Engine
- Booking Orchestrator
- Payment Service
- Insurance Connector
- Partner Management
- Reviews & Trust
- Notification Service
- Support & Incident
- Admin & Governance
- Analytics & Finance

### Couche de donnees

- PostgreSQL principal
- Redis
- Object storage
- Search index
- Event store leger via outbox/inbox
- Data mart analytique

## 3.2 Deploiement logique

### Deployable 1 - Core API

Contient :

- auth applicative
- traveler profile
- catalog
- bookings
- partner portal
- admin endpoints

### Deployable 2 - Planning Engine

Contient :

- filtrage candidats
- scoring
- optimisation d'itineraire
- simulation budget
- generation de variantes

### Deployable 3 - Worker / Integrations

Contient :

- notifications
- paiements async
- assurance
- imports catalogue
- recalcul analytics

### Deployable 4 - Search / Analytics

Peut rester interne au debut, puis etre specialise si le volume augmente.

## 3.3 Infra cible

- API containers sur Kubernetes ou equivalent managé si volume fort
- PostgreSQL managé
- Redis managé
- storage objet compatible S3
- queue robuste
- observabilite centralisee
- CDN pour assets
- WAF / rate limiting edge

Pour votre stade actuel, Supabase + Render/Fly + Redis + Sentry est suffisant. L'important est que les modules soient deja bien separes.

## 4. Domaines metier / bounded contexts

## 4.1 Identity & Access

Responsabilites :

- inscription, connexion, social login si besoin
- gestion JWT et refresh tokens
- RBAC et permissions fines
- statuts comptes
- MFA admin/partenaires

Principales entites :

- `users`
- `roles`
- `permissions`
- `user_role_assignments`
- `sessions`
- `auth_audit_logs`

## 4.2 Traveler Profile & Preferences

Responsabilites :

- profil voyageur durable
- preferences de voyage
- historique de comportement
- contraintes de mobilite, langue, alimentation

Entites :

- `traveler_profiles`
- `traveler_companions`
- `saved_preferences`
- `wishlists`

## 4.3 Partner Registry & Compliance

Responsabilites :

- onboarding partenaire
- KYC / documents
- verification administrative
- gestion du type de fournisseur

Entites :

- `partners`
- `partner_types`
- `partner_documents`
- `partner_verification_checks`
- `commission_plans`

## 4.4 Catalog

Responsabilites :

- publication du catalogue canonique
- modelisation unifiee des offres
- medias, tags, traduction, contenu editorial

Entites :

- `listings`
- `listing_media`
- `listing_tags`
- `categories`
- `regions`
- `city_zones`
- `poi_landmarks`

Approche pro :

- utiliser un `listing` canonique commun
- ajouter des tables specialisees par type

Exemples :

- `accommodation_products`
- `activity_products`
- `restaurant_products`
- `artisan_products`
- `transport_products`

## 4.5 Availability & Inventory

Responsabilites :

- disponibilites par date et slot
- capacite
- fermeture exceptionnelle
- allotment / stock
- holds temporaires

Entites :

- `inventory_resources`
- `availability_calendars`
- `availability_slots`
- `booking_holds`
- `blackout_dates`

Exigence pro :

- la reservation ne doit jamais lire un "nombre approximatif"
- elle doit verrouiller une ressource precise ou un stock agrege fiable

## 4.6 Pricing

Responsabilites :

- prix de base
- regles saisonnieres
- prix par groupe
- frais plateforme
- promotions
- couponing
- commission partenaire

Entites :

- `price_books`
- `pricing_rules`
- `season_definitions`
- `promotion_campaigns`
- `coupon_redemptions`
- `fee_policies`

## 4.7 Search & Discovery

Responsabilites :

- recherche texte
- filtres
- ranking catalogue
- suggestions contextuelles

Entites :

- `search_documents`
- `search_synonyms`
- `search_click_logs`

## 4.8 Planner & Recommendation

Responsabilites :

- pre-filtrage
- scoring
- allocation budget
- assemblage des jours
- optimisation de parcours
- generation de variantes
- explications du plan

Entites :

- `trips`
- `trip_preferences`
- `planning_constraints`
- `recommendation_runs`
- `itineraries`
- `itinerary_days`
- `itinerary_items`
- `itinerary_versions`

## 4.9 Booking Orchestrator

Responsabilites :

- panier et conversion en reservation
- coordination multi-items
- verification de stock
- gestion des statuts
- annulation

Entites :

- `bookings`
- `booking_items`
- `booking_status_history`
- `booking_documents`

## 4.10 Payments & Finance

Responsabilites :

- intention de paiement
- capture
- remboursement
- ledger
- commission
- payout partenaires

Entites :

- `payments`
- `payment_attempts`
- `refunds`
- `finance_ledger_entries`
- `partner_settlements`
- `payout_batches`

## 4.11 Insurance

Responsabilites :

- devis assurance
- souscription
- policy document
- synchronisation assureur

Entites :

- `insurance_options`
- `insurance_quotes`
- `insurance_subscriptions`
- `insurance_events`

## 4.12 Reviews & Trust

Responsabilites :

- avis
- moderation
- verifications de consommation
- reputations partners

## 4.13 Notifications

Responsabilites :

- email
- push
- SMS si besoin
- centre de notifications
- templates

## 4.14 Support & Incidents

Responsabilites :

- tickets
- litiges
- incidents ops
- escalades

## 4.15 Admin & Governance

Responsabilites :

- moderation globale
- validation catalogues
- supervision reservations
- audit et conformite

## 4.16 Analytics & BI

Responsabilites :

- revenu
- commission
- conversion
- rentabilite par region
- impact local
- performance partenaires

## 5. Architecture de donnees professionnelle

## 5.1 Base transactionnelle

Choix :

- PostgreSQL comme source de verite principale

Pourquoi :

- integrite relationnelle
- transactions ACID
- contraintes fortes
- vues materialisees
- partitionnement si besoin

## 5.2 Extensions recommandees

- `uuid-ossp` ou `pgcrypto`
- `pg_trgm`
- full-text search
- `postgis` quand la logique geo devient plus fine

## 5.3 Strategie de separation lecture/ecriture

Production grade :

- ecriture sur tables transactionnelles
- vues denormalisees pour la lecture catalogue
- projection search distincte
- data mart analytique distinct

## 5.4 Partitionnement futur

Si volume important :

- partitionner `payments`, `audit_logs`, `notifications`, `booking_status_history` par mois
- index composites sur `region_id`, `city_zone_id`, `date`, `status`

## 6. Contrats synchrones et asynchrones

## 6.1 APIs synchrones

Utiliser REST pour :

- login
- lecture catalogue
- disponibilite
- generation d'itineraire a la demande
- creation reservation
- init paiement
- operations admin et partner

## 6.2 Events asynchrones

Publier des events de domaine :

- `partner.approved`
- `listing.published`
- `itinerary.generated`
- `booking.created`
- `booking.confirmed`
- `payment.succeeded`
- `payment.failed`
- `insurance.subscribed`
- `review.created`
- `support.ticket.opened`

Utiliser le pattern outbox :

- ecrire l'event dans la meme transaction DB
- un worker publie ensuite l'event

Cela evite les incoherences.

## 7. Moteur de planning professionnel

## 7.1 Difference entre "recommandation" et "planning"

Un moteur professionnel doit faire 4 niveaux :

1. **Eligibility**
2. **Ranking**
3. **Scheduling**
4. **Feasibility validation**

La plupart des applications s'arretent au ranking. Une application de planning pro doit aller jusqu'a l'ordonnancement.

## 7.2 Entrees du moteur

- dates du voyage
- heure et lieu d'arrivee
- heure et lieu de depart
- budget total
- repartition du groupe
- rythme souhaite
- niveau physique
- confort
- centres d'interet ponderes
- regions obligatoires / interdites
- contraintes enfant / senior / accessibilite
- saison
- disponibilites reelles
- temps de trajet
- priorite local / authentique
- score d'impact local

## 7.3 Modele de contraintes

### Contraintes dures

- dates compatibles
- stock disponible
- horaires d'ouverture
- capacite
- check-in / check-out
- budget max absolu
- distance max par slot
- difficulte compatible
- temps de trajet compatible avec l'heure

### Contraintes souples

- preferer le local
- preferer les zones moins visibles
- reduire les changements d'hotel
- reduire la fatigue
- maximiser la coherence thematique
- maximiser le score review / qualite

## 7.4 Moteur de resolution recommande

### Niveau 1

- regles + scoring deterministe

### Niveau 2

- optimisation combinatoire avec OR-Tools CP-SAT ou solveur equivalent

Ce solveur sert a :

- placer les items dans les slots horaires
- respecter les fenetres de temps
- minimiser le temps perdu en transport
- maximiser la satisfaction / impact local
- garder le budget sous controle

## 7.5 Structure d'un planning journalier

Chaque jour contient :

- debut de jour / hotel de depart
- slots temporels
- buffers
- repas
- activites
- artisanat / shopping
- transferts
- hotel d'arrivee

### Types de slots

- `arrival_transfer`
- `check_in`
- `breakfast`
- `morning_activity`
- `lunch`
- `afternoon_activity`
- `artisan_stop`
- `rest_buffer`
- `intercity_transfer`
- `dinner`
- `check_out`
- `departure_transfer`

## 7.6 Logique precise du premier jour

Le premier jour doit etre gere comme un mini workflow operationnel :

1. detecter aeroport, gare ou point d'arrivee
2. chercher hotel dans la premiere zone logique
3. inserer transfert arrivee -> hotel
4. comparer heure d'arrivee avec `check_in_from`
5. si chambre non disponible : deposer bagages, planifier cafe / dejeuner / balade courte
6. calculer energie restante du groupe
7. n'autoriser qu'une activite soft si arrivee tardive
8. choisir un diner proche, ouvert, compatible budget
9. garantir retour a l'hotel avant heure cible

Regles exemple :

- arrivee avant 11h : activite legere possible avant check-in si bagagerie
- arrivee 11h-15h : dejeuner + check-in + activite soft courte
- arrivee 15h-18h : check-in + balade / artisan / rooftop / diner
- arrivee apres 18h : transfert + check-in + diner uniquement

## 7.7 Logique des jours intermediaires

### Jour standard

- matin : activite principale
- midi : restaurant a moins de X minutes
- apres-midi : experience complementaire
- fin de journee : pause / atelier / shopping local
- soir : diner + retour hotel

### Jour de transition de region

- check-out
- transfert inter-region
- activite reduite
- check-in nouvelle zone
- diner de proximite

### Dernier jour

- check-out
- activite courte uniquement si marge suffisante
- transfert depart avec buffer de securite

## 7.8 Allocation budgetaire professionnelle

Le budget est gere a trois niveaux :

- budget total voyage
- budget journalier cible
- budget par categorie

Le moteur garde :

- budget consomme
- budget reserve
- budget restant
- ecart a la cible

Penalites :

- depassement du budget global
- concentration excessive des depenses au debut
- activite premium alors qu'un trajet important arrive ensuite

## 7.9 Score d'impact local

Le score ne doit pas etre marketing seulement. Il doit etre calculable.

Exemple de composantes :

- poids de depense allant a partenaires locaux independants
- proportion de nuites dans petits hebergements
- nombre d'artisans integres
- part des regions sous-exposees
- utilisation de guides / transporteurs locaux

Le moteur peut alors optimiser :

- satisfaction voyageur
- faisabilite
- impact local

## 7.10 Explicabilite

Chaque recommandation doit pouvoir renvoyer :

- pourquoi cet hotel
- pourquoi cette activite
- pourquoi cette region
- pourquoi ce restaurant
- pourquoi cette transition de trajet

Stocker des `explanation_codes` par item :

- `matches_budget`
- `near_hotel`
- `family_friendly`
- `high_local_impact`
- `fits_arrival_day`
- `open_at_selected_time`

## 8. Recherche et geospatial

## 8.1 Recherche catalogue

Production grade :

- full-text search
- synonymes
- auto-complete
- facettes
- typo tolerance

## 8.2 Geospatial

Fonctions attendues :

- distance hotel -> activite
- activite -> restaurant
- zone -> zone
- temps de trajet estime
- rayon dynamique selon type de groupe

V1 pro :

- Haversine + zone adjacency + cache

V2 pro :

- PostGIS + route service externe ou matrice pre-calculee

## 9. Booking orchestration complete

## 9.1 Modele pro

Un booking peut contenir :

- hotel sur plusieurs nuits
- activites a dates / slots
- transport local et inter-region
- restaurant reservable
- atelier artisan
- assurance

Le backend doit donc agir comme un orchestrateur de sous-reservations.

## 9.2 Workflow detaille

1. utilisateur valide un itineraire
2. systeme cree un `booking draft`
3. systeme evalue chaque item
4. systeme pose des `holds`
5. systeme recalcule prix final
6. systeme ajoute frais / commissions / assurance
7. systeme passe en `pending_payment`
8. paiement reussi
9. systeme confirme les items
10. si un item echoue :
   - fallback, remplacement ou compensation selon strategie

## 9.3 Strategie de resilience

Trois strategies possibles :

- `strict_all_or_nothing`
- `allow_partial_confirmation`
- `substitute_if_possible`

Pour une application pro, je recommande :

- hotel : strict
- transport critique : strict
- restaurant / activité secondaire : substituable si l'utilisateur l'accepte

## 9.4 Etats detailles

### Booking

- `draft`
- `quoted`
- `pending_inventory`
- `pending_payment`
- `paid`
- `partially_confirmed`
- `confirmed`
- `cancellation_requested`
- `cancelled`
- `refund_pending`
- `refunded`
- `expired`
- `failed`

### Booking item

- `draft`
- `held`
- `awaiting_partner_confirmation`
- `confirmed`
- `substituted`
- `cancelled`
- `refunded`
- `failed`

## 9.5 Annulations

Les annulations doivent gerer :

- politiques par item
- politiques par partenaire
- politiques plateforme
- annulation partielle
- recalcul commissions
- impact assurance

## 10. Paiements, ledger et finance

## 10.1 Architecture financiere

Pour un systeme pro, il faut un vrai ledger interne, meme simple.

Tables cles :

- `finance_ledger_entries`
- `payment_attempts`
- `refunds`
- `partner_settlements`
- `commission_ledger`

Chaque evenement financier devient une ecriture.

## 10.2 Regles clefs

- jamais faire confiance aux montants du client
- idempotency pour tous appels paiement
- capture seulement apres verification metier
- signature webhook obligatoire
- double trace : transaction PSP + ecriture interne

## 10.3 Revenus partenaires

Le systeme doit savoir calculer :

- montant brut
- commission plateforme
- frais payment
- taxes eventuelles
- net partenaire
- payout date

## 11. Assurance embarquee

## 11.1 Architecture d'integration

Utiliser un adapter :

- `InsuranceProviderAdapter`
- `quote()`
- `subscribe()`
- `cancel()`
- `fetch_policy()`

## 11.2 Resilience

- retries
- circuit breaker leger
- journal brut des payloads
- correlation booking / police
- decouplage avec paiement principal

## 11.3 Cas operationnels

- assurance souscrite avec succes
- devis obtenu mais paiement non finalise
- booking confirme sans assurance
- annulation booking impliquant annulation police

## 12. Portail partenaires professionnel

## 12.1 Capacites attendues

- onboarding legal
- gestion des offres
- calendrier de disponibilites
- regles de prix
- reservations a traiter
- reporting
- documents
- litiges

## 12.2 Permissions

- `partner_owner`
- `partner_finance`
- `partner_ops`
- `partner_content`
- `partner_staff_readonly`

## 12.3 Workflows critiques

- soumission offre -> validation admin -> publication
- modification majeure -> revalidation optionnelle
- reservation -> confirmation partenaire si mode manuel
- facture / voucher / settlement

## 13. Admin platform professionnelle

## 13.1 Domaines admin

- partner compliance
- catalog governance
- trust & safety
- booking ops
- finance ops
- support ops
- business analytics

## 13.2 Roles admin

- `super_admin`
- `ops_admin`
- `support_admin`
- `content_admin`
- `finance_admin`
- `compliance_admin`

## 13.3 Outils essentiels

- file d'attente validation partenaires
- moderation catalogue
- timeline booking complete
- replay webhooks
- centre incidents
- ecrans remboursements
- dashboards commissions / regions / impact local

## 14. API design professionnel

## 14.1 Principes

- versioning `v1`
- ids opaques UUID
- pagination cursor
- filtres whitelistes
- `Idempotency-Key` sur endpoints critiques
- correlation id dans les headers

## 14.2 Groupes d'endpoints

### Public discovery

- `GET /v1/catalog/search`
- `GET /v1/catalog/regions`
- `GET /v1/catalog/categories`
- `GET /v1/listings/:id`

### Planning

- `POST /v1/trips`
- `PATCH /v1/trips/:id/preferences`
- `POST /v1/trips/:id/generate-itinerary`
- `POST /v1/itineraries/:id/optimize`
- `POST /v1/itineraries/:id/quote`
- `GET /v1/itineraries/:id/explanations`

### Availability / pricing

- `POST /v1/availability/check`
- `POST /v1/pricing/quote`

### Booking

- `POST /v1/bookings`
- `POST /v1/bookings/:id/hold`
- `POST /v1/bookings/:id/checkout`
- `POST /v1/bookings/:id/cancel`
- `GET /v1/bookings/:id/timeline`

### Payments

- `POST /v1/payments/intents`
- `POST /v1/payments/webhooks/provider`
- `POST /v1/payments/:id/refund`

### Insurance

- `GET /v1/insurance/options`
- `POST /v1/insurance/quotes`
- `POST /v1/insurance/subscriptions`

### Partner

- `GET /v1/partner/dashboard`
- `POST /v1/partner/listings`
- `POST /v1/partner/availability`
- `POST /v1/partner/pricing-rules`
- `GET /v1/partner/bookings`
- `GET /v1/partner/settlements`

### Admin

- `GET /v1/admin/partners`
- `POST /v1/admin/partners/:id/approve`
- `GET /v1/admin/bookings`
- `GET /v1/admin/incidents`
- `POST /v1/admin/reviews/:id/moderate`
- `GET /v1/admin/finance/ledger`

## 15. Recherche, cache et performance

## 15.1 Cache

Redis pour :

- sessions courtes
- rate limiting distribue
- cache search / catalog
- distance matrix
- recommendation fragments
- job queues

## 15.2 Performance cible

- lecture catalogue p95 < 300 ms
- disponibilite / quote p95 < 500 ms
- generation itineraire simple p95 < 2 s
- generation optimisee complexe p95 < 5 s

## 15.3 Techniques

- index SQL adaptes
- projections denormalisees
- precomputation zone metrics
- generation async pour gros itineraires

## 16. Securite de niveau production

## 16.1 IAM

- RBAC strict
- separation admin / partner / traveler
- MFA pour roles sensibles

## 16.2 Token strategy

- access token court
- refresh token rotatif
- revocation list ou session store

## 16.3 Protection API

- WAF
- rate limit
- bot protection sur login / booking
- payload validation stricte

## 16.4 Protection donnees

- chiffrement at rest
- secrets management
- redact logs
- urls signees pour fichiers prives
- retention policies

## 16.5 Audit

Journaliser :

- changements de role
- validations partenaires
- modifications prix
- remboursements
- moderation
- consultations sensibles

## 17. Observabilite et operations

## 17.1 Logging

- JSON logs
- correlation id
- trace id
- user id / partner id / booking id si disponible

## 17.2 Metrics

- volume recherches
- taux generation itineraire
- taux conversion
- taux conflits disponibilite
- paiements echoues
- confirmation partenaire

## 17.3 Tracing

- tracer bout en bout generation booking -> payment -> notification

## 17.4 Runbooks

Prevoir des runbooks pour :

- webhook paiement en erreur
- stock negatif detecte
- itineraire generation timeout
- partenaire non repondant
- remboursement manuel

## 18. Analytics et impact local

## 18.1 KPIs business

- GMV
- take rate
- conversion trip -> booking
- panier moyen
- repeat booking
- revenu par region

## 18.2 KPIs impact local

- part revenu vers petits acteurs
- nombre artisans exposes
- nuits dans hebergements independants
- repartition du revenu par region
- progression des regions moins visibles

## 19. Roadmap d'implementation depuis l'existant

## 19.1 Phase 1 - refondation backend

- garder l'app Flutter
- introduire Core API
- migrer la recommandation cote serveur
- creer tables manquantes

## 19.2 Phase 2 - planning vraiment professionnel

- contraintes horaires
- distance matrix
- templates de jour
- explications de recommandations
- versioning d'itineraires

## 19.3 Phase 3 - reservations reelles

- holds
- quote pricing
- paiement reel
- assurance
- workflows partenaires

## 19.4 Phase 4 - production grade

- outbox/events
- Redis
- observabilite complete
- ledger financier
- BI et impact local

## 20. Recommandation finale

Si l'objectif est une **application de planning professionnelle complete**, la cible ne doit pas etre "une app Flutter avec un peu de SQL derriere".

La cible doit etre :

- un **coeur transactionnel PostgreSQL**
- un **Core API modulaire**
- un **Planner Engine** specialise
- un **Booking Orchestrator**
- un **systeme finance/paiement traceable**
- un **adapter assurance**
- un **portail partenaires**
- un **backoffice admin et ops**
- une **observabilite complete**

### Choix tranche

Pour votre projet je recommande :

- **FastAPI** pour Core API et Planning Engine
- **PostgreSQL** comme source de verite
- **Redis** pour queue/cache/holds
- **Supabase** utile au depart pour Auth + DB + Storage
- **REST + events de domaine**
- **OR-Tools** en evolution du moteur de planning
- **ledger interne** pour la finance

### Ce que cela vous donne

- une architecture pro
- fonctionnelle bout en bout
- realiste pour une startup
- evolutive vers une vraie marketplace de tourisme intelligent

## 21. Lien avec l'existant

Les fichiers actuels utiles comme base sont :

- [README.md](/mnt/c/Users/jawhe/Downloads/travel/hkeyetna/README.md)
- [20260420190000_init.sql](/mnt/c/Users/jawhe/Downloads/travel/hkeyetna/supabase/migrations/20260420190000_init.sql)
- [recommendation_service.dart](/mnt/c/Users/jawhe/Downloads/travel/hkeyetna/lib/core/services/recommendation_service.dart)
- [planner_form.dart](/mnt/c/Users/jawhe/Downloads/travel/hkeyetna/lib/core/models/planner_form.dart)

Le chemin naturel est :

1. conserver les datasets et l'UX Flutter
2. faire du backend le cerveau metier
3. transformer le planning actuel en moteur serveur avec vraies contraintes
4. brancher ensuite paiements, assurance, partenaires et admin proprement
