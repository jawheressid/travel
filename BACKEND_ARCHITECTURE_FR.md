# Architecture Backend Proposee - HKEYETNA

## 0. Lecture de l'existant

Le projet actuel est une application Flutter + Supabase avec :

- un schema PostgreSQL/Supabase deja initialise
- des donnees de demo riches sur les gouvernorats, places, activites et hebergements
- une logique de recommandation encore principalement cote client dans `lib/core/services/recommendation_service.dart`
- un paiement mock et un parcours de reservation encore simple

Conclusion importante : la bonne trajectoire n'est pas de jeter l'existant, mais de le faire evoluer vers un vrai backend metier. Le MVP peut rester sur Supabase comme socle low-cost, avec une couche API applicative dediee pour sortir la logique critique du mobile.

## 1. Vision backend globale

### Role du backend

Le backend doit devenir le cerveau transactionnel et metier de la plateforme. Il ne doit pas seulement servir des listes de lieux. Il doit :

- centraliser la logique de recommandation et generation d'itineraires
- gerer le catalogue multi-acteurs : hebergements, activites, restaurants, artisans, transport
- controler disponibilites, prix, commissions, reservations, paiements et remboursements
- orchestrer les interactions entre voyageurs, partenaires, admins et assureur
- produire des itineraires coherents en fonction du budget, du temps disponible, des distances et de l'impact local
- tracer les operations sensibles pour la securite, le support et la finance

### Flux principaux

Voyageur :

1. cree un compte ou navigue
2. renseigne profil, budget, dates, style de voyage, centres d'interet, regions
3. demande une recommandation / itineraire
4. recoit un programme jour par jour
5. confirme des elements ou reserve le panier complet
6. ajoute eventuellement une assurance
7. paie
8. recoit confirmations, notifications et support

Partenaire local :

1. cree un compte partenaire
2. soumet ses documents
3. cree ses offres
4. gere disponibilites, prix, demandes et confirmations
5. suit ses revenus et ses statistiques

Admin :

1. valide partenaires et contenus
2. modere les avis
3. suit reservations, incidents et commissions
4. gere categories, regions, prix de reference et analytics

Assureur :

1. expose un catalogue de polices ou devis
2. recoit une demande de souscription
3. renvoie contrat, reference et statut
4. notifie le backend via webhook

### Separation frontend / backend

Frontend :

- collecte des intentions utilisateur
- affichage du catalogue et des itineraires
- UX de reservation, paiement et support
- cache local et experience offline partielle

Backend :

- verite metier
- calcul de prix et disponibilite
- generation de programme intelligent
- gestion des statuts metier
- controle d'acces
- integrations externes
- audit et reporting

### Pourquoi cette architecture est adaptee au MVP puis a la croissance

- elle reutilise l'existant Supabase au lieu d'ajouter trop d'infrastructure
- elle garde un seul coeur metier pour une petite equipe
- elle deplace les regles critiques du mobile vers le serveur
- elle permet une montee en charge progressive sans microservices trop tot
- elle prepare une evolution propre vers services separes si le volume l'exige

## 2. Architecture technique recommandee

### Choix principal

Je recommande un **monolithe modulaire** expose en **API REST**, avec **PostgreSQL** comme source de verite, **Supabase Auth + Postgres + Storage** comme socle gere, et une **couche backend applicative en FastAPI**.

### Pourquoi un monolithe modulaire

Choix :

- un seul backend deployable
- modules metier bien separes
- base de donnees relationnelle unique

Pourquoi :

- equipe reduite
- budget limite
- logique metier fortement liee entre reservations, disponibilites, paiements, partenaires, recommandations
- moins de complexite operationnelle que des microservices

Quand evoluer :

- V2/V3 seulement si le trafic, le catalogue ou les integrations explosent
- premier candidat a separer : moteur de recommandation / pricing / notifications

### Pourquoi REST plutot que GraphQL

REST est preferable au debut car :

- plus simple a documenter
- plus simple pour le mobile, le backoffice admin et le portail partenaires
- plus facile a securiser et journaliser
- plus naturel pour reservations, paiements, webhooks et workflows transactionnels

GraphQL peut attendre si un jour plusieurs clients complexes consomment des vues tres variees.

### Pourquoi FastAPI

Choix :

- FastAPI + SQLAlchemy + Alembic + Pydantic

Pourquoi :

- rapide a mettre en place
- excellent pour API metier + validation stricte
- tres bon pour logique de scoring, recommandation, geolocalisation et regles
- simple a connecter a PostgreSQL et Redis
- documentation OpenAPI automatique utile pour equipe reduite

Alternative solide :

- NestJS si l'equipe est plus forte en TypeScript et veut un cadre tres structure

Dans votre contexte, FastAPI est plus rentable car il couvre bien marketplace + moteur d'itineraire dans une seule stack.

### Base de donnees

Choix MVP :

- PostgreSQL via Supabase

Pourquoi :

- reservations, paiements, disponibilites et commissions sont transactionnels
- besoin de relations claires
- bon support JSONB pour metadonnees flexibles
- possibilite de full-text search
- possibilite d'ajouter PostGIS plus tard

### Recherche / filtres

Ordre recommande :

1. MVP : PostgreSQL full-text + indexes + filtres SQL
2. V2 : `pg_trgm` pour recherche fuzzy et tri plus riche
3. V3 : OpenSearch / Elasticsearch uniquement si le volume et la pertinence le justifient

Pour 2 ou 3 regions au lancement, Elasticsearch est trop tot.

### Cache

Ordre recommande :

1. MVP : pas de Redis obligatoire
2. MVP+ : cache applicatif court pour pages catalogue et suggestions frequentes
3. V2 : Redis pour sessions courtes, rate limit distribue, resultat de scoring, jobs

### Stockage fichiers

Choix :

- Supabase Storage au debut pour coherence et cout
- Cloudinary uniquement si le besoin media explose

Usages :

- photos des offres
- documents KYC partenaires
- justificatifs admin
- polices d'assurance PDF

### Notifications

Choix MVP :

- email transactionnel
- push mobile
- notifications in-app

Implementation :

- table `notifications`
- worker asynchrone
- fournisseurs type Resend/Sendgrid pour email, Firebase pour push

### Traitement asynchrone

Choix :

- worker leger via Celery ou RQ + Redis en V1.1

Pour quoi :

- confirmations par email
- webhooks de paiement / assurance
- recalcul de score
- generation PDF / voucher
- moderation et imports catalogue

### Logs / monitoring

MVP indispensable :

- logs structures JSON
- correlation id par requete
- audit logs pour actions sensibles
- alerting minimum sur erreurs 5xx

Stack simple :

- Sentry pour erreurs applicatives
- Grafana Cloud ou equivalent low-cost pour metriques
- logs plateforme via Render / Fly / Railway / container provider

### Infrastructure cloud petit budget

Architecture conseillee :

- Supabase : Auth + Postgres + Storage
- FastAPI containerise sur Render, Fly.io ou Railway
- cron/jobs simples via meme provider
- Redis seulement quand les jobs ou le cache le justifient

Ordre d'implementation :

1. Supabase comme coeur data
2. FastAPI monolithique
3. CI/CD
4. observabilite
5. worker async
6. Redis
7. moteur de recherche dedie

## 3. Stack technique recommandee

### Stack cible

- API backend : FastAPI
- ORM / migrations : SQLAlchemy 2 + Alembic
- Auth : Supabase Auth ou JWT emis par le backend
- Base : PostgreSQL (Supabase)
- Stockage fichiers : Supabase Storage
- Cache / jobs : Redis
- Asynchrone : Celery ou RQ
- Paiement : abstraction `PaymentProvider` avec Stripe ou PSP local plus tard
- Notifications : Firebase Cloud Messaging + fournisseur email transactionnel
- Infra : Docker
- CI/CD : GitHub Actions
- Monitoring : Sentry + health checks + metriques simples

### Pourquoi cette stack est adaptee

Marketplace / reservation :

- PostgreSQL gere bien les relations, contraintes et transactions
- FastAPI permet d'exposer proprement les workflows de booking/paiement

Moteur de recommandation :

- Python est confortable pour scoring, geospatial, optimisation et evolution vers ML

Tableau de bord admin :

- REST + RBAC + audit logs = tres bon fit

Espace partenaires :

- endpoints clairs, formulaires, moderation et disponibilites bien gerables avec une API REST

Budget limite :

- peu de services payants au debut
- Supabase remplace plusieurs briques

Evolution future :

- extraction facile du moteur de recommandation en service separe
- ajout facile de workers et Redis
- ajout de recherche dediee seulement si necessaire

## 4. Modele metier backend

Le schema actuel est une bonne base de demo, mais il faut l'etendre. Il faut conserver `profiles`, `governorates`, `categories`, `places`, `bookings`, `payments`, `reviews`, `itineraries`, puis ajouter de vraies tables metier.

### 4.1 Entites principales

#### User

- Role : identite de connexion
- Champs : `id`, `email`, `phone`, `status`, `auth_provider`, `last_login_at`, `created_at`
- Relations : 1-1 avec `TravelerProfile`, 1-1 ou 1-N avec `Partner`, 1-N avec `Booking`, `Review`, `Notification`
- Contraintes : email unique, statut actif/suspendu, suppression logique preferee

#### TravelerProfile

- Role : preferences voyageur et contexte de personnalisation
- Champs : `user_id`, `full_name`, `nationality`, `languages`, `birth_date`, `travel_style_default`, `comfort_level`, `activity_level`, `food_preferences`, `accessibility_needs`, `preferred_budget_range`
- Relations : appartient a `User`, 1-N avec `TripPreference`, `Stay`, `Review`
- Contraintes : donnees sensibles minimales, champs optionnels bien valides

#### Partner

- Role : acteur local vendant une ou plusieurs offres
- Champs : `id`, `user_id`, `partner_type_id`, `legal_name`, `display_name`, `status`, `kyc_status`, `phone`, `email`, `tax_id`, `commission_plan_id`, `region_id`
- Relations : appartient a `User`, a `PartnerType`, possede offres, documents, disponibilites, paiements partenaires
- Contraintes : verification KYC avant publication, statut workflow `draft/pending/approved/rejected/suspended`

#### PartnerType

- Role : typologie partenaire
- Champs : `id`, `code`, `label`
- Relations : 1-N avec `Partner`
- Contraintes : valeurs maitrisees `accommodation`, `activity_provider`, `restaurant`, `artisan`, `transport`, `guide`, `insurance_broker`

#### Region

- Role : gouvernorat ou macro-region
- Champs : `id`, `slug`, `name`, `description`, `latitude`, `longitude`, `is_active`, `priority_score`
- Relations : 1-N avec `CityZone`, `Partner`, `Activity`, `Accommodation`, `Restaurant`, `ArtisanShop`, `TransportOffer`
- Contraintes : slug unique

#### CityZone

- Role : niveau geographique plus fin pour la logique de distance
- Champs : `id`, `region_id`, `name`, `type`, `latitude`, `longitude`, `parent_zone_id`
- Relations : appartient a `Region`, referencee par toutes les offres
- Contraintes : utile pour grouper les activites proches

#### Stay / Trip

- Role : projet de voyage ou sejour en cours de preparation
- Champs : `id`, `user_id`, `title`, `status`, `start_date`, `end_date`, `travelers_count`, `budget_total`, `currency`, `entry_city_zone_id`, `arrival_time`, `departure_time`
- Relations : appartient a `User`, 1-1 ou 1-N avec `TripPreference`, 1-N avec `Itinerary`, `Booking`
- Contraintes : `end_date >= start_date`, statut `draft/generated/quoted/booked/completed/cancelled`

#### TripPreference

- Role : snapshot des preferences pour un sejour
- Champs : `id`, `trip_id`, `travel_type`, `comfort_level`, `pace`, `activity_level`, `preferred_categories`, `preferred_regions`, `avoid_categories`, `must_have_tags`, `budget_flex_percent`, `local_priority_weight`
- Relations : appartient a `Stay`
- Contraintes : ne pas dependre uniquement du profil permanent utilisateur

#### Category

- Role : taxonomie produit
- Champs : `id`, `slug`, `name`, `parent_id`, `kind`
- Relations : liee aux offres et aux tags de recommandation
- Contraintes : slug unique, hierarchie simple

#### Activity

- Role : experience reservable ou recommandable
- Champs : `id`, `partner_id`, `region_id`, `city_zone_id`, `title`, `description`, `duration_minutes`, `difficulty_level`, `capacity`, `base_price`, `currency`, `meeting_point`, `seasonality`, `is_active`, `is_featured`, `local_impact_score`
- Relations : appartient a `Partner`, `Region`, `CityZone`, a des `Availability`, `PricingRule`, `BookingItem`, `Review`
- Contraintes : capacite > 0, duree coherente, publication seulement si partenaire valide

#### Accommodation

- Role : hebergement reservable
- Champs : `id`, `partner_id`, `region_id`, `city_zone_id`, `title`, `type`, `star_level`, `nightly_base_price`, `max_guests`, `check_in_from`, `check_out_until`, `amenities`, `is_active`, `local_impact_score`
- Relations : `Availability`, `PricingRule`, `BookingItem`, `Review`
- Contraintes : capacite, fenetres de check-in/out, inventaire non negatif

#### Restaurant

- Role : restaurant recommandable ou reservable
- Champs : `id`, `partner_id`, `region_id`, `city_zone_id`, `title`, `cuisine_type`, `average_ticket`, `opening_hours`, `reservation_required`, `capacity_per_slot`, `is_active`, `local_impact_score`
- Relations : `Availability`, `BookingItem`, `Review`
- Contraintes : horaires valides, capacite par service

#### ArtisanShop

- Role : boutique ou atelier local
- Champs : `id`, `partner_id`, `region_id`, `city_zone_id`, `title`, `craft_type`, `workshop_supported`, `average_spend`, `opening_hours`, `is_active`, `local_impact_score`
- Relations : `BookingItem` pour ateliers, `Review`
- Contraintes : distinction visite libre / atelier reservable

#### TransportOffer

- Role : transport inter-region ou local
- Champs : `id`, `partner_id`, `origin_zone_id`, `destination_zone_id`, `transport_mode`, `capacity`, `pricing_model`, `base_price`, `price_per_km`, `estimated_duration_minutes`, `is_private`, `is_active`
- Relations : `Availability`, `PricingRule`, `BookingItem`
- Contraintes : mode parmi `private_transfer`, `shared_transfer`, `car_rental`, `bike_rental`, `guide_driver`

#### Itinerary

- Role : programme genere global
- Champs : `id`, `trip_id`, `version`, `status`, `total_estimated_cost`, `local_impact_score`, `distance_km`, `feasibility_score`, `generated_by`
- Relations : appartient a `Stay`, 1-N avec `ItineraryDay`
- Contraintes : versioning utile pour regeneration

#### ItineraryDay

- Role : plan detaille d'une journee
- Champs : `id`, `itinerary_id`, `day_number`, `region_id`, `city_zone_id`, `theme`, `wake_up_hotel_id`, `overnight_hotel_id`, `estimated_cost`, `distance_km`, `notes`
- Relations : 1-N avec `itinerary_slots` ou `itinerary_items`
- Contraintes : jour unique par itineraire

#### Booking

- Role : conteneur transactionnel d'achat
- Champs : `id`, `user_id`, `trip_id`, `status`, `payment_status`, `currency`, `subtotal_amount`, `insurance_amount`, `fees_amount`, `discount_amount`, `commission_amount`, `total_amount`, `expires_at`
- Relations : 1-N avec `BookingItem`, `Payment`, `InsuranceSubscription`
- Contraintes : idempotence, horodatage, expiration des paniers / holds

#### BookingItem

- Role : ligne de reservation
- Champs : `id`, `booking_id`, `item_type`, `resource_id`, `partner_id`, `scheduled_start_at`, `scheduled_end_at`, `quantity`, `unit_price`, `line_total`, `status`, `cancellation_policy_snapshot`
- Relations : appartient a `Booking`, pointe vers `Activity` ou `Accommodation` ou `TransportOffer` ou `Restaurant` ou `ArtisanShop`
- Contraintes : snapshot des prix et politiques au moment d'achat

#### Payment

- Role : transaction financiere
- Champs : `id`, `booking_id`, `provider`, `provider_reference`, `idempotency_key`, `amount`, `currency`, `status`, `paid_at`, `failure_reason`, `raw_response`
- Relations : appartient a `Booking`
- Contraintes : unicite `provider_reference`, webhooks signes, etats controles

#### InsuranceOption

- Role : produit d'assurance affichable
- Champs : `id`, `partner_id`, `code`, `name`, `description`, `coverage_summary`, `price_type`, `base_price`, `percent_of_trip`, `is_active`
- Relations : 1-N avec `InsuranceSubscription`
- Contraintes : versionner les couvertures

#### InsuranceSubscription

- Role : souscription associee a une reservation
- Champs : `id`, `booking_id`, `insurance_option_id`, `status`, `premium_amount`, `provider_reference`, `policy_number`, `subscribed_at`, `policy_document_url`, `raw_payload`
- Relations : appartient a `Booking`, `InsuranceOption`
- Contraintes : decoupler la vie de la police du paiement principal

#### Review

- Role : confiance et preuve sociale
- Champs : `id`, `user_id`, `booking_item_id`, `resource_type`, `resource_id`, `rating`, `comment`, `status`, `moderation_reason`
- Relations : appartient a `User`, peut se rattacher a une offre et a un `BookingItem`
- Contraintes : review seulement apres consommation si voulu, moderation possible

#### Availability

- Role : stock reservable
- Champs : `id`, `resource_type`, `resource_id`, `date`, `start_time`, `end_time`, `capacity_total`, `capacity_reserved`, `is_closed`, `min_booking_notice_hours`
- Relations : liee a toutes les ressources reservables
- Contraintes : capacite reservee <= capacite totale, verrouillage transactionnel

#### PricingRule

- Role : variation de prix
- Champs : `id`, `resource_type`, `resource_id`, `rule_type`, `date_from`, `date_to`, `days_of_week`, `season_code`, `min_guests`, `max_guests`, `adjustment_type`, `adjustment_value`
- Relations : liee aux offres
- Contraintes : ordre d'application clair, conflits de regles geres

#### Admin

- Role : identite backoffice
- Champs : `id`, `user_id`, `role`, `status`, `last_login_at`
- Relations : actions sur partenaires, contenu, incidents, reviews
- Contraintes : roles stricts, MFA recommande

#### Notification

- Role : messages systeme et transactionnels
- Champs : `id`, `user_id`, `channel`, `type`, `title`, `body`, `payload`, `status`, `sent_at`, `read_at`
- Relations : appartient a `User`
- Contraintes : reutilisable pour voyageur, partenaire, admin

#### SupportTicket

- Role : support client / partenaire / incident ops
- Champs : `id`, `requester_user_id`, `booking_id`, `partner_id`, `category`, `priority`, `status`, `subject`, `description`, `assigned_admin_id`, `resolved_at`
- Relations : vers `Booking`, `Partner`, `Admin`
- Contraintes : statuts `open/in_progress/waiting_customer/resolved/closed`

### 4.2 Tables additionnelles fortement conseillees

- `partner_documents`
- `audit_logs`
- `booking_holds`
- `commission_ledger`
- `partner_payouts`
- `webhook_events`
- `recommendation_runs`
- `distance_matrix_cache`

## 5. Modules backend

### Auth & Users

- Responsabilites : inscription, login, refresh token, profils, roles
- Endpoints : `POST /auth/register`, `POST /auth/login`, `POST /auth/refresh`, `GET /users/me`, `PATCH /users/me/profile`
- Logique : gestion JWT, session, suspension, onboarding profile
- Dependances : notifications, traveler profile
- Priorite : MVP

### Recommendation Engine

- Responsabilites : scoring des offres, generation itineraire, reranking
- Endpoints : `POST /recommendations/trips`, `POST /recommendations/itineraries/generate`, `POST /recommendations/itineraries/:id/regenerate`
- Logique : regles, budget split, filtres de distance, score local, saison
- Dependances : catalog, pricing, availability, trips
- Priorite : MVP

### Catalog Management

- Responsabilites : lecture catalogue public, details offres, recherche, filtres
- Endpoints : `GET /catalog/search`, `GET /activities`, `GET /accommodations`, `GET /restaurants`, `GET /artisans`, `GET /transport-offers`
- Logique : lecture seule, tri, pagination, featured
- Dependances : partners, reviews, availability
- Priorite : MVP

### Booking Management

- Responsabilites : panier, holds, reservation, confirmation, expiration
- Endpoints : `POST /bookings`, `GET /bookings/:id`, `POST /bookings/:id/items`, `POST /bookings/:id/confirm`, `POST /bookings/:id/cancel`
- Logique : creation hold, validation stock, snapshots prix
- Dependances : availability, payments, insurance
- Priorite : MVP

### Pricing & Availability

- Responsabilites : inventaire, regles de prix, saisonnalite, checks
- Endpoints : `GET /availability/check`, `POST /partner/availability`, `POST /partner/pricing-rules`
- Logique : calcul du prix final et detection conflits
- Dependances : catalog, bookings, partner portal
- Priorite : MVP

### Trip Builder

- Responsabilites : creation du sejour, preferences, versions d'itineraire
- Endpoints : `POST /trips`, `PATCH /trips/:id/preferences`, `GET /trips/:id/itinerary`
- Logique : conservation du contexte voyageur
- Dependances : recommendation engine
- Priorite : MVP

### Payment & Transactions

- Responsabilites : intention de paiement, capture, webhook, remboursement
- Endpoints : `POST /payments/checkout-session`, `POST /payments/webhook`, `POST /payments/:id/refund`
- Logique : idempotence, verification montant, journal transactionnel
- Dependances : bookings, finance, notifications
- Priorite : MVP

### Insurance Integration

- Responsabilites : devis, offre, souscription, webhooks assureur
- Endpoints : `GET /insurance/options`, `POST /insurance/quote`, `POST /insurance/subscribe`, `POST /insurance/webhook`
- Logique : resiliente, asynchrone, non bloquante
- Dependances : bookings, payments, notifications
- Priorite : post-MVP court si partenariat pret

### Partner Management

- Responsabilites : onboarding partenaire, KYC, gestion offres, stats
- Endpoints : `POST /partner/onboarding`, `GET /partner/dashboard`, `POST /partner/offers`, `PATCH /partner/offers/:id`
- Logique : publication soumise a validation admin
- Dependances : catalog, admin, documents, bookings
- Priorite : MVP

### Admin Management

- Responsabilites : moderation, validation, exploitation
- Endpoints : `GET /admin/partners`, `POST /admin/partners/:id/approve`, `GET /admin/bookings`, `GET /admin/analytics`
- Logique : workflows de validation, filtres ops
- Dependances : tous les modules
- Priorite : MVP

### Reviews & Trust

- Responsabilites : creation avis, moderation, aggregation notes
- Endpoints : `POST /reviews`, `GET /reviews/resource/:type/:id`, `POST /admin/reviews/:id/moderate`
- Logique : avis lies a experience reelle si voulu
- Dependances : bookings, admin
- Priorite : MVP leger

### Notifications

- Responsabilites : email, push, in-app
- Endpoints : `GET /notifications`, `POST /notifications/test`, `POST /notifications/:id/read`
- Logique : templates et retry async
- Dependances : tous
- Priorite : MVP

### Analytics

- Responsabilites : conversion, panier, regions, impact local, revenu
- Endpoints : `GET /admin/analytics/overview`, `GET /partner/analytics`
- Logique : ETL leger ou vues materialisees
- Dependances : bookings, payments, partners
- Priorite : post-MVP proche

### Content Moderation

- Responsabilites : verif contenus et images, signalements
- Endpoints : `POST /admin/content/:id/approve`, `POST /admin/content/:id/reject`
- Priorite : post-MVP proche

### Support / Incident Management

- Responsabilites : tickets, litiges, incidents
- Endpoints : `POST /support/tickets`, `GET /support/tickets/:id`, `PATCH /admin/support/tickets/:id`
- Priorite : MVP

## 6. Moteur de recommandation et generation d'itineraire

## 6.1 Principe general

Le moteur ne doit pas faire "top N places". Il doit produire un programme faisable.

Il doit combiner :

- contraintes dures
- scoring multicritere
- logique de sequencing journalier
- coherence geographique
- respect du budget

### Contraintes dures

Une offre est exclue si :

- indisponible aux dates demandees
- hors budget de maniere excessive
- inadaptee au groupe
- inadaptee au niveau physique
- hors saison
- trop loin pour le slot considere
- incompatible avec heures d'ouverture

### Variables d'entree

- budget total
- nombre de jours
- date et saison
- point d'arrivee
- heure d'arrivee
- nombre de voyageurs
- type de groupe : solo, couple, famille, amis
- categories preferees
- regions souhaitees
- rythme : slow, balanced, intense
- confort
- niveau physique
- importance du local / authentique
- priorite a l'impact local

## 6.2 MVP : moteur base sur regles

### Etape 1 - Pre-filtrage

Construire des ensembles candidats par type :

- hebergements compatibles avec budget, capacite, confort, region
- activites compatibles avec saison, duree, difficulte, budget et capacite
- restaurants compatibles avec ticket moyen, horaires et type de groupe
- artisans compatibles avec horaires et eventuel format atelier
- transports compatibles avec transitions de region

### Etape 2 - Budget envelope

Decouper le budget total en enveloppes :

- hebergement : 35 a 45 %
- nourriture : 20 a 25 %
- activites : 20 a 30 %
- transport : 10 a 15 %
- buffer / assurance / imprus : 5 a 10 %

Ces pourcentages sont ajustes selon le type de voyage :

- culinaire : plus sur restaurants
- aventure : plus sur activites et transport
- famille : plus sur confort et hebergement

### Etape 3 - Score multicritere

Exemple de score final sur 100 :

- 25 % adequation aux preferences
- 20 % adequation budget
- 15 % proximite geographique
- 10 % disponibilite / faisabilite horaire
- 10 % score qualite / reviews
- 10 % score impact local
- 5 % compatibilite groupe
- 5 % saison / meteo / confort

Formule simple :

`final_score = sum(weight_i * normalized_feature_i) - penalties`

Penalites fortes :

- trop de trajets dans une meme journee
- activite intense juste apres arrivee tardive
- restaurant loin de l'hebergement le soir
- succession incoherente d'offres sans temps de trajet

### Etape 4 - Templates de journee

MVP : generer par patrons horaires.

Jour d'arrivee :

- transfert arrivee -> hotel
- check-in ou depot bagages
- activite legere proche si heure d'arrivee le permet
- restaurant proche de l'hotel

Jour standard :

- matin : activite culturelle / nature / artisanat
- midi : restaurant proche de l'activite
- apres-midi : activite principale
- fin d'apres-midi : pause / artisan / transfert
- soir : restaurant + nuit hotel

Jour de transition de region :

- check-out
- transport inter-region
- dejeuner sur trajet ou a l'arrivee
- activite legere seulement
- check-in nouvel hotel
- diner a faible distance

Dernier jour :

- activite courte
- marge de securite transport
- pas d'activite lourde avant depart

### Etape 5 - Logique UX claire du premier jour

Le backend doit raisonner ainsi :

1. detecter heure d'arrivee
2. affecter d'abord le transfert vers l'hotel
3. verifier fenetre de check-in
4. si arrivee avant check-in : depot bagages + pause cafe/dejeuner proche
5. si arrivee apres 16h : ne proposer qu'une activite soft ou une balade courte
6. choisir le restaurant du soir dans un rayon reduit autour de l'hotel
7. ne jamais mettre un trajet lourd + activite physique forte + restaurant eloigne le meme soir

Exemple de regles :

- `if arrival_time >= 18:00 -> no hard activity on day 1`
- `if family_with_children -> max 2 main stops on day 1`
- `if budget_remaining_day1 < threshold -> choose casual dining near hotel`
- `if distance(activity, hotel) > 20km after 17:00 -> reject`

### Etape 6 - Distance et faisabilite

MVP :

- stocker latitude/longitude
- calcul Haversine
- approximer temps de trajet avec coefficient par type de route

V1.1 :

- table `distance_matrix_cache`
- pre-calcul pour couples de zones frequents

Regles :

- meme demi-journee : privilegier meme `city_zone`
- transition intra-zone : idealement < 20 min
- transition intra-region : idealement < 45 min
- transition inter-region : consommer un vrai slot de journee

### Etape 7 - Construction jour par jour

Pseudo-process :

1. choisir region dominante par jour
2. choisir hotel de nuit
3. placer contraintes fixes : check-in, check-out, transport
4. remplir slots avec candidats scores
5. verifier budget cumule
6. verifier temps de trajet
7. ajouter restaurant proche du dernier point de la journee
8. recalculer coherence globale

### Comment eviter les recommandations incoherentes

- ne jamais melanger 3 regions sur 2 jours
- ne pas mettre un restaurant ferme
- ne pas depasser l'enveloppe budget du jour
- limiter le nombre d'activites intenses consecutives
- respecter l'age, la taille du groupe, la capacite
- imposer des buffers de 30 a 60 min entre slots
- controler horaires reel d'ouverture

## 6.3 Evolution V2 / V3 vers moteur plus intelligent

### V2

- apprendre des choix utilisateurs et reservations reelles
- reranker les options selon conversion
- personnaliser selon profils similaires
- ajuster les poids par segment : couple, famille, aventure, culinaire

Techniques :

- learning-to-rank leger
- embeddings de tags / themes
- features comportementales

### V3

- optimisation sous contraintes plus formelle
- contextual bandits pour l'ordre des suggestions
- prediction de budget reel et probas de conversion

Important :

le coeur doit rester explicable. Dans le tourisme et la reservation, il faut pouvoir expliquer pourquoi un itineraire a ete produit.

## 7. Reservations, transactions et assurance

### Workflow de reservation

1. creation d'un `Booking` en statut `pending`
2. creation des `BookingItem`
3. verification transactionnelle de disponibilite
4. pose d'un hold temporaire si necessaire
5. calcul total, commission, taxes, assurance
6. creation de l'intention de paiement
7. confirmation via webhook PSP
8. passage a `confirmed`

### Statuts metier

Booking :

- `pending` : panier cree, pas encore paye ou confirmation en attente
- `confirmed` : paiement et disponibilites confirms
- `cancelled` : annule avant ou apres paiement
- `refunded` : remboursement partiel ou complet execute
- `failed` : paiement ou confirmation echoue
- `expired` : hold ou paiement expire

Payment :

- `pending`, `authorized`, `paid`, `failed`, `refunded`, `partially_refunded`

InsuranceSubscription :

- `pending_quote`, `pending_payment`, `active`, `cancelled`, `failed`

### Gestion des conflits de disponibilite

Indispensable :

- transaction DB
- `SELECT ... FOR UPDATE` ou mecanisme de verrouillage equivalent
- decrementation atomique de capacite
- expiration automatique des holds

### Annulations et remboursements

Approche :

- stocker la politique de chaque offre dans le snapshot du `BookingItem`
- calculer montant remboursable selon date / heure
- declencher remboursement PSP
- tracer dans `commission_ledger` et `payments`

### Commissions plateforme et revenus partenaires

Calcul recommande :

- commission par item, pas seulement par booking
- snapshot de la commission appliquee au moment de la vente

Tables utiles :

- `commission_ledger`
- `partner_payouts`

### Securiser les transactions

- idempotency key a la creation de paiement
- verification du montant en base avant capture
- webhooks signes
- jamais faire confiance au montant envoye par le client
- journaliser tous les changements de statut

### Integration assureur sans fragilite

Approche :

- couche `InsuranceProviderAdapter`
- appels async avec retries
- stockage brut de la requete / reponse
- si l'assureur tombe, la reservation principale ne doit pas etre corrompue

Strategie :

- le booking principal peut etre `confirmed`
- l'assurance peut rester `pending_quote` ou `failed`
- informer clairement l'utilisateur

## 8. Portail partenaires

### Capacites backend

- creation et edition d'offres
- gestion photos et documents
- disponibilites et prix
- reception demandes et confirmations
- vue reservations a venir
- statistiques simples
- historique des revenus

### Endpoints exemples

- `POST /partner/offers/accommodations`
- `POST /partner/offers/activities`
- `PATCH /partner/offers/:type/:id`
- `POST /partner/availability/bulk`
- `POST /partner/pricing-rules`
- `GET /partner/bookings`
- `POST /partner/bookings/:id/accept`
- `POST /partner/bookings/:id/reject`
- `GET /partner/analytics/summary`
- `POST /partner/documents`

### Roles et permissions

- `partner_owner` : tout gerer
- `partner_manager` : offres, disponibilites, reservations
- `partner_staff` : lecture et operations limitees

Regles :

- seul `partner_owner` soumet KYC ou change infos legales
- publication d'une offre depend d'une validation admin
- un partenaire ne voit que ses propres ressources

## 9. Admin panel backend

### Capacites admin

- validation partenaires
- validation / moderation contenus
- moderation avis
- gestion regions, categories, tags
- supervision reservations et paiements
- suivi commissions et remboursements
- suivi incidents et support
- analytics business
- gestion utilisateurs

### Roles admin

- `super_admin` : tous droits
- `ops_admin` : bookings, incidents, disponibilites
- `support_admin` : tickets, voyageurs, litiges
- `content_admin` : contenus, regions, categories, visuels, avis
- `finance_admin` : paiements, commissions, remboursements, payouts

Chaque action sensible doit laisser une trace dans `audit_logs`.

## 10. Design API REST

### Auth

- `POST /auth/register`
- `POST /auth/login`
- `POST /auth/logout`
- `POST /auth/refresh`
- `POST /auth/forgot-password`

### Users

- `GET /users/me`
- `PATCH /users/me`
- `GET /users/me/preferences`
- `PATCH /users/me/preferences`

### Trips

- `POST /trips`
- `GET /trips/:id`
- `PATCH /trips/:id`
- `PATCH /trips/:id/preferences`
- `GET /trips/:id/itineraries`

### Recommendations

- `POST /recommendations/trips`
- `POST /trips/:id/generate-itinerary`
- `POST /itineraries/:id/regenerate`
- `GET /itineraries/:id`

### Catalog

- `GET /catalog/search`
- `GET /catalog/featured`
- `GET /catalog/regions`
- `GET /catalog/categories`

### Activities

- `GET /activities`
- `GET /activities/:id`
- `GET /activities/:id/availability`

### Accommodations

- `GET /accommodations`
- `GET /accommodations/:id`
- `GET /accommodations/:id/availability`

### Restaurants

- `GET /restaurants`
- `GET /restaurants/:id`

### Artisans

- `GET /artisans`
- `GET /artisans/:id`

### Transport

- `GET /transport-offers`
- `GET /transport-offers/:id`

### Bookings

- `POST /bookings`
- `GET /bookings/:id`
- `POST /bookings/:id/items`
- `POST /bookings/:id/checkout`
- `POST /bookings/:id/cancel`

### Payments

- `POST /payments/checkout-session`
- `POST /payments/webhook`
- `POST /payments/:id/refund`

### Insurance

- `GET /insurance/options`
- `POST /insurance/quote`
- `POST /insurance/subscribe`
- `POST /insurance/webhook`

### Partner portal

- `GET /partner/dashboard`
- `GET /partner/offers`
- `POST /partner/offers`
- `PATCH /partner/offers/:id`
- `POST /partner/availability`
- `POST /partner/pricing-rules`
- `GET /partner/bookings`
- `GET /partner/analytics`

### Admin

- `GET /admin/partners`
- `POST /admin/partners/:id/approve`
- `POST /admin/partners/:id/reject`
- `GET /admin/bookings`
- `GET /admin/payments`
- `GET /admin/analytics`
- `PATCH /admin/catalog/categories/:id`
- `PATCH /admin/catalog/regions/:id`

### Reviews

- `POST /reviews`
- `GET /reviews/resource/:type/:id`
- `POST /admin/reviews/:id/moderate`

### Notifications

- `GET /notifications`
- `POST /notifications/:id/read`

## 11. Securite backend

### Indispensable des le MVP

Authentification :

- access token court
- refresh token rotatif
- invalidation lors de logout ou suspicion

Autorisation :

- RBAC strict
- verification objet par objet

Validation input :

- schemas Pydantic partout
- sanitation des strings
- whitelist de champs filtrables / triables

Protection donnees :

- HTTPS partout
- chiffrement au repos via fournisseur
- minimisation des donnees personnelles
- masquage des informations sensibles dans les logs

Uploads :

- types MIME controles
- taille limitee
- scan antivirus si possible a partir de V1.1
- URLs signees pour acces prive

API hardening :

- rate limiting
- protection brute force login
- CORS strict
- headers de securite

Fraude reservation :

- idempotence
- verification montants cote serveur
- monitoring echecs paiements
- limite d'essais suspects

Traçabilite :

- `audit_logs`
- historique des changements de statut
- correlation id par requete

### Renforcement post-MVP

- MFA pour admins et partenaires
- device fingerprint leger
- scoring de risque paiement
- antivirus systematique sur uploads
- secrets management plus strict
- chiffrement applicatif de certains champs
- SIEM ou centralisation avancée des logs

## 12. Roadmap pragmatique

### MVP reel en 3 etapes

#### Etape A - solidifier l'existant

- garder Supabase
- ajouter backend FastAPI
- sortir la recommandation du mobile
- etendre le schema avec `partners`, `city_zones`, `availability`, `pricing_rules`, `trips`, `trip_preferences`, `notifications`, `support_tickets`

#### Etape B - reservation credible

- panier + booking items
- checks de disponibilite transactionnels
- paiements reels ou semi-reels
- commission item-level
- portail partenaire minimal

#### Etape C - operations et croissance

- worker async
- insurance adapter
- analytics business
- moderation et audit logs

## 13. Recommandation finale tranchee

Pour ce projet, la meilleure architecture backend n'est pas un ensemble de microservices complexes.

La meilleure architecture est :

- **Supabase comme plateforme data et auth**
- **un backend FastAPI monolithe modulaire**
- **PostgreSQL comme source de verite**
- **un moteur d'itineraire a regles explicables cote serveur**
- **des workflows transactionnels solides pour booking, paiement et assurance**
- **un portail partenaire et un backoffice admin bases sur les memes APIs**

Cette approche est :

- assez rapide pour un MVP
- assez propre pour une vraie production
- assez economique pour une startup
- assez evolutive pour une marketplace tourisme ambitieuse

## 14. Point critique par rapport au code actuel

Aujourd'hui, la logique dans `recommendation_service.dart` est utile pour la demo, mais trop legere pour la production car :

- elle score surtout sur prix et tags simples
- elle ne gere pas vraiment check-in, check-out, slots reels, ouverture, capacite ni conflits
- elle ne traite pas les vraies transitions transport
- elle vit cote client, donc elle est difficile a gouverner, securiser et faire evoluer

La priorite backend numero 1 est donc :

**deplacer la generation d'itineraire et les decisions de faisabilite cote serveur**.

Si besoin, la suite logique du projet est :

1. dessiner le schema SQL cible v2
2. definir les contrats API
3. implementer le module `Trips + Recommendation + Booking`
4. brancher le mobile Flutter dessus progressivement
