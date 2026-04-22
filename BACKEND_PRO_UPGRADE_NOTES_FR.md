# Backend Pro Upgrade Notes

## Ce qui a ete ameliore

Une nouvelle migration Supabase a ete ajoutee :

- [20260422113000_backend_pro_foundation.sql](/mnt/c/users/jawhe/downloads/travel/hkeyetna/supabase/migrations/20260422113000_backend_pro_foundation.sql)

Cette migration renforce l'architecture backend existante sans casser le mode actuel Flutter + Supabase.

## Ameliorations structurelles

### 1. Gouvernance partenaires

Ajout de nouvelles tables :

- `partner_types`
- `partners`
- `partner_documents`

Objectif :

- preparer un vrai portail partenaires
- permettre une relation future entre `places` et proprietaires d'offres
- gerer verification KYC et statuts partenaires

### 2. Gouvernance catalogue

La table `places` a ete enrichie avec :

- `partner_id`
- `review_status`
- `published_at`
- `metadata`

Objectif :

- differencier contenu public et contenu en attente
- preparer validation admin et brouillons partenaires
- rattacher les offres a un acteur economique local

### 3. Disponibilites et prix

Ajout de :

- `availability_slots`
- `pricing_rules`

Objectif :

- sortir progressivement du mode "prix estime" seulement
- preparer un vrai moteur de disponibilite
- supporter prix date, saison, jour de semaine, quantite

### 4. Operations produit

Ajout de :

- `notifications`
- `support_tickets`
- `booking_status_history`
- `audit_logs`

Objectif :

- base propre pour support, backoffice, centre de notifications
- historiser les transitions de reservations
- preparer la tracabilite

### 5. Renforcement transactionnel

`bookings` et `payments` ont ete renforces avec :

- `expires_at`
- `confirmed_at`
- `cancelled_at`
- `metadata`
- `idempotency_key`
- `failure_reason`

Et des contraintes ont ete ajoutees sur :

- `bookings.status`
- `bookings.payment_status`
- `payments.status`

### 6. Logique SQL serveur ajoutee

De nouvelles fonctions/trigger SQL servent maintenant de garde-fous :

- recalcul automatique du total booking depuis `booking_items`
- synchronisation de l'etat du booking a partir des paiements
- horodatage automatique des transitions `confirmed` / `cancelled`
- historisation des changements de statut

Autrement dit, une partie de la logique metier ne depend plus uniquement du mobile.

## Ameliorations de securite et d'acces

De nouvelles policies RLS ont ete ajoutees pour :

- partenaires et documents partenaires
- disponibilites
- regles tarifaires
- notifications
- tickets support
- historique de statut booking

Le point important est que la possession de certaines ressources peut maintenant etre deduite via :

- `is_partner_owned_by_current_user(...)`
- `is_place_owned_by_current_user(...)`

Cela prepare une vraie architecture multi-role.

## Ce que cela change dans la qualite backend

Avant :

- backend surtout centre sur `catalog + auth + bookings`
- logique critique encore cote Flutter
- peu de gouvernance contenu
- pas de vraie base partenaire
- pas de disponibilite exploitable

Apres cette migration :

- la base devient plus proche d'un backend marketplace
- les concepts partenaires, moderation, disponibilite, pricing et support existent
- les statuts booking/paiement sont un peu plus robustes
- la voie est ouverte vers un portail partenaires et un backoffice admin

## Ce qui reste encore a faire pour un backend vraiment pro

Cette amelioration est importante, mais elle ne remplace pas encore un vrai backend applicatif.

Il reste a faire :

### 1. Sortir la logique de planning hors du mobile

Aujourd'hui, l'itineraire est encore genere dans :

- [recommendation_service.dart](/mnt/c/users/jawhe/downloads/travel/hkeyetna/lib/core/services/recommendation_service.dart)

La prochaine vraie etape pro est :

- un service backend de planning / recommendation
- calcul serveur des distances, du budget et des slots
- prise en compte de l'arrivee, check-in, check-out, ouverture et disponibilite

### 2. Introduire un backend applicatif

Il manque encore :

- API metier dediee
- service de booking orchestration
- webhooks paiement
- connecteur assurance
- file async / workers

### 3. Brancher les nouvelles tables dans l'application

La migration cree les briques, mais l'app Flutter ne les utilise pas encore automatiquement.

Il faudra ensuite :

- lier `places.partner_id`
- exploiter `availability_slots`
- utiliser `pricing_rules`
- afficher `notifications`
- ouvrir les `support_tickets`

## Recommandation de suite

La meilleure suite de travail est maintenant :

1. creer un schema API backend pour `partners`, `availability`, `pricing`, `notifications`, `support`
2. deplacer la generation d'itineraires cote serveur
3. remplacer le paiement mock par une orchestration transactionnelle reelle
4. connecter progressivement Flutter a ces nouvelles briques

## Resume

Le projet reste aujourd'hui un systeme **Flutter + Supabase**, mais cette migration le fait evoluer vers une base de **backend professionnel de marketplace tourisme** :

- plus structure
- plus governable
- plus securise
- plus evolutif
- plus pret pour partenaires, admin, planning et reservation reelle
