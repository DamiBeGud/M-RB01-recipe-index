# recipe-index

API-only Rails8.1.3.1, Ruby3.3.10. `bundle install`; `bundle exec rake unit`.
Native production migration: `bundle exec rails db:migrate`; source versioned DDL only.
Start `bundle exec puma -C config/puma.rb`; PORT defaults to8401, listener0.0.0.0.
Requires DATABASE_URL for an assigned empty logical database on the shared study PostgreSQL server,
SECRET_KEY_BASE and RAILS_ENV=production. 
Liveness /health/live; readiness /ready queries the native domain tables.
POST /ingredients {name,allergen?}; POST /recipes {title,ingredient_ids}; GET /recipes/:id; GET /recipes?ingredient=name&exclude_allergen=name. Native FKs/unique joins; JSON ingredient details.
No automatic migrations, seeds, resets, assets, mail/payment integrations or outbound HTTP.
Unit tests cover domain/input/Rack/auth paths with PG constructors forbidden; they do not prove persistence, concurrency or migration behavior.
AI-assisted researcher-created source; shared Rails scaffold disclosed separately. No deployment files or real credentials.
