# Marketplace Database

A relational database schema for a second-hand IT marketplace, modeled after Sweclockers Marknad.

This was my **first database lab**, built during the course *Databaser* in December 2025. The focus was on database modeling — designing tables, defining relationships, choosing constraints, and writing useful queries. The assignment was to analyze a real marketplace and design a schema from scratch that could support it.

## What it does

- Models a full marketplace with users, listings, categories, deals, and reviews
- Supports listing comments, direct messages between users, and image attachments
- Tracks likes on listings via a junction table
- Enforces that reviews can only be written after a completed deal (like Tradera)
- Hierarchical categories with self-referencing parent/child structure

## Structure

- `setup.sql` — creates all tables with constraints and comments explaining each decision
- `tests.sql` — INSERT data and READ queries covering all major use cases
- `structure.png` — ERD diagram of the full schema

## Schema overview

| Table | Description |
|---|---|
| `users` | Registered users with rating and location |
| `categories` | Hierarchical product categories |
| `listings` | Individual sell/buy listings |
| `listing_images` | Images attached to listings |
| `listing_comments` | Public comments on listings |
| `listing_likes` | Junction table for user likes on listings |
| `deals` | Transactions between buyer and seller |
| `reviews` | User reviews, only allowed after a completed deal |
| `messages` | Direct messages between users, optionally tied to a listing |

## Tech

- PostgreSQL
- SQL (DDL + DML)

## Reflection

This was my first time designing a database from scratch. Looking at it now, the schema is fairly solid — the constraint comments, the soft-delete on comments, and the deal-gated reviews were all deliberate choices I'm still happy with. It's an honest snapshot of where I was when I first learned relational modeling.
