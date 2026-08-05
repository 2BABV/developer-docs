# Rate Limiting

To ensure fair usage, all API endpoints are rate limited.

## Limits

| Plan       | Requests per minute | Requests per day |
|------------|--------------------:|-----------------:|
| Standard   | 60                  | 10,000           |
| Premium    | 300                 | 100,000          |

## Response headers

Every API response includes rate limit information in the headers:

```
X-RateLimit-Limit: 60
X-RateLimit-Remaining: 42
X-RateLimit-Reset: 1700000000
```

| Header                  | Description                                      |
|-------------------------|--------------------------------------------------|
| `X-RateLimit-Limit`     | Maximum requests allowed in the current window   |
| `X-RateLimit-Remaining` | Requests remaining in the current window         |
| `X-RateLimit-Reset`     | Unix timestamp when the window resets            |

## Handling 429 errors

When you exceed the rate limit, the API returns `429 Too Many Requests`. Implement exponential backoff and retry after the `Retry-After` header value (in seconds).

```python
import time, requests

def get_with_retry(url, headers, max_retries=3):
    for attempt in range(max_retries):
        response = requests.get(url, headers=headers)
        if response.status_code == 429:
            wait = int(response.headers.get("Retry-After", 2 ** attempt))
            time.sleep(wait)
            continue
        return response
    raise Exception("Rate limit exceeded after retries")
```
