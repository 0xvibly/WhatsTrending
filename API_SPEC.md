# whatstrending.ai API Specification

## Base URL

```
https://whatstrending.ai
```

## Authentication

Protected endpoints require a Bearer token in the `Authorization` header:

```
Authorization: Bearer YOUR_API_KEY_HERE
```

Public endpoints (GET requests) require no authentication.

## Response Format

All API responses use a consistent JSON envelope:

**Success:**
```json
{
  "success": true,
  "data": { ... }
}
```

**Error:**
```json
{
  "success": false,
  "error": "Error description"
}
```

## Article JSON Schema

```json
{
  "id": 1,
  "slug": "openai-announces-gpt-5",
  "title": "OpenAI Announces GPT-5",
  "summary": "Brief summary of the article...",
  "body": "Full article body text...",
  "category": "Models",
  "source": "TechCrunch",
  "source_url": "https://techcrunch.com/...",
  "image_url": "https://example.com/image.jpg",
  "featured": 0,
  "published_at": "2026-04-23 12:00:00",
  "created_at": "2026-04-23 12:00:00",
  "updated_at": "2026-04-23 12:00:00"
}
```

## Categories

- `Models` — AI model announcements and updates
- `Tools` — Developer tools, IDEs, frameworks
- `Research` — Academic papers, safety research, benchmarks
- `Industry` — Regulation, funding, market trends
- `Startups` — Startup news, launches, funding rounds
- `General` — Default category

---

## Endpoints

### List Articles

```
GET /api/articles
```

**Auth:** None (public)

**Query Parameters:**

| Param      | Type   | Default | Description                    |
|------------|--------|---------|--------------------------------|
| `category` | string | —       | Filter by category             |
| `limit`    | number | 50      | Max articles to return         |
| `offset`   | number | 0       | Skip N articles (pagination)   |

**Example:**

```bash
# List all articles
curl https://whatstrending.ai/api/articles

# Filter by category with limit
curl "https://whatstrending.ai/api/articles?category=Models&limit=5"
```

**Response:** `200 OK`
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "slug": "openai-announces-gpt-5",
      "title": "OpenAI Announces GPT-5",
      "summary": "...",
      "body": "...",
      "category": "Models",
      "source": "TechCrunch",
      "source_url": "",
      "image_url": "",
      "featured": 1,
      "published_at": "2026-04-23 12:00:00",
      "created_at": "2026-04-23 12:00:00",
      "updated_at": "2026-04-23 12:00:00"
    }
  ]
}
```

---

### Get Single Article

```
GET /api/articles/:slug
```

**Auth:** None (public)

**Example:**

```bash
curl https://whatstrending.ai/api/articles/openai-announces-gpt-5
```

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "id": 1,
    "slug": "openai-announces-gpt-5",
    "title": "OpenAI Announces GPT-5",
    "summary": "...",
    "body": "...",
    "category": "Models",
    "source": "TechCrunch",
    "source_url": "",
    "image_url": "",
    "featured": 1,
    "published_at": "2026-04-23 12:00:00",
    "created_at": "2026-04-23 12:00:00",
    "updated_at": "2026-04-23 12:00:00"
  }
}
```

**Error:** `404 Not Found`
```json
{
  "success": false,
  "error": "Article not found"
}
```

---

### Create Article

```
POST /api/articles
```

**Auth:** Required (Bearer token)

**Request Body:**

| Field        | Type    | Required | Description                        |
|--------------|---------|----------|------------------------------------|
| `slug`       | string  | Yes      | URL-safe unique identifier         |
| `title`      | string  | Yes      | Article headline                   |
| `summary`    | string  | Yes      | Short description                  |
| `body`       | string  | Yes      | Full article content               |
| `category`   | string  | No       | Category (default: "General")      |
| `source`     | string  | No       | Source publication name             |
| `source_url` | string  | No       | Link to original article           |
| `image_url`  | string  | No       | Featured image URL                 |
| `featured`   | boolean | No       | Whether to feature on homepage     |

**Example:**

```bash
curl -X POST https://whatstrending.ai/api/articles \
  -H "Authorization: Bearer YOUR_API_KEY_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "slug": "new-ai-breakthrough",
    "title": "New AI Breakthrough Announced",
    "summary": "Researchers achieve new milestone in AI capabilities.",
    "body": "Full article text goes here...\n\nSecond paragraph here.",
    "category": "Research",
    "source": "Nature",
    "source_url": "https://nature.com/articles/...",
    "featured": false
  }'
```

**Response:** `201 Created`
```json
{
  "success": true,
  "data": {
    "id": 7,
    "slug": "new-ai-breakthrough",
    "title": "New AI Breakthrough Announced",
    ...
  }
}
```

**Errors:**

| Status | Error                                    |
|--------|------------------------------------------|
| 400    | Missing required fields                  |
| 401    | Unauthorized                             |
| 409    | Article with this slug already exists    |
| 503    | Database not configured                  |

---

### Update Article

```
PUT /api/articles/:id
```

**Auth:** Required (Bearer token)

**Request Body:** Any subset of article fields (only provided fields are updated).

**Example:**

```bash
curl -X PUT https://whatstrending.ai/api/articles/7 \
  -H "Authorization: Bearer YOUR_API_KEY_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Updated Title",
    "featured": true
  }'
```

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "id": 7,
    "title": "Updated Title",
    "featured": 1,
    ...
  }
}
```

**Errors:**

| Status | Error                    |
|--------|--------------------------|
| 400    | No fields to update      |
| 401    | Unauthorized             |
| 404    | Article not found        |
| 503    | Database not configured  |

---

### Delete Article

```
DELETE /api/articles/:id
```

**Auth:** Required (Bearer token)

**Example:**

```bash
curl -X DELETE https://whatstrending.ai/api/articles/7 \
  -H "Authorization: Bearer YOUR_API_KEY_HERE"
```

**Response:** `200 OK`
```json
{
  "success": true,
  "data": {
    "deleted": true,
    "id": 7
  }
}
```

**Errors:**

| Status | Error                    |
|--------|--------------------------|
| 401    | Unauthorized             |
| 404    | Article not found        |
| 503    | Database not configured  |

---

## Error Codes Summary

| HTTP Status | Meaning                |
|-------------|------------------------|
| 200         | Success                |
| 201         | Created                |
| 400         | Bad request            |
| 401         | Unauthorized           |
| 404         | Not found              |
| 409         | Conflict (duplicate)   |
| 500         | Server error           |
| 503         | Service unavailable    |

## CORS

All API responses include CORS headers allowing cross-origin requests:

```
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS
Access-Control-Allow-Headers: Content-Type, Authorization
```

Preflight `OPTIONS` requests return `204 No Content` with CORS headers.

## Notes

- If the D1 database is not yet set up, GET endpoints fall back to sample data. POST/PUT/DELETE return `503`.
- The `featured` field is stored as an integer (0 or 1) in D1. The API accepts booleans in request bodies.
- `published_at`, `created_at`, and `updated_at` default to the current UTC time on creation.
- Slugs must be unique. Use URL-safe strings (lowercase, hyphens).

## Setup

1. Create the D1 database:
   ```bash
   wrangler d1 create whatstrending-db
   ```
2. Copy the returned `database_id` into `wrangler.toml`.
3. Run the migration:
   ```bash
   wrangler d1 execute whatstrending-db --file=./migrations/0001_init.sql
   ```
4. Deploy:
   ```bash
   wrangler deploy
   ```
