# Advanced Database Systems Portfolio (MIT 8103)

Individual practical database portfolio for **MIT 8103 Advanced Database Systems**, 2026/2027 academic session.

## Selected case study: ArenaRank

**ArenaRank** is a simulated online multiplayer gaming platform that hosts several competitive games and maintains real-time and historical leaderboards. Players earn points in game sessions, and rankings update continuously.

- **Users:** players (view rankings, track progress), game administrators (manage games, detect cheating) and analysts (study engagement and performance).
- **Major data:** players, games, sessions, scores and achievements.
- **Key operations:** record a score, retrieve the top N players, find a player's rank, award achievements and view score history.

The same case study is used consistently across all five portfolio activities.

## Repository structure

| Folder | Activity | Main contents |
|---|---|---|
| [`portfolio-1-database-design`](portfolio-1-database-design/) | Database design and modelling | ER diagram, `schema.sql`, keys, constraints, normalisation |
| [`portfolio-2-query-optimisation`](portfolio-2-query-optimisation/) | Query processing and optimisation | Seed data, queries, indexes, execution plans before and after, analysis |
| [`portfolio-3-transactions-concurrency`](portfolio-3-transactions-concurrency/) | Transactions and concurrency | Commit and rollback demos, lost update, three control mechanisms |
| [`portfolio-4-nosql`](portfolio-4-nosql/) | NoSQL and advanced data models | Redis sorted-set leaderboard, MongoDB player profiles |
| [`portfolio-5-distributed-cloud`](portfolio-5-distributed-cloud/) | Distributed and cloud database exercise | Replication, hash partitioning, failover, Supabase deployment |

Each folder has its own `README.md` explaining what was implemented, how it was tested, the evidence collected, limitations, a technical reflection and an AI use declaration.

## Technologies

PostgreSQL 16, Redis, MongoDB 7, Docker (Windows), Supabase (managed PostgreSQL), PowerShell, Git and GitHub.

## Summary of key results

| Portfolio | Key result |
|---|---|
| 1 | Six-table relational schema in third normal form, with keys and constraints |
| 2 | Indexes cut Q3 from 196.17 ms to 11.02 ms (about 18x) and Q5 from 77.88 ms to 1.27 ms (about 61x); Q4 showed an unchanged plan |
| 3 | Reproduced a lost update (150 instead of 200) and prevented it with `FOR UPDATE`, `REPEATABLE READ` and an atomic update |
| 4 | Loaded 9,980 real player best scores into a Redis sorted set that matched PostgreSQL; modelled profiles as MongoDB documents |
| 5 | Built a primary and streaming replica, a four-shard hash partitioning demo, a manual failover and a Supabase deployment |

## How to reproduce

Each portfolio folder lists its own reproduction steps. In outline:

1. Install Docker Desktop.
2. Start PostgreSQL (`postgres:16`), then run `portfolio-1-database-design/schema.sql` and `portfolio-2-query-optimisation/seed.sql`.
3. Follow each portfolio's README in order. Portfolios 3, 4 and 5 build on the same database.

## Academic integrity and AI use

AI tools (Claude and ChatGPT) were used as learning aids. Each portfolio README contains an AI Use Declaration stating the tool, what it was used for, and how I verified the output. I ran all commands myself and can explain the submitted work.

## Progress

The commit history shows the work developing across the semester, one portfolio at a time.